// To parse this JSON data, do
//
//     final constantData = constantDataFromJson(jsonString);

import 'dart:convert';
import 'dart:ui';

import 'package:abds/core/constants/ui.dart';

VersionedConstantData constantDataFromJson(String str) => VersionedConstantData.fromJson(json.decode(str));

String constantDataToJson(VersionedConstantData data) => json.encode(data.toJson());

class VersionedConstantData {
  final String version;
  final VersionedData data;

  VersionedConstantData({
    required this.version,
    required this.data,
  });

  VersionedConstantData copyWith({
    String? version,
    VersionedData? data,
  }) =>
      VersionedConstantData(
        version: version ?? this.version,
        data: data ?? this.data,
      );

  factory VersionedConstantData.fromJson(Map<String, dynamic> json) => VersionedConstantData(
    version: json["version"],
    data: VersionedData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "version": version,
    "data": data.toJson(),
  };
}

class VersionedData {
  final List<String> logNoteType;
  final List<String> textMessage;
  final List<DocumentType> documentType;
  final List<DocumentDetailType> documentDetailType;
  final Permission permission;
  final List<Attribute> attribute;
  final List<ParameterValue> documentModel;
  final List<ParameterValue> product;
  final List<DocumentCode> documentCode;
  final List<ParameterValue> queryType;
  final List<ParameterValue> stayType;
  final List<dynamic> documentSeries;
  final List<ParameterValue> ruleSetType;
  final List<ParameterValue> carrier;
  final List<ParameterValue> passengerType;
  final List<ParameterValue> channel;
  final List<ParameterValue> pets;
  final List<Airport> city;
  final List<Country> country;
  final List<Airport> airport;

  VersionedData({
    required this.logNoteType,
    required this.textMessage,
    required this.documentType,
    required this.documentDetailType,
    required this.permission,
    required this.attribute,
    required this.documentModel,
    required this.product,
    required this.documentCode,
    required this.queryType,
    required this.stayType,
    required this.documentSeries,
    required this.ruleSetType,
    required this.carrier,
    required this.passengerType,
    required this.channel,
    required this.pets,
    required this.city,
    required this.country,
    required this.airport,
  });

  VersionedData copyWith({
    List<String>? logNoteType,
    List<String>? textMessage,
    List<DocumentType>? documentType,
    List<DocumentDetailType>? documentDetailType,
    Permission? permission,
    List<Attribute>? attribute,
    List<ParameterValue>? documentModel,
    List<ParameterValue>? product,
    List<DocumentCode>? documentCode,
    List<ParameterValue>? queryType,
    List<ParameterValue>? stayType,
    List<dynamic>? documentSeries,
    List<ParameterValue>? ruleSetType,
    List<ParameterValue>? carrier,
    List<ParameterValue>? passengerType,
    List<ParameterValue>? channel,
    List<ParameterValue>? pets,
    List<Airport>? city,
    List<Country>? country,
    List<Airport>? airport,
  }) =>
      VersionedData(
        logNoteType: logNoteType ?? this.logNoteType,
        textMessage: textMessage ?? this.textMessage,
        documentType: documentType ?? this.documentType,
        documentDetailType: documentDetailType ?? this.documentDetailType,
        permission: permission ?? this.permission,
        attribute: attribute ?? this.attribute,
        documentModel: documentModel ?? this.documentModel,
        product: product ?? this.product,
        documentCode: documentCode ?? this.documentCode,
        queryType: queryType ?? this.queryType,
        stayType: stayType ?? this.stayType,
        documentSeries: documentSeries ?? this.documentSeries,
        ruleSetType: ruleSetType ?? this.ruleSetType,
        carrier: carrier ?? this.carrier,
        passengerType: passengerType ?? this.passengerType,
        channel: channel ?? this.channel,
        pets: pets ?? this.pets,
        city: city ?? this.city,
        country: country ?? this.country,
        airport: airport ?? this.airport,
      );

