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
      return SettingMenu(sections: data.map((e) => MenuDescriptor.fromJson(_asMap(e))).toList());

    }
    if (data is Map<String, dynamic>) {
      final secs = _asList(data['sections']);
      return SettingMenu(sections: secs.map((e) => MenuDescriptor.fromJson(_asMap(e))).toList());
    }
    throw FormatException('Expected a List or a Map with "sections".');
  }

  /// JSON form is the **array** for backward compatibility.
  /// Use [toJsonObject] if you prefer { "sections": [...] }
  dynamic toJson() => sections.map((s) => s.toJson()).toList();

  Map<String, dynamic> toJsonObject() => {'sections': toJson()};

  SettingMenu copyWith({List<MenuDescriptor>? sections}) => SettingMenu(sections: sections ?? this.sections);

  /// Utils
  MenuDescriptor? byEndpoint(String endpoint) => sections.where((s) => s.endpoint == endpoint).cast<MenuDescriptor?>().firstWhere((_) => true, orElse: () => null);

  MenuDescriptor? byTitle(String title) => sections.where((s) => s.title == title).cast<MenuDescriptor?>().firstWhere((_) => true, orElse: () => null);
}

/// Parse convenience for the raw array or object-with-sections.
SettingMenu parseSettingMenu(dynamic source) => SettingMenu.fromDynamic(source);

class CollectionAccess {
  final bool add;
  final bool getTemplate;
  final bool addWithExcel;
  final bool editDocument;
  final bool duplicateDocument;
  final bool updateCollectionWithExcel;
  final bool getCollectionAsExcel;

  CollectionAccess({
    required this.add,
    required this.getTemplate,
    required this.addWithExcel,
    required this.editDocument,
    required this.duplicateDocument,
    required this.updateCollectionWithExcel,
    required this.getCollectionAsExcel,
  });

  CollectionAccess copyWith({
    bool? add,
    bool? getTemplate,
    bool? addWithExcel,
    bool? editDocument,
    bool? duplicateDocument,
    bool? updateCollectionWithExcel,
    bool? getCollectionAsExcel,
  }) => CollectionAccess(
    add: add ?? this.add,
    getTemplate: getTemplate ?? this.getTemplate,
    addWithExcel: addWithExcel ?? this.addWithExcel,
    editDocument: editDocument ?? this.editDocument,
    duplicateDocument: duplicateDocument ?? this.duplicateDocument,
    updateCollectionWithExcel: updateCollectionWithExcel ?? this.updateCollectionWithExcel,
    getCollectionAsExcel: getCollectionAsExcel ?? this.getCollectionAsExcel,
  );

  factory CollectionAccess.fromJson(Map<String, dynamic> json) => CollectionAccess(
    add: json["add"],
    getTemplate: json["getTemplate"] ?? false,
    addWithExcel: json["addWithExcel"] ?? false,
    editDocument: json["editDocument"] ?? false,
    duplicateDocument: json["duplicateDocument"] ?? false,
    updateCollectionWithExcel: json["updateCollectionWithExcel"] ?? false,
    getCollectionAsExcel: json["getCollectionAsExcel"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "add": add,
    "getTemplate": getTemplate,
    "addWithExcel": addWithExcel,
    "editDocument": editDocument,
    "duplicateDocument": duplicateDocument,
    "updateCollectionWithExcel": updateCollectionWithExcel,
    "getCollectionAsExcel": getCollectionAsExcel,
  };
}

class DocumentAccess {
  final bool edit;
  final bool getDocumentAsExcel;
  final bool updateDocumentWithExcel;
  final bool delete;

  DocumentAccess({required this.edit, required this.getDocumentAsExcel, required this.updateDocumentWithExcel, required this.delete});

  DocumentAccess copyWith({bool? edit, bool? getDocumentAsExcel, bool? updateDocumentWithExcel, bool? delete}) => DocumentAccess(
    edit: edit ?? this.edit,
    getDocumentAsExcel: getDocumentAsExcel ?? this.getDocumentAsExcel,
    updateDocumentWithExcel: updateDocumentWithExcel ?? this.updateDocumentWithExcel,
    delete: delete ?? this.delete,
  );

