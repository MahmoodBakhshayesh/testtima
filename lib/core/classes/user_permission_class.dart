/// One available permission definition (from the catalog)
class PermissionDefinition {
  final String value; // human readable, e.g. "comment"
  final int flag;     // power of two

  const PermissionDefinition({required this.value, required this.flag});

  factory PermissionDefinition.fromJson(Map<String, dynamic> json) =>
      PermissionDefinition(
        value: (json['value'] ?? '').toString(),
        flag: (json['flag'] ?? 0) as int,
      );

  Map<String, dynamic> toJson() => {'value': value, 'flag': flag};
}

/// Catalog of all possible permissions, grouped by area (dynamic keys)
class PermissionCatalog {
  final Map<String, List<PermissionDefinition>> areas;

  const PermissionCatalog({required this.areas});

  factory PermissionCatalog.fromJson(Map<String, dynamic> json) {
    final map = <String, List<PermissionDefinition>>{};
    json.forEach((area, list) {
      map[area] = (list as List)
          .map((e) => PermissionDefinition.fromJson(e as Map<String, dynamic>))
          .toList();
    });
    return PermissionCatalog(areas: map);
  }

  Map<String, dynamic> toJson() =>
      areas.map((k, v) => MapEntry(k, v.map((e) => e.toJson()).toList()));

  /// Find a definition by its display value (case-insensitive).
  PermissionDefinition? findByValue(String area, String value) {
    final defs = areas[area];
    if (defs == null) return null;
    final needle = value.trim().toLowerCase();
    return defs.firstWhere(
          (d) => d.value.trim().toLowerCase() == needle,
      orElse: () => null as PermissionDefinition,
    );
  }

  /// Get all flags available for an area (handy for validation/UI).
  List<int> flagsOf(String area) => areas[area]?.map((d) => d.flag).toList() ?? const [];
}

/// User’s actual permission mask(s) by area (dynamic keys).
/// Example input JSON: { "permission": { "user": 255, "log": 3, ... } }
class UserPermission {
  final Map<String, int> masks; // area -> bitmask

  const UserPermission(this.masks);

  /// From a root JSON containing "permission"
  factory UserPermission.fromRootJson(Map<String, dynamic> json) {
    final p = (json['permission'] as Map?) ?? const {};
    return UserPermission.fromPermissionMap(Map<String, dynamic>.from(p));
  }

  /// From the inner permission map directly (area -> int)
  factory UserPermission.fromPermissionMap(Map<String, dynamic> map) {
    final m = <String, int>{};
    map.forEach((area, value) {
      m[area] = (value ?? 0) as int;
    });
    return UserPermission(m);
  }

  Map<String, dynamic> toRootJson() => {'permission': masks};
  Map<String, int> toPermissionMap() => Map<String, int>.from(masks);

  int maskOf(String area) => masks[area] ?? 0;

  /// Check by raw flag
  bool hasFlag(String area, int flag) => (maskOf(area) & flag) == flag;

  /// Check by catalog value (name). Returns false if not found.
  bool hasValue(String area, String value, PermissionCatalog catalog) {
    final def = catalog.findByValue(area, value);
    if (def == null) return false;
    return hasFlag(area, def.flag);
  }

  /// Return a new instance with a flag granted.
  UserPermission grantFlag(String area, int flag) {
    final current = maskOf(area);
    return UserPermission({...masks, area: current | flag});
  }

  /// Return a new instance with a flag revoked.
  UserPermission revokeFlag(String area, int flag) {
    final current = maskOf(area);
    return UserPermission({...masks, area: current & ~flag});
  }

  /// Toggle a flag.
  UserPermission toggleFlag(String area, int flag) {
    final current = maskOf(area);
    final next = (current & flag) == flag ? (current & ~flag) : (current | flag);
    return UserPermission({...masks, area: next});
  }

  /// Grant by catalog value (name). If not found, returns unchanged.
  UserPermission grantValue(String area, String value, PermissionCatalog catalog) {
    final def = catalog.findByValue(area, value);
    return (def == null) ? this : grantFlag(area, def.flag);
  }

  /// Revoke by catalog value (name). If not found, returns unchanged.
  UserPermission revokeValue(String area, String value, PermissionCatalog catalog) {
    final def = catalog.findByValue(area, value);
    return (def == null) ? this : revokeFlag(area, def.flag);
  }

  /// List active flags (ints) for an area.
  List<int> activeFlags(String area, {Iterable<int>? universe}) {
    final mask = maskOf(area);
    final candidates = universe ?? _defaultUniverse(mask);
    return candidates.where((f) => (mask & f) == f).toList();
  }

  /// List active definitions (resolved via catalog).
  List<PermissionDefinition> activeDefinitions(String area, PermissionCatalog catalog) {
    final defs = catalog.areas[area] ?? const [];
    final mask = maskOf(area);
    return defs.where((d) => (mask & d.flag) == d.flag).toList();
  }

  /// If you don't pass a universe, try all single-bit flags up to the highest set bit.
  List<int> _defaultUniverse(int mask) {
    if (mask == 0) return const [];
    final maxBit = (mask.bitLength); // number of bits needed
    final result = <int>[];
    for (var i = 0; i < maxBit; i++) {
      result.add(1 << i);
    }
    return result;
  }
}
