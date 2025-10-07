// To parse this JSON data, do
//
//     final constantData = constantDataFromJson(jsonString);

import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:abds/core/constants/ui.dart';
import 'package:abds/core/utils_and_services/artemis_icons_icons.dart';
import 'package:abds/core/utils_and_services/timatic/artemis_timatic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils_and_services/icomoon_layered_presets_from_css.dart';

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
  final PermissionCatalog permission;
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
  final List<AvailableLanguage> languages;
  final MandatoryFields? mandatory;
  final List<TimaticResult>? timaticResult;
  final List<String> customerTypeEnum;
  final List<String> userTypeEnum;
  final List<String> customerNameEnum;
  final List<String> customerAirportEnum;

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
    required this.mandatory,
    required this.timaticResult,
    required this.languages,
    required this.customerTypeEnum,
    required this.userTypeEnum,
    required this.customerNameEnum,
    required this.customerAirportEnum,
  });

  VersionedData copyWith({
    List<String>? logNoteType,
    List<String>? textMessage,
    List<DocumentType>? documentType,
    List<DocumentDetailType>? documentDetailType,
    PermissionCatalog? permission,
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
    List<AvailableLanguage>? languages,
    MandatoryFields? mandatory,
    List<TimaticResult>? timaticResult,
    List<String>? customerTypeEnum,
    List<String>? userTypeEnum,
    List<String>? customerNameEnum,
    List<String>? customerAirportEnum,

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
        languages: languages ?? this.languages,
        mandatory: mandatory ?? this.mandatory,
        timaticResult: timaticResult ?? this.timaticResult,
        customerTypeEnum: customerTypeEnum ?? this.customerTypeEnum,
        userTypeEnum: userTypeEnum ?? this.userTypeEnum,
        customerNameEnum: customerNameEnum ?? this.customerNameEnum,
        customerAirportEnum: customerAirportEnum ?? this.customerAirportEnum,
      );

  factory VersionedData.fromJson(Map<String, dynamic> json) => VersionedData(
    logNoteType: List<String>.from((json["logNoteType"]??[]).map((x) => x)),
    textMessage: List<String>.from((json["textMessage"]??[]).map((x) => x)),
    documentType: List<DocumentType>.from(json["documentType"].map((x) => DocumentType.fromJson(x))),
    documentDetailType: List<DocumentDetailType>.from(json["documentDetailType"].map((x) => DocumentDetailType.fromJson(x))),
    permission: PermissionCatalog.fromJson(json["permission"]??{}),
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
    languages: List<AvailableLanguage>.from(json["languages"].map((x) => AvailableLanguage.fromJson(x))),
    mandatory: json["mandatory"] == null ? null : MandatoryFields.fromJson(json["mandatory"]),
    timaticResult: json["timaticResult"] == null ? [] : List<TimaticResult>.from(json["timaticResult"]!.map((x) => TimaticResult.fromJson(x))),
    customerTypeEnum: List<String>.from((json["customerTypeEnum"]??[]).map((x) => x)),
    userTypeEnum: List<String>.from((json["userTypeEnum"]??[]).map((x) => x)),
    customerNameEnum: List<String>.from((json["customerNameEnum"]??[]).map((x) => x)),
    customerAirportEnum: List<String>.from((json["customerAirportEnum"]??[]).map((x) => x)),

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
    "languages": List<dynamic>.from(languages.map((x) => x.toJson())),
    "mandatory": mandatory?.toJson(),
    "timaticResult": timaticResult == null ? [] : List<dynamic>.from(timaticResult!.map((x) => x.toJson())),
    "customerTypeEnum": List<dynamic>.from(customerTypeEnum.map((x) => x)),
    "userTypeEnum": List<dynamic>.from(userTypeEnum.map((x) => x)),
    "customerNameEnum": List<dynamic>.from(customerNameEnum.map((x) => x)),
    "customerAirportEnum": List<dynamic>.from(customerAirportEnum.map((x) => x)),
  };
}

