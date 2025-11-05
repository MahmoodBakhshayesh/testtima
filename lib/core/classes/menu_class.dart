// settings_menu_models.dart
import 'dart:convert';
import 'dart:developer';

/// Root model that owns all menu sections.
/// Your original JSON is an ARRAY; this class supports both:
/// 1) a raw JSON array of sections
/// 2) an object { "sections": [...] }
class SettingMenu {
  final List<MenuDescriptor> sections;

  const SettingMenu({required this.sections});

  /// Accepts:
  /// - List<dynamic> (raw sections array)
  /// - Map<String,dynamic> with "sections"
  factory SettingMenu.fromDynamic(dynamic source) {
    final data = source is String ? jsonDecode(source) : source;

    if (data is List) {
      return SettingMenu(
        sections: data.map((e) => MenuDescriptor.fromJson(_asMap(e))).toList(),
      );
    }
    if (data is Map<String, dynamic>) {
      final secs = _asList(data['sections']);
      return SettingMenu(
        sections: secs.map((e) => MenuDescriptor.fromJson(_asMap(e))).toList(),
      );
    }
    throw FormatException('Expected a List or a Map with "sections".');
  }

  /// JSON form is the **array** for backward compatibility.
  /// Use [toJsonObject] if you prefer { "sections": [...] }
  dynamic toJson() => sections.map((s) => s.toJson()).toList();

  Map<String, dynamic> toJsonObject() => {'sections': toJson()};

  SettingMenu copyWith({List<MenuDescriptor>? sections}) =>
      SettingMenu(sections: sections ?? this.sections);

  /// Utils
  MenuDescriptor? byEndpoint(String endpoint) =>
      sections.where((s) => s.endpoint == endpoint).cast<MenuDescriptor?>().firstWhere((_) => true, orElse: () => null);

  MenuDescriptor? byTitle(String title) =>
      sections.where((s) => s.title == title).cast<MenuDescriptor?>().firstWhere((_) => true, orElse: () => null);
}

/// Parse convenience for the raw array or object-with-sections.
SettingMenu parseSettingMenu(dynamic source) => SettingMenu.fromDynamic(source);

/// ---------------------------
/// Section model
/// ---------------------------

class MenuDescriptor {
  final String title;
  final String endpoint;
  final SchemaNode schema;

  const MenuDescriptor({
    required this.title,
    required this.endpoint,
    required this.schema,
  });

  factory MenuDescriptor.fromJson(Map<String, dynamic> json) {
    return MenuDescriptor(
      title: _asString(json['title']),
      endpoint: _asString(json['endpoint']),
      schema: SchemaNode.fromJson(_asMap(json['schema'])),
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'endpoint': endpoint,
    'schema': schema.toJson(),
  };

  MenuDescriptor copyWith({
    String? title,
    String? endpoint,
    SchemaNode? schema,
  }) {
    return MenuDescriptor(
      title: title ?? this.title,
      endpoint: endpoint ?? this.endpoint,
      schema: schema ?? this.schema,
    );
  }

  getValue(value) {
    return value;
      // log("getting value for ${title} from ${(schema.toJson()["items"]["properties"] as Map).keys.join("-")}");
      if (value is List) {
        final res=  value.where((a) => a.keys.join("-") == (schema.toJson()["items"]["properties"] as Map).keys.join("-")).toList();
        return res;
      }
      return value;
  }
  getOtherValue(value) {
      // log("getting value for ${title} from ${(schema.toJson()["items"]["properties"] as Map).keys.join("-")}");
      if (value is List) {
        final res=  value.where((a) => a.keys.join("-") != (schema.toJson()["items"]["properties"] as Map).keys.join("-")).toList();
        return res;
      }
      return value;
  }
}

/// ---------------------------
/// Minimal JSON-Schema subset
/// ---------------------------

enum SchemaKind { object, array, string, number, boolean }

abstract class SchemaNode {
  final SchemaKind kind;

  const SchemaNode(this.kind);

  factory SchemaNode.fromJson(Map<String, dynamic> json) {
    // normalize "type": ["string"] -> "string"
    dynamic t = json['type'];
    if (t is List && t.length == 1 && t.first is String) {
      t = t.first;
      json = {...json, 'type': t};
    }

    final type = _asString(json['type']).trim().toLowerCase();
    switch (type) {
      case 'object':
        final props = <String, SchemaProperty>{};
        final rawProps = _asMap(json['properties'], allowNull: true);
        rawProps.forEach((key, value) {
          props[key] = SchemaProperty.fromJson(key, _asMap(value));
        });
        return ObjectSchema(properties: props);
      case 'array':
        final items = json['items'];
        if (items == null) throw FormatException('Array schema must contain "items".');
        return ArraySchema(items: SchemaNode.fromJson(_asMap(items)));
      case 'string':
      case 'number':
      case 'boolean':
        final enumValues = _readEnum(json);
        return PrimitiveSchema(
          _primitiveKindFrom(type),
          enumValues: enumValues,
        );
      default:
        throw UnsupportedError('Unsupported schema type: "$type"');
    }
  }