  factory VersionedData.fromJson(Map<String, dynamic> json) => VersionedData(
    logNoteType: List<String>.from(json["logNoteType"].map((x) => x)),
    textMessage: List<String>.from(json["textMessage"].map((x) => x)),
    documentType: List<DocumentType>.from(json["documentType"].map((x) => DocumentType.fromJson(x))),
    documentDetailType: List<DocumentDetailType>.from(json["documentDetailType"].map((x) => DocumentDetailType.fromJson(x))),
    permission: Permission.fromJson(json["permission"]),
    attribute: List<Attribute>.from(json["attribute"].map((x) => Attribute.fromJson(x))),
    documentModel: List<ParameterValue>.from(json["documentModel"].map((x) => ParameterValue.fromJson(x))),
    product: List<ParameterValue>.from(json["product"].map((x) => ParameterValue.fromJson(x))),
    documentCode: List<DocumentCode>.from(json["documentCode"].map((x) => DocumentCode.fromJson(x))),
    queryType: List<ParameterValue>.from(json["queryType"].map((x) => ParameterValue.fromJson(x))),
    stayType: List<ParameterValue>.from(json["stayType"].map((x) => ParameterValue.fromJson(x))),
    documentSeries: List<dynamic>.from(json["documentSeries"].map((x) => x)),
    ruleSetType: List<ParameterValue>.from(json["ruleSetType"].map((x) => ParameterValue.fromJson(x))),
    carrier: List<ParameterValue>.from(json["carrier"].map((x) => ParameterValue.fromJson(x))),
    passengerType: List<ParameterValue>.from(json["passengerType"].map((x) => ParameterValue.fromJson(x))),
    channel: List<ParameterValue>.from(json["channel"].map((x) => ParameterValue.fromJson(x))),
    pets: List<ParameterValue>.from(json["pets"].map((x) => ParameterValue.fromJson(x))),
    city: List<Airport>.from(json["city"].map((x) => Airport.fromJson(x))),
    country: List<Country>.from(json["country"].map((x) => Country.fromJson(x))),
    airport: List<Airport>.from(json["airport"].map((x) => Airport.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "logNoteType": List<dynamic>.from(logNoteType.map((x) => x)),
    "textMessage": List<dynamic>.from(textMessage.map((x) => x)),
    "documentType": List<dynamic>.from(documentType.map((x) => x.toJson())),
    "documentDetailType": List<dynamic>.from(documentDetailType.map((x) => x.toJson())),
    "permission": permission.toJson(),
    "attribute": List<dynamic>.from(attribute.map((x) => x.toJson())),
    "documentModel": List<dynamic>.from(documentModel.map((x) => x.toJson())),
    "product": List<dynamic>.from(product.map((x) => x.toJson())),
    "documentCode": List<dynamic>.from(documentCode.map((x) => x.toJson())),
    "queryType": List<dynamic>.from(queryType.map((x) => x.toJson())),
    "stayType": List<dynamic>.from(stayType.map((x) => x.toJson())),
    "documentSeries": List<dynamic>.from(documentSeries.map((x) => x)),
    "ruleSetType": List<dynamic>.from(ruleSetType.map((x) => x.toJson())),
    "carrier": List<dynamic>.from(carrier.map((x) => x.toJson())),
    "passengerType": List<dynamic>.from(passengerType.map((x) => x.toJson())),
    "channel": List<dynamic>.from(channel.map((x) => x.toJson())),
    "pets": List<dynamic>.from(pets.map((x) => x.toJson())),
    "city": List<dynamic>.from(city.map((x) => x.toJson())),
    "country": List<dynamic>.from(country.map((x) => x.toJson())),
    "airport": List<dynamic>.from(airport.map((x) => x.toJson())),
  };
}

class Airport {
  final String type;
  final String code3;
  final String name;

  Airport({
    required this.type,
    required this.code3,
    required this.name,
  });

  Airport copyWith({
    String? type,
    String? code3,
    String? name,
  }) =>
      Airport(
        type: type ?? this.type,
        code3: code3 ?? this.code3,
        name: name ?? this.name,
      );

  factory Airport.fromJson(Map<String, dynamic> json) => Airport(
    type: json["type"],
    code3: json["code3"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "code3": code3,
    "name": name,
  };

  @override
  String toString() => "$code3";
}

class Attribute {
  final List<String> defaultList;
  final String name;
  final String type;
  final bool onlyOwner;
  final String defaultValue;

  Attribute({
    required this.defaultList,
    required this.name,
    required this.type,
    required this.onlyOwner,
    required this.defaultValue,
  });

  Attribute copyWith({
    List<String>? defaultList,
    String? name,
    String? type,
    bool? onlyOwner,
    String? defaultValue,
  }) =>
      Attribute(
        defaultList: defaultList ?? this.defaultList,
        name: name ?? this.name,
        type: type ?? this.type,
        onlyOwner: onlyOwner ?? this.onlyOwner,
        defaultValue: defaultValue ?? this.defaultValue,
      );

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
    defaultList: List<String>.from(json["defaultList"].map((x) => x)),
    name: json["name"],
    type: json["type"],
    onlyOwner: json["onlyOwner"],
    defaultValue: json["defaultValue"],
  );

  Map<String, dynamic> toJson() => {
    "defaultList": List<dynamic>.from(defaultList.map((x) => x)),
    "name": name,
    "type": type,
    "onlyOwner": onlyOwner,
    "defaultValue": defaultValue,
  };
}

class ParameterValue {
  final String name;
  final String code;

  ParameterValue({
    required this.name,
    required this.code,
  });

  ParameterValue copyWith({
    String? name,
    String? code,
  }) =>
      ParameterValue(
        name: name ?? this.name,
        code: code ?? this.code,
      );

  factory ParameterValue.fromJson(Map<String, dynamic> json) => ParameterValue(
    name: json["name"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "code": code,
  };

  @override
  String toString() => "$code ($name)";
}


class Country {
  final String type;
  final String code2;
  final String code3;
  final String name;

  Country({
    required this.type,
    required this.code2,
    required this.code3,
    required this.name,
  });

  Country copyWith({
    String? type,
    String? code2,
    String? code3,
    String? name,
  }) =>
      Country(
        type: type ?? this.type,
        code2: code2 ?? this.code2,
        code3: code3 ?? this.code3,
        name: name ?? this.name,
      );

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    type: json["type"],
    code2: json["code2"],
    code3: json["code3"]??'',

    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "code2": code2,
    "code3": code3,
    "name": name,
  };

  @override
  String toString() => "$code3";
}

class DocumentCode {
  final String name;
  final String code;
  final String type;

  DocumentCode({
    required this.name,
    required this.code,
    required this.type,
  });

  DocumentCode copyWith({
    String? name,
    String? code,
    String? type,
  }) =>
      DocumentCode(
        name: name ?? this.name,
        code: code ?? this.code,
        type: type ?? this.type,
      );

  factory DocumentCode.fromJson(Map<String, dynamic> json) => DocumentCode(
    name: json["name"],
    code: json["code"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "code": code,
    "type": type,
  };

  @override
  String toString() => "$code ($name)";
}

class DocumentDetailType {
  final String type;
  final String subType;
  final String country;
  final String title;
  final String code;
  final String? note;

  DocumentDetailType({
    required this.type,
    required this.subType,
    required this.country,
    required this.title,
    required this.code,
    this.note,
  });

  DocumentDetailType copyWith({
    String? type,
    String? subType,
    String? country,
    String? title,
    String? code,
    String? note,
  }) =>
      DocumentDetailType(
        type: type ?? this.type,
        subType: subType ?? this.subType,
        country: country ?? this.country,
        title: title ?? this.title,
        code: code ?? this.code,
        note: note ?? this.note,
      );

  factory DocumentDetailType.fromJson(Map<String, dynamic> json) => DocumentDetailType(
    type: json["type"],
    subType: json["subType"],
    country: json["country"],
    title: json["title"],
    code: json["code"],
    note: json["note"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "subType": subType,
    "country": country,
    "title": title,
    "code": code,
    "note": note,
  };
}

class DocumentType {
  final String type;
  final String color;
  final String title;
  final String code;

  DocumentType({
    required this.type,
    required this.color,
    required this.title,
    required this.code,
  });

  DocumentType copyWith({
    String? type,
    String? color,
    String? title,
    String? code,
  }) =>
      DocumentType(
        type: type ?? this.type,
        color: color ?? this.color,
        title: title ?? this.title,
        code: code ?? this.code,
      );

  factory DocumentType.fromJson(Map<String, dynamic> json) => DocumentType(
    type: json["type"],
    color: json["color"],
    title: json["title"],
    code: json["code"],
  );

  Color get getColor => HexColor(color);

  Map<String, dynamic> toJson() => {
    "type": type,
    "color": color,
    "title": title,
    "code": code,
  };
}

class Permission {
  final List<Conversation> conversation;
  final List<Conversation> log;
  final List<Conversation> scanner;
  final List<Conversation> translate;
  final List<Conversation> user;

  Permission({
    required this.conversation,
    required this.log,
    required this.scanner,
    required this.translate,
    required this.user,
  });

  Permission copyWith({
    List<Conversation>? conversation,
    List<Conversation>? log,
    List<Conversation>? scanner,
    List<Conversation>? translate,
    List<Conversation>? user,
  }) =>
      Permission(
        conversation: conversation ?? this.conversation,
        log: log ?? this.log,
        scanner: scanner ?? this.scanner,
        translate: translate ?? this.translate,
        user: user ?? this.user,
      );

  factory Permission.fromJson(Map<String, dynamic> json) => Permission(
    conversation: List<Conversation>.from(json["conversation"].map((x) => Conversation.fromJson(x))),
    log: List<Conversation>.from(json["log"].map((x) => Conversation.fromJson(x))),
    scanner: List<Conversation>.from(json["scanner"].map((x) => Conversation.fromJson(x))),
    translate: List<Conversation>.from(json["translate"].map((x) => Conversation.fromJson(x))),
    user: List<Conversation>.from(json["user"].map((x) => Conversation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "conversation": List<dynamic>.from(conversation.map((x) => x.toJson())),
    "log": List<dynamic>.from(log.map((x) => x.toJson())),
    "scanner": List<dynamic>.from(scanner.map((x) => x.toJson())),
    "translate": List<dynamic>.from(translate.map((x) => x.toJson())),
    "user": List<dynamic>.from(user.map((x) => x.toJson())),
  };
}

class Conversation {
  final String value;
  final int flag;

  Conversation({
    required this.value,
    required this.flag,
  });

  Conversation copyWith({
    String? value,
    int? flag,
  }) =>
      Conversation(
        value: value ?? this.value,
        flag: flag ?? this.flag,
      );

  factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
    value: json["value"],
    flag: json["flag"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "flag": flag,
  };
}