class AvailableLanguage {
  final String? country;
  final String? title;
  final String? dir;
  final String? name;
  final String? language;

  AvailableLanguage({
    this.country,
    this.title,
    this.dir,
    this.name,
    this.language,
  });

  AvailableLanguage copyWith({
    String? country,
    String? title,
    String? dir,
    String? name,
    String? language,
  }) =>
      AvailableLanguage(
        country: country ?? this.country,
        title: title ?? this.title,
        dir: dir ?? this.dir,
        name: name ?? this.name,
        language: language ?? this.language,
      );

  factory AvailableLanguage.fromJson(Map<String, dynamic> json) => AvailableLanguage(
    country: json["country"],
    title: json["title"],
    dir: json["dir"],
    name: json["name"],
    language: json["language"],
  );

  Map<String, dynamic> toJson() => {
    "country": country,
    "title": title,
    "dir": dir,
    "name": name,
    "language": language,
  };
}

class Airport {
  final String type;
  final String code3;
  final String name;
  final String? country;

  Airport({
    required this.type,
    required this.code3,
    required this.name,
    required this.country,
  });

  Airport copyWith({
    String? type,
    String? code3,
    String? name,
    String? country,
  }) =>
      Airport(
        type: type ?? this.type,
        code3: code3 ?? this.code3,
        name: name ?? this.name,
        country: country ?? this.country,
      );

  factory Airport.fromJson(Map<String, dynamic> json) => Airport(
    type: json["type"],
    code3: json["code3"],
    name: json["name"],
    country: json["country"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "code3": code3,
    "name": name,
    "country": country,
  };

  @override
  String toString() => "$code3";
}

class Attribute {
  final List<String> defaultList;
  final String name;
  final String type;
  final bool onlyOwner;
  final bool mandatory;
  final String defaultValue;
  final String? listItemName;


  Attribute({
    required this.defaultList,
    required this.name,
    required this.type,
    required this.onlyOwner,
    required this.mandatory,
    required this.defaultValue,
    required this.listItemName,

  });

  Attribute copyWith({
    List<String>? defaultList,
    String? name,
    String? type,
    bool? onlyOwner,
    bool? mandatory,
    String? defaultValue,
    String? listItemName,
  }) =>
      Attribute(
        defaultList: defaultList ?? this.defaultList,
        name: name ?? this.name,
        type: type ?? this.type,
        onlyOwner: onlyOwner ?? this.onlyOwner,
        mandatory: mandatory ?? this.mandatory,
        defaultValue: defaultValue ?? this.defaultValue,
        listItemName: listItemName ?? this.listItemName,
      );

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
    defaultList: List<String>.from((json["defaultList"]??[]).map((x) => x)),
    name: json["name"],
    type: json["type"].toString().toLowerCase(),
    onlyOwner: json["onlyOwner"],
    mandatory: json["mandatory"]??false,
    defaultValue: json["defaultValue"],
    listItemName: json["listItemName"],
  );