  Map<String, dynamic> toJson();
}

class ObjectSchema extends SchemaNode {
  final Map<String, SchemaProperty> properties;

  ObjectSchema({required this.properties}) : super(SchemaKind.object);

  @override
  Map<String, dynamic> toJson() => {
    'type': 'object',
    'properties': properties.map((k, v) => MapEntry(k, v.toJson())),
  };
}

class ArraySchema extends SchemaNode {
  final SchemaNode items;

  ArraySchema({required this.items}) : super(SchemaKind.array);

  @override
  Map<String, dynamic> toJson() => {
    'type': 'array',
    'items': items.toJson(),
  };
}

class PrimitiveSchema extends SchemaNode {
  /// Optional enum list (for dropdown choices)
  final List<dynamic>? enumValues; // must be a LIST (not String)

  const PrimitiveSchema(SchemaKind kind, {this.enumValues}) : super(kind);

  bool get hasEnum => enumValues != null && enumValues!.isNotEmpty;

  @override
  Map<String, dynamic> toJson() {
    final Map<String,dynamic> base = {
      'type': switch (kind) {
        SchemaKind.string => 'string',
        SchemaKind.number => 'number',
        SchemaKind.boolean => 'boolean',
        _ => throw StateError('Invalid PrimitiveSchema kind: $kind'),
      }
    };
    if (hasEnum) base['enum'] = enumValues;
    return base;
  }
}

class SchemaProperty {
  final String name;
  final SchemaNode schema;
  final bool required;

  SchemaProperty({
    required this.name,
    required this.schema,
    required this.required,
  });

  factory SchemaProperty.fromJson(String name, Map<String, dynamic> json) {
    final requiredFlag = _asBool(json['required'], fallback: false);
    final schema = SchemaNode.fromJson(json);
    return SchemaProperty(name: name, schema: schema, required: requiredFlag);
  }

  Map<String, dynamic> toJson() => {
    ...schema.toJson(),
    'required': required,
  };