  factory DocumentAccess.fromJson(Map<String, dynamic> json) => DocumentAccess(
    edit: json["edit"] ?? false,
    getDocumentAsExcel: json["getDocumentAsExcel"] ?? false,
    updateDocumentWithExcel: json["updateDocumentWithExcel"] ?? false,
    delete: json["delete"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "edit": edit,
    "getDocumentAsExcel": getDocumentAsExcel,
    "updateDocumentWithExcel": updateDocumentWithExcel,
    "delete": delete,
  };
}

/// ---------------------------
/// Section model
/// ---------------------------

class MenuDescriptor {
  final String title;
  final String fieldTitle;
  final String fieldDescription;
  final String endpoint;
  final List fieldName;
  final SchemaNode schema;
  final CollectionAccess collectionAccess;
  final DocumentAccess documentAccess;

  const MenuDescriptor({
    required this.title,
    required this.fieldTitle,
    required this.fieldDescription,
    required this.endpoint,
    required this.schema,
    required this.fieldName,
    required this.collectionAccess,
    required this.documentAccess,
  });

  factory MenuDescriptor.fromJson(Map<String, dynamic> json) {
    return MenuDescriptor(
      fieldTitle: _asString(json['fieldTitle']),
      fieldDescription: _asString(json['fieldDescription']),
      title: _asString(json['title']),
      endpoint: _asString(json['endpoint']),
      fieldName: _asList(json["fieldName"] ?? []),
      collectionAccess: json["collectionAccess"] == null
          ? CollectionAccess(add: false, getTemplate: false, addWithExcel: false, editDocument: false, duplicateDocument: false, updateCollectionWithExcel: false, getCollectionAsExcel: false)
          : CollectionAccess.fromJson(_asMap(json["collectionAccess"])),
      documentAccess: json["documentAccess"] == null ? DocumentAccess(edit: false, getDocumentAsExcel: false, updateDocumentWithExcel: false, delete: false) : DocumentAccess.fromJson(_asMap(json["documentAccess"])),
      schema: SchemaNode.fromJson(_asMap(json['schema'])),
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    "documentAccess": documentAccess.toJson(),
    "collectionAccess": collectionAccess.toJson(),
    'fieldTitle': fieldTitle,
    'fieldDescription': fieldDescription,
    'endpoint': endpoint,
    'fieldName': fieldName,
    'schema': schema.toJson(),
  };

  MenuDescriptor copyWith({String? title, DocumentAccess? documentAccess, CollectionAccess? collectionAccess, String? fieldTitle, String? fieldDescription, String? endpoint, SchemaNode? schema, List? fieldName}) {
    return MenuDescriptor(
      title: title ?? this.title,
      fieldTitle: fieldTitle ?? this.fieldTitle,
      fieldDescription: fieldDescription ?? this.fieldDescription,
      documentAccess: documentAccess ?? this.documentAccess,
      collectionAccess: collectionAccess ?? this.collectionAccess,
      endpoint: endpoint ?? this.endpoint,
      schema: schema ?? this.schema,
      fieldName: fieldName ?? this.fieldName,
    );
  }

  getValue(value) {
    // log("getting value for ${title} from ${(schema.toJson()["items"]["properties"] as Map).keys.join("-")}");
    if (value is List) {
      final res = value.where((a) => a.keys.join("-") == (schema.toJson()["items"]["properties"] as Map).keys.join("-")).toList();
      return res;
    }
    return value;
  }

  getOtherValue(value) {
    // log("getting value for ${title} from ${(schema.toJson()["items"]["properties"] as Map).keys.join("-")}");
    if (value is List) {
      final res = value.where((a) => a.keys.join("-") == (schema.toJson()["items"]["properties"] as Map).keys.join("-")).toList();
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
  final String? title;
  final String? desc;
  final List<String>? fieldName;
  final Map<String, SchemaProperty> properties;


  const SchemaNode({required this.kind, this.title, this.desc,required this.properties,this.fieldName});

  factory SchemaNode.fromJson(Map<String, dynamic> json) {
    // normalize "type": ["string"] -> "string"
    dynamic t = json['type'];
    if (t is List && t.length == 1 && t.first is String) {
      t = t.first;
      json = {...json, 'type': t};
    }

    final type = _asString(json['type']).trim().toLowerCase();
    final props = <String, SchemaProperty>{};
    final rawProps = _asMap(json['properties'], allowNull: true);
    rawProps.forEach((key, value) {
      props[key] = SchemaProperty.fromJson(key, _asMap(value));
    });
    switch (type) {
      case 'object':
        return ObjectSchema(properties: props, title: json["title"] ?? json["fieldTitle"], desc: json["fieldDescription"],fieldName:  List<String>.from(json["fieldName"]??[]),);

      case 'array':
        final items = json['items'];
        if (items == null) throw FormatException('Array schema must contain "items".');

        return ArraySchema(
            properties: props,
            fieldName: List<String>.from(json["fieldName"]??[]),
            items: SchemaNode.fromJson(_asMap(items)), title: json["title"] ?? json["fieldTitle"], desc: json["fieldDescription"]);


      // ---- Extended types you asked for ----
      case 'enum':
        // Treat as a string primitive with enum values from enumList (fallback to enum)
        return PrimitiveSchema(kind: SchemaKind.string,
            fieldName:  List<String>.from(json["fieldName"]??[]),
            enumValues: _readEnumList(json), format: null, title: json["title"] ?? json["fieldTitle"], desc: json["fieldDescription"],properties: props);

      case 'objectid':
        // Treat as a string primitive with a format hint
        return PrimitiveSchema(
            fieldName: List<String>.from(json["fieldName"]??[]),
            kind: SchemaKind.string, enumValues: null, format: 'objectId', title: json["title"] ?? json["fieldTitle"], desc: json["fieldDescription"],properties: props);

      // ---- Standard primitives ----
      case 'string':
        return PrimitiveSchema(
          kind: SchemaKind.string,
          properties: props,
          fieldName:  List<String>.from(json["fieldName"]??[]),
          enumValues: _readEnumClassicOrList(json),
          format: _asString(json['format'], fallback: ''),
          title: json["title"] ?? json["fieldTitle"],
          desc: json["fieldDescription"],
        );

      case 'number':
        return PrimitiveSchema(
          properties: props,
          fieldName:  List<String>.from(json["fieldName"]??[]),
          kind: SchemaKind.number,
          enumValues: _readEnumClassicOrList(json),
          format: _asString(json['format'], fallback: ''),
          title: json["title"] ?? json["fieldTitle"],
          desc: json["fieldDescription"],
        );

      case 'boolean':
        return PrimitiveSchema(
          properties: props,
          fieldName: List<String>.from(json["fieldName"]??[]),
          kind: SchemaKind.boolean,
          enumValues: _readEnumClassicOrList(json),
          format: _asString(json['format'], fallback: ''),
          title: json["title"] ?? json["fieldTitle"],
          desc: json["fieldDescription"],
        );

      default:
        throw UnsupportedError('Unsupported schema type: "$type"');
    }
  }

  String get getFieldName => "${fieldName}";

  Map<String, dynamic> toJson();
}

class ObjectSchema extends SchemaNode {

  ObjectSchema({required super.properties, required super.title, required super.desc, super.kind = SchemaKind.object,super.fieldName});

  @override
  Map<String, dynamic> toJson() => {'type': 'object', 'properties': properties.map((k, v) => MapEntry(k, v.toJson()))};
}

class ArraySchema extends SchemaNode {
  final SchemaNode items;

  ArraySchema({required this.items, super.kind = SchemaKind.array, super.title, super.desc,super.properties = const {},super.fieldName});

  @override
  Map<String, dynamic> toJson() => {'type': 'array', 'items': items.toJson(), 'properties': properties.map((k, v) => MapEntry(k, v.toJson()))};
}

class PrimitiveSchema extends SchemaNode {
  /// Optional enum list (for dropdown choices)
  final List<dynamic>? enumValues; // must be a LIST (not String)

  /// Optional format hint (e.g., 'objectId', 'email', 'timezone')
  final String? format;

  const PrimitiveSchema({this.enumValues, this.format, required super.kind, super.title, super.desc,required super.properties,super.fieldName});

  bool get hasEnum => enumValues != null && enumValues!.isNotEmpty;

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> base = {
      'type': switch (kind) {
        SchemaKind.string => 'string',
        SchemaKind.number => 'number',
        SchemaKind.boolean => 'boolean',
        _ => throw StateError('Invalid PrimitiveSchema kind: $kind'),
      },
    };

    // Preserve extended types where possible in output
    if ((format?.toLowerCase() ?? '') == 'objectid') {
      return {'type': 'objectId', 'properties': properties.map((k, v) => MapEntry(k, v.toJson()))};
    }

    if (hasEnum && kind == SchemaKind.string && (format == null || format!.isEmpty)) {
      // Prefer enumList in output, but also include classic enum for compatibility
      return {'type': 'enum', 'enumList': enumValues, 'enum': enumValues, 'properties': properties.map((k, v) => MapEntry(k, v.toJson()))};
    }

    if (hasEnum) {
      base['enum'] = enumValues;
      base['enumList'] = enumValues; // write both for compatibility
    }
    if (format != null && format!.isNotEmpty) {
      base['format'] = format;
    }
    return base;
  }
}

class SchemaProperty {
  final String name;
  final SchemaNode schema;
  final bool required;

  SchemaProperty({required this.name, required this.schema, required this.required});

  factory SchemaProperty.fromJson(String name, Map<String, dynamic> json) {
    final requiredFlag = _asBool(json['required'], fallback: false);
    final schema = SchemaNode.fromJson(json);
    return SchemaProperty(name: name, schema: schema, required: requiredFlag);
  }

  Map<String, dynamic> toJson() => {...schema.toJson(), 'required': required};

  SchemaProperty copyWith({String? name, SchemaNode? schema, bool? required}) {
    return SchemaProperty(name: name ?? this.name, schema: schema ?? this.schema, required: required ?? this.required);
  }
}

/// ---------------------------
/// Data helpers
/// ---------------------------

dynamic emptyValueForSchema(SchemaNode schema) {
  switch (schema.kind) {
    case SchemaKind.object:
      final obj = schema as ObjectSchema;
      return {for (final entry in obj.properties.entries) entry.key: emptyValueForSchema(entry.value.schema)};
    case SchemaKind.array:
      return <dynamic>[];
    case SchemaKind.string:
      // For enum/objectId we still default to empty string to force user selection.
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

  // Extended primitive checks (format/enum) stay as-is
  if (schema is PrimitiveSchema) {
    if ((schema.format?.toLowerCase() ?? '') == 'objectid') {
      if (value is! String) {
        err('Expected objectId (string).');
      } else if (value.isNotEmpty) {
        final ok = RegExp(r'^[a-fA-F0-9]{24}$').hasMatch(value);
        if (!ok) err('Invalid ObjectId format.');
      }
    }
    if (schema.hasEnum) {
      // Only enforce when something is provided (empty string will be caught by required check below)
      final v = (value is String) ? value.trim() : value?.toString().trim();
      if (v != null && v.isNotEmpty && !schema.enumValues!.contains(v)) {
        err('Value not in enum list.');
      }
    }
  }

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

        // 1) Presence check for required fields
        for (final p in obj.properties.values) {
          if (p.required && !value.containsKey(p.name)) {
            errors.add('$path.${p.name}: Missing required field.');
          }
        }

        // 2) Emptiness check for required fields (your rule set)
        for (final p in obj.properties.values) {
          if (!value.containsKey(p.name)) continue; // already reported missing
          final v = value[p.name];

          if (p.required && _isEmptyForRequired(p.schema, v)) {
            errors.add('$path.${p.name}: Required field is empty.');
            // Even if empty, still recurse to catch type errors if you want; usually you can skip.
          }
        }

        // 3) Recurse into children (for both required/optional if present)
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

dynamic newEmptyDataForSection(MenuDescriptor section) => emptyValueForSchema(section.schema);

List<Map<String, dynamic>> upsertByKey({required List<Map<String, dynamic>> array, required String keyName, required Map<String, dynamic> item}) {
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

/// Reads classic `"enum": [...]` only.
List<dynamic>? _readEnum(Map<String, dynamic> json) {
  final e = json['enum'];
  if (e == null) return null;
  if (e is List) return e;
  throw FormatException('"enum" must be a List.');
}

/// Reads `"enumList": [...]`, fallback to classic `"enum": [...]`.
List<dynamic>? _readEnumList(Map<String, dynamic> json) {
  final e1 = json['enumList'];
  if (e1 is List) return e1;
  final e2 = json['enum'];
  if (e2 is List) return e2;
  return null;
}

/// Reads either `"enumList"` or `"enum"` for standard primitive cases.
List<dynamic>? _readEnumClassicOrList(Map<String, dynamic> json) {
  final e1 = json['enum'];
  if (e1 is List) return e1;
  final e2 = json['enumList'];
  if (e2 is List) return e2;
  return null;
}

class _PathToken {
  final String raw;
  final bool isIndex;
  final int? index;
  final String? key;

  _PathToken.index(this.raw, this.index) : isIndex = true, key = null;

  _PathToken.key(this.raw, this.key) : isIndex = false, index = null;
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

bool _isEmptyForRequired(SchemaNode schema, dynamic value) {
  if (value == null) return true;

  switch (schema.kind) {
    case SchemaKind.string:
      // Treat empty/whitespace string as empty
      return value is String ? value.trim().isEmpty : value.toString().trim().isEmpty;

    case SchemaKind.array:
      // IMPORTANT: you said empty list is valid
      return false;

    case SchemaKind.object:
      // Present object is considered non-empty at this level; children handle their own "required"
      return false;

    case SchemaKind.number:
    case SchemaKind.boolean:
      // 0 and false are valid values
      return false;
  }
}