  Map<String, dynamic> toJson() => {
    "defaultList": List<dynamic>.from(defaultList.map((x) => x)),
    "name": name,
    "type": type,
    "onlyOwner": onlyOwner,
    "mandatory": mandatory,
    "defaultValue": defaultValue,
    "listItemName": listItemName,
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

class MandatoryFields {
  final FlightFields? flight;
  final PassengerFields? passenger;
  final DocumentFields? passport;
  final DocumentFields? visa;
  final DocumentFields? idCard;
  final DocumentFields? other;

  MandatoryFields({
    this.flight,
    this.passenger,
    this.passport,
    this.visa,
    this.idCard,
    this.other,
  });

  MandatoryFields copyWith({
    FlightFields? flight,
    PassengerFields? passenger,
    DocumentFields? other,
    DocumentFields? passport,
    DocumentFields? visa,
    DocumentFields? idCard,
  }) =>
      MandatoryFields(
        flight: flight ?? this.flight,
        passenger: passenger ?? this.passenger,
        passport: passport ?? this.passport,
        visa: visa ?? this.visa,
        idCard: idCard ?? this.idCard,
        other: other ?? this.other,
      );

  factory MandatoryFields.fromJson(Map<String, dynamic> json) => MandatoryFields(
    passenger: json["passenger"] == null ? null : PassengerFields.fromJson(json["passenger"]),
    passport: json["passport"] == null ? null : DocumentFields.fromJson(json["passport"]),
    visa: json["visa"] == null ? null : DocumentFields.fromJson(json["visa"]),
    idCard: json["idCard"] == null ? null : DocumentFields.fromJson(json["idCard"]),
    other: json["other"] == null ? null : DocumentFields.fromJson(json["other"]),
    flight: json["flight"] == null ? null : FlightFields.fromJson(json["flight"]),
  );

  Map<String, dynamic> toJson() => {
    "passenger": passenger?.toJson(),
    "other": other?.toJson(),
    "visa": visa?.toJson(),
    "passport": passport?.toJson(),
    "idCard": idCard?.toJson(),
    "flight": flight?.toJson(),
  };
}

class FlightFields {
  final bool flightNumber;
  final bool airline;
  final bool from;
  final bool to;
  final bool departure;
  final bool arrival;
  final bool std;
  final bool sta;
  final bool pos;
  final bool dos;
  final bool ticket;
  final bool flightType;

  FlightFields({
    this.flightNumber =false,
    this.airline=false,
    this.from=false,
    this.to=false,
    this.departure=false,
    this.arrival=false,
    this.std=false,
    this.sta=false,
    this.pos=false,
    this.dos=false,
    this.ticket=false,
    this.flightType=false,
  });

  FlightFields copyWith({
    bool? flightNumber,
    bool? airline,
    bool? from,
    bool? to,
    bool? departure,
    bool? arrival,
    bool? std,
    bool? sta,
    bool? pos,
    bool? dos,
    bool? ticket,
    bool? flightType,
  }) =>
      FlightFields(
        flightNumber: flightNumber ?? this.flightNumber,
        airline: airline ?? this.airline,
        from: from ?? this.from,
        to: to ?? this.to,
        departure: departure ?? this.departure,
        arrival: arrival ?? this.arrival,
        std: std ?? this.std,
        sta: sta ?? this.sta,
        pos: pos ?? this.pos,
        dos: dos ?? this.dos,
        ticket: ticket ?? this.ticket,
        flightType: flightType ?? this.flightType,
      );

  factory FlightFields.fromJson(Map<String, dynamic> json) => FlightFields(
    flightNumber: json["flightNumber"],
    airline: json["airline"],
    from: json["from"],
    to: json["to"],
    departure: json["departure"],
    arrival: json["arrival"],
    std: json["std"],
    sta: json["sta"],
    pos: json["pos"],
    dos: json["dos"],
    ticket: json["ticket"],
    flightType: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "flightNumber": flightNumber,
    "airline": airline,
    "from": from,
    "to": to,
    "departure": departure,
    "arrival": arrival,
    "std": std,
    "sta": sta,
    "pos": pos,
    "dos": dos,
    "ticket": ticket,
    "type": flightType,
  };
}

class PassengerFields {
  final bool notionality;
  final bool resident;
  final bool gender;
  final bool birthPlace;
  final bool birthDate;

  PassengerFields({
    this.notionality = false,
    this.resident = false,
    this.gender = false,
    this.birthPlace = false,
    this.birthDate = false,
  });

  PassengerFields copyWith({
    bool? notionality,
    bool? resident,
    bool? gender,
    bool? birthPlace,
    bool? birthDate,
  }) =>
      PassengerFields(
        notionality: notionality ?? this.notionality,
        resident: resident ?? this.resident,
        gender: gender ?? this.gender,
        birthPlace: birthPlace ?? this.birthPlace,
        birthDate: birthDate ?? this.birthDate,
      );

  factory PassengerFields.fromJson(Map<String, dynamic> json) => PassengerFields(
    notionality: json["notionality"],
    resident: json["resident"],
    gender: json["gender"],
    birthPlace: json["birthPlace"],
    birthDate: json["birthDate"],
  );

  Map<String, dynamic> toJson() => {
    "notionality": notionality,
    "resident": resident,
    "gender": gender,
    "birthPlace": birthPlace,
    "birthDate": birthDate,
  };
}

class DocumentFields {
  final bool code;
  final bool issuedIn;
  final bool notionality;
  final bool expiryDate;
  final bool birthDate;
  final bool documentNumber;

  DocumentFields({
     this.code = false,
     this.issuedIn= false,
     this.notionality= false,
     this.expiryDate= false,
     this.birthDate= false,
     this.documentNumber= false,
  });

  DocumentFields copyWith({
    bool? code,
    bool? issuedIn,
    bool? notionality,
    bool? expiryDate,
    bool? birthDate,
    bool? documentNumber,
  }) =>
      DocumentFields(
        code: code ?? this.code,
        issuedIn: issuedIn ?? this.issuedIn,
        notionality: notionality ?? this.notionality,
        expiryDate: expiryDate ?? this.expiryDate,
        birthDate: birthDate ?? this.birthDate,
        documentNumber: documentNumber ?? this.documentNumber,
      );

  factory DocumentFields.fromJson(Map<String, dynamic> json) => DocumentFields(
    code: json["code"],
    issuedIn: json["issuedIn"],
    notionality: json["notionality"],
    expiryDate: json["expiryDate"],
    birthDate: json["birthDate"],
    documentNumber: json["documentNumber"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "issuedIn": issuedIn,
    "notionality": notionality,
    "expiryDate": expiryDate,
    "birthDate": birthDate,
    "documentNumber": documentNumber,
  };
}

class TimaticResult {
  final int? resultId;
  final String title;
  final String color;

  TimaticResult({
    this.resultId,
    required this.title,
    required this.color,
  });

  TimaticResult copyWith({
    int? resultId,
    String? title,
    String? color,
  }) =>
      TimaticResult(
        resultId: resultId ?? this.resultId,
        title: title ?? this.title,
        color: color ?? this.color,
      );

  factory TimaticResult.fromJson(Map<String, dynamic> json) => TimaticResult(
    resultId: json["resultId"],
    title: json["title"],
    color: json["color"],
  );

  Map<String, dynamic> toJson() => {
    "resultId": resultId,
    "title": title,
    "color": color,
  };

  Color get getColor => HexColor(color!);

  EvalResult get getEvalRes {
    log("or else not ${resultId}");
    return EvalResult.values.firstWhere((a)=>a.index == (resultId!-1),orElse: () {
    log("or else ${resultId}");
    return EvalResult.UNKNOWN;
  });
  }

  IconData? get getIconCircle => getEvalRes.getIconCircle;

  String get getTitle => getEvalRes.getTitle;

  Widget get getSubtitleWidget {
    String text = "";
    Color iconColor = Colors.black;
    Color borderColor = Colors.transparent;

    if(resultId == 1){
      text = "Travel Allowed";
      // borderColor = Colors.white;
      // iconColor = Colors.transparent;
      borderColor = getColor;
      iconColor = getColor;
    }else if(resultId ==2){
      text = "View Requirements";
      borderColor = getColor;
      iconColor = getColor;
    }else if(resultId ==3){
      text = "View Requirements";
      borderColor = getColor;
      iconColor = getColor;
    }
    return Container(
      height: 40,
      margin: EdgeInsets.only(top: 12),
      decoration: BoxDecoration(border: Border.all(color: borderColor), borderRadius: BorderRadius.circular(12)),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 8),
            Icon(Icons.arrow_drop_down,color: Colors.transparent,),
            Expanded(child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                text == "Travel Allowed"?
              IcomoonLayeredCss.tick_square(colors: [iconColor.withOpacity(0.4),iconColor],size: 16):
              IcomoonLayeredCss.danger(colors: [iconColor.withOpacity(0.4),iconColor],size: 16),
              Text(
                text,
                style: TextStyle(color: getColor, fontWeight: FontWeight.w500, fontSize: 15),
              ),
            ],)),
            Icon(Icons.arrow_drop_down,color: iconColor,),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
    // return SizedBox();
    // return Container(
    //   child: Text("View Requirement"),
    // );
    // return getEvalRes.getSubtitleWidget;
  }
  Widget getSubtitleWidgetArrow(bool opened) {
    String text = "";
    Color iconColor = Colors.black;
    Color borderColor = Colors.transparent;

    if(resultId == 1){
      text = "Travel Allowed";
      // borderColor = Colors.white;
      // iconColor = Colors.transparent;
      borderColor = getColor;
      iconColor = getColor;
    }else if(resultId ==2){
      text = "View Requirements";
      borderColor = getColor;
      iconColor = getColor;
    }else if(resultId ==3){
      text = "View Requirements";
      borderColor = getColor;
      iconColor = getColor;
    }
    return Container(
      height: 40,
      margin: EdgeInsets.only(top: 12),
      decoration: BoxDecoration(border: Border.all(color: borderColor), borderRadius: BorderRadius.circular(12)),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            const SizedBox(width: 8),
            Icon(opened? Icons.arrow_drop_down:Icons.arrow_drop_up_outlined,color: Colors.transparent,),
            Expanded(child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                text == "Travel Allowed"?
              IcomoonLayeredCss.tick_square(colors: [iconColor.withOpacity(0.4),iconColor],size: 16):
              IcomoonLayeredCss.danger(colors: [iconColor.withOpacity(0.4),iconColor],size: 16),
              Text(
                text,
                style: TextStyle(color: getColor, fontWeight: FontWeight.w500, fontSize: 15),
              ),
            ],)),
            Icon(!opened? Icons.arrow_drop_down:Icons.arrow_drop_up_outlined,color: iconColor,),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
    // return SizedBox();
    // return Container(
    //   child: Text("View Requirement"),
    // );
    // return getEvalRes.getSubtitleWidget;
  }
  Widget get getIconWidget {
    if(resultId ==1){
      return IcomoonLayeredCss.tick_square(colors: [getColor.withOpacity(0.3), getColor], size: 20);
    }else if(resultId ==2){
      return IcomoonLayeredCss.close_square(colors: [getColor.withOpacity(0.3), getColor], size: 20);
    }else if(resultId ==3){
      return IcomoonLayeredCss.danger(colors: [getColor.withOpacity(0.3), getColor], size: 20);
    }
    // return Icon(Icons.camera,color: getColor,);
    return getEvalRes.getIconWidget;
  }
  Widget get getIconWidgetMini {
    if(resultId ==1){
      return IcomoonLayeredCss.tick_square(colors: [getColor.withOpacity(0.3), getColor], size: 15);
    }else if(resultId ==2){
      return IcomoonLayeredCss.close_square(colors: [getColor.withOpacity(0.3), getColor], size: 15);
    }else if(resultId ==3){

      return IcomoonLayeredCss.danger(colors: [getColor.withOpacity(0.3), getColor], size: 15);
    }
    return getEvalRes.getIconWidgetMini;
  }
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
  String toString() => "$name";
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