  SchemaProperty copyWith({
    String? name,
    SchemaNode? schema,
    bool? required,
  }) {
    return SchemaProperty(
      name: name ?? this.name,
      schema: schema ?? this.schema,
      required: required ?? this.required,
    );
  }
}

/// ---------------------------
/// Data helpers
/// ---------------------------

dynamic emptyValueForSchema(SchemaNode schema) {
  switch (schema.kind) {
    case SchemaKind.object:
      final obj = schema as ObjectSchema;
      return {
        for (final entry in obj.properties.entries)
          entry.key: emptyValueForSchema(entry.value.schema),
      };
    case SchemaKind.array:
      return <dynamic>[];
    case SchemaKind.string:
      return '';
    case SchemaKind.number:
      return 0;
    case SchemaKind.boolean:
      return false;
  }
}

List<String> validateAgainstSchema(SchemaNode schema, dynamic value, {String path = r'$'}) {
  final errors = <String>[];
  void err(String msg) => errors.add('$path: $msg');

  switch (schema.kind) {
    case SchemaKind.string:
      if (value is! String) err('Expected string.');
      break;
    case SchemaKind.number:
      if (value is! num) err('Expected number.');
      break;
    case SchemaKind.boolean:
      if (value is! bool) err('Expected boolean.');
      break;
    case SchemaKind.array:
      if (value is! List) {
        err('Expected array.');
      } else {
        final itemSchema = (schema as ArraySchema).items;
        for (var i = 0; i < value.length; i++) {
          errors.addAll(validateAgainstSchema(itemSchema, value[i], path: '$path[$i]'));
        }
      }
      break;
    case SchemaKind.object:
      if (value is! Map) {
        err('Expected object.');
      } else {
        final obj = schema as ObjectSchema;
        for (final p in obj.properties.values) {
          if (p.required && !value.containsKey(p.name)) {
            errors.add('$path.${p.name}: Missing required field.');
          }
        }
        for (final entry in obj.properties.entries) {
          final key = entry.key;
          if (value.containsKey(key)) {
            errors.addAll(validateAgainstSchema(entry.value.schema, value[key], path: '$path.$key'));
          }
        }
      }
      break;
  }

  return errors;
}

/// Build a map of path -> list of messages (for inline errors).
Map<String, List<String>> buildErrorIndex(List<String> flatErrors) {
  final map = <String, List<String>>{};
  for (final e in flatErrors) {
    final sep = e.indexOf(':');
    final path = sep >= 0 ? e.substring(0, sep).trim() : r'$';
    final msg = sep >= 0 ? e.substring(sep + 1).trim() : e;
    (map[path] ??= []).add(msg);
  }
  return map;
}

dynamic deepClone(dynamic value) {
  if (value is Map) return value.map((k, v) => MapEntry(k, deepClone(v)));
  if (value is List) return value.map(deepClone).toList();
  return value;
}

dynamic updateAtPath(dynamic root, String path, dynamic newValue) {
  if (!path.startsWith(r'$')) {
    throw ArgumentError('Path must start with \$');
  }
  final tokens = _tokenizePath(path);
  if (tokens.isEmpty) return newValue;

  dynamic walk(dynamic current, int index) {
    if (index == tokens.length) return newValue;

    final token = tokens[index];
    if (token.isIndex) {
      if (current is! List) throw StateError('Path expects List at "${token.raw}".');
      final li = List.of(current);
      if (token.index! < 0 || token.index! >= li.length) {
        throw RangeError('Index out of range at "${token.raw}".');
      }
      li[token.index!] = walk(li[token.index!], index + 1);
      return li;
    } else {
      if (current is! Map) throw StateError('Path expects Map at "${token.raw}".');
      final key = token.key!;
      final m = Map<String, dynamic>.from(current);
      if (!m.containsKey(key)) throw StateError('Key "$key" missing at "${token.raw}".');
      m[key] = walk(m[key], index + 1);
      return m;
    }
  }

  return walk(deepClone(root), 1);
}

dynamic newEmptyDataForSection(MenuDescriptor section) =>
    emptyValueForSchema(section.schema);

List<Map<String, dynamic>> upsertByKey({
  required List<Map<String, dynamic>> array,
  required String keyName,
  required Map<String, dynamic> item,
}) {
  final key = item[keyName];
  if (key == null) return [...array, item];
  final idx = array.indexWhere((e) => e[keyName] == key);
  if (idx >= 0) {
    final out = [...array];
    out[idx] = item;
    return out;
  } else {
    return [...array, item];
  }
}

/// ---------------------------
/// Internals
/// ---------------------------

SchemaKind _primitiveKindFrom(String t) => switch (t) {
  'string' => SchemaKind.string,
  'number' => SchemaKind.number,
  'boolean' => SchemaKind.boolean,
  _ => throw ArgumentError('Not a primitive type: $t'),
};

List<dynamic>? _readEnum(Map<String, dynamic> json) {
  final e = json['enum'];
  if (e == null) return null;
  if (e is List) return e;
  throw FormatException('"enum" must be a List.');
}

class _PathToken {
  final String raw;
  final bool isIndex;
  final int? index;
  final String? key;

  _PathToken.index(this.raw, this.index)
      : isIndex = true,
        key = null;
  _PathToken.key(this.raw, this.key)
      : isIndex = false,
        index = null;
}

List<_PathToken> _tokenizePath(String path) {
  final out = <_PathToken>[];
  var i = 0;
  void readKey() {
    final start = i;
    while (i < path.length && path[i] != '.' && path[i] != '[') i++;
    final seg = path.substring(start, i);
    if (seg.isNotEmpty) out.add(_PathToken.key(seg, seg));
  }

  if (path.isEmpty || path[0] != r'$') {
    throw ArgumentError('Invalid path: must start with \$');
  }
  out.add(_PathToken.key(r'$', r'$'));
  i = 1;

  while (i < path.length) {
    if (path[i] == '.') {
      i++;
      readKey();
    } else if (path[i] == '[') {
      final close = path.indexOf(']', i);
      if (close < 0) throw ArgumentError('Unclosed bracket.');
      final inside = path.substring(i + 1, close);
      final idx = int.tryParse(inside);
      if (idx == null) throw ArgumentError('Non-numeric index "$inside".');
      out.add(_PathToken.index(path.substring(i, close + 1), idx));
      i = close + 1;
    } else {
      readKey();
    }
  }

  return out;
}

String _asString(dynamic v, {String fallback = ''}) {
  if (v is String) return v;
  if (v == null) return fallback;
  return v.toString();
}

Map<String, dynamic> _asMap(dynamic v, {bool allowNull = false}) {
  if (v == null && allowNull) return <String, dynamic>{};
  if (v is Map<String, dynamic>) return v;
  if (v is Map) return v.cast<String, dynamic>();
  throw FormatException('Expected Map, got: ${v.runtimeType}');
}

List<dynamic> _asList(dynamic v) {
  if (v is List) return v;
  throw FormatException('Expected List, got: ${v.runtimeType}');
}

bool _asBool(dynamic v, {bool fallback = false}) {
  if (v is bool) return v;
  if (v == null) return fallback;
  if (v is String) {
    final s = v.toLowerCase().trim();
    if (s == 'true') return true;
    if (s == 'false') return false;
  }
  return fallback;
}