  Widget get getIcon {
    if(type == "P"){
      return IcomoonLayeredCss.global(baseColor: MyColors.mainBlue);
    }else if(type == "V"){
      return IcomoonLayeredCss.document_text(colors: [MyColors.mainOrange.withOpacity(0.4),MyColors.mainOrange,MyColors.mainOrange,MyColors.mainOrange,MyColors.mainOrange]);
    }else if(type == "I"){
      return IcomoonLayeredCss.user_square(colors: [MyColors.mainGreen.withOpacity(0.48),MyColors.mainGreen,MyColors.mainGreen]);
    }else{
      return IcomoonLayeredCss.document(colors: [Colors.black.withOpacity(0.2)]);
    }
  }

  Map<String, dynamic> toJson() => {
    "type": type,
    "color": color,
    "title": title,
    "code": code,
  };
}


/// One available permission definition
class PermissionDefinition {
  final String value;
  final int flag;

  const PermissionDefinition({
    required this.value,
    required this.flag,
  });

  factory PermissionDefinition.fromJson(Map<String, dynamic> json) {
    return PermissionDefinition(
      value: json['value'] as String,
      flag: json['flag'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
    'value': value,
    'flag': flag,
  };

  @override
  String toString() => 'PermissionDefinition(value: $value, flag: $flag)';
}

/// The catalog of all available permissions, grouped by area.
/// Example keys: "conversation", "log", "scanner", "translate", "user"
class PermissionCatalog {
  final Map<String, List<PermissionDefinition>> areas;

  const PermissionCatalog({required this.areas});

  factory PermissionCatalog.fromJson(Map<String, dynamic> json) {
    final areas = <String, List<PermissionDefinition>>{};
    json.forEach((key, value) {
      final list = (value as List<dynamic>)
          .map((e) => PermissionDefinition.fromJson(e))
          .toList();
      areas[key] = list;
    });
    return PermissionCatalog(areas: areas);
  }

  Map<String, dynamic> toJson() => areas.map(
        (key, list) => MapEntry(key, list.map((e) => e.toJson()).toList()),
  );

  /// Get available definitions for a specific area
  List<PermissionDefinition> operator [](String area) =>
      areas[area] ?? const [];

  /// Flatten all definitions across all areas
  List<PermissionDefinition> get all =>
      areas.values.expand((e) => e).toList();

  @override
  String toString() => 'PermissionCatalog($areas)';
}

// class Permission {
//   final List<Conversation> conversation;
//   final List<Conversation> log;
//   final List<Conversation> scanner;
//   final List<Conversation> translate;
//   final List<Conversation> user;
//
//   Permission({
//     required this.conversation,
//     required this.log,
//     required this.scanner,
//     required this.translate,
//     required this.user,
//   });
//
//   Permission copyWith({
//     List<Conversation>? conversation,
//     List<Conversation>? log,
//     List<Conversation>? scanner,
//     List<Conversation>? translate,
//     List<Conversation>? user,
//   }) =>
//       Permission(
//         conversation: conversation ?? this.conversation,
//         log: log ?? this.log,
//         scanner: scanner ?? this.scanner,
//         translate: translate ?? this.translate,
//         user: user ?? this.user,
//       );
//
//   factory Permission.fromJson(Map<String, dynamic> json) => Permission(
//     conversation: List<Conversation>.from(json["conversation"].map((x) => Conversation.fromJson(x))),
//     log: List<Conversation>.from(json["log"].map((x) => Conversation.fromJson(x))),
//     scanner: List<Conversation>.from(json["scanner"].map((x) => Conversation.fromJson(x))),
//     translate: List<Conversation>.from(json["translate"].map((x) => Conversation.fromJson(x))),
//     user: List<Conversation>.from(json["user"].map((x) => Conversation.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "conversation": List<dynamic>.from(conversation.map((x) => x.toJson())),
//     "log": List<dynamic>.from(log.map((x) => x.toJson())),
//     "scanner": List<dynamic>.from(scanner.map((x) => x.toJson())),
//     "translate": List<dynamic>.from(translate.map((x) => x.toJson())),
//     "user": List<dynamic>.from(user.map((x) => x.toJson())),
//   };
// }
//
// class Conversation {
//   final String value;
//   final int flag;
//
//   Conversation({
//     required this.value,
//     required this.flag,
//   });
//
//   Conversation copyWith({
//     String? value,
//     int? flag,
//   }) =>
//       Conversation(
//         value: value ?? this.value,
//         flag: flag ?? this.flag,
//       );
//
//   factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
//     value: json["value"],
//     flag: json["flag"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "value": value,
//     "flag": flag,
//   };
// }
