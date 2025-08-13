import 'package:abds/core/classes/basic_class.dart';
import 'package:artemis_utils/artemis_utils.dart';
import 'package:flutter/material.dart';

import '../utils_and_services/timatic/artemis_timatic.dart';

class BoardingPass {
  BoardingPass({
    required this.fistName,
    required this.lastName,
    required this.seq,
    required this.fromCity,
    this.fromCityName,
    required this.toCity,
    this.toCityName,
    required this.al,
    required this.flnb,
    required this.classType,
    this.boardingPassDataClass,
    required this.flightDate,
    this.std,
    required this.pnr,
    this.boardingTime,
    required this.seat,
    this.gate,
    this.fqtv,
    this.ssRs,
    this.zone,
    this.extraSeat,
    this.documentNumber,
    this.ticketNumber,
    this.agent,
    required this.barcodeData,
    required this.julianDate,
    this.comment,
    this.remark,
    this.boardTime,
    this.apis,
    this.optional1,
    this.optional2,
    this.baggageTotalCount,
    this.baggageTotalWeight,
  });

  String fistName;
  String lastName;
  String seq;
  String fromCity;
  String? fromCityName;
  String toCity;
  String? toCityName;
  String al;
  String flnb;
  String classType;
  String? boardingPassDataClass;
  DateTime flightDate;
  DateTime? boardTime;
  String? std;
  String pnr;
  String? boardingTime;
  String seat;
  String? gate;
  String? fqtv;
  String? ssRs;
  String? zone;
  String? extraSeat;
  String? documentNumber;
  String? ticketNumber;
  String? agent;
  String barcodeData;
  String? comment;
  String? remark;
  String? apis;
  String? optional1;
  String? optional2;
  int? baggageTotalCount;
  int? baggageTotalWeight;
  int julianDate;

  factory BoardingPass.fromJson(Map<String, dynamic> json) => BoardingPass(
    fistName: json["FistName"],
    lastName: json["LastName"],
    julianDate: json["JulianDate"],
    seq: json["SEQ"],
    fromCity: json["FromCity"],
    fromCityName: json["FromCityName"],
    toCity: json["ToCity"],
    toCityName: json["ToCityName"],
    al: json["AL"],
    flnb: json["FLNB"],
    classType: json["ClassType"],
    boardingPassDataClass: json["Class"],
    flightDate: DateTime.parse(json["FlightDate"]),
    boardTime: DateTime.tryParse(json["BoardTime"]),
    std: json["STD"],
    pnr: json["PNR"],
    boardingTime: json["BordingTime"],
    seat: json["Seat"],
    gate: json["Gate"],
    fqtv: json["FQTV"],
    ssRs: json["SSRs"],
    zone: json["Zone"],
    extraSeat: json["ExtraSeat"],
    documentNumber: json["DocumentNumber"],
    ticketNumber: json["TicketNumber"],
    agent: json["Agent"],
    barcodeData: json["BarcodeData"],
    comment: json["Comment"],
    remark: json["Remark"],
    apis: json["APIS"],
    optional1: json["Optional1"],
    optional2: json["Optional2"],
    baggageTotalCount: json["BaggageTotalCount"],
    baggageTotalWeight: json["BaggageTotalWeight"],
  );

  factory BoardingPass.fromBarcode(String barcode) {
    String name = barcode.substring(2, 22).trim();
    int julian = int.parse(barcode.substring(44, 47).trim());
    // DateTime fDate = DateTime(DateTime.now().year, 1, 1, 0, 0, 0, 0, 0)
    //     .add(Duration(days: julian));
    DateTime fDate = julianToDateTime(int.tryParse(barcode.substring(44, 47).trim()) ?? 0);

    return BoardingPass(
      fistName: name.split(" ").first,
      lastName: name.replaceFirst(name.split(" ").first, ""),
      fromCity: barcode.substring(30, 33).trim(),
      pnr: barcode.substring(22, 30).trim(),
      toCity: barcode.substring(33, 36).trim(),
      flnb: barcode.substring(39, 44).trim(),
      al: barcode.substring(36, 39).trim(),
      classType: barcode.substring(47, 48).trim(),
      seat: barcode.substring(48, 51).trim(),
      seq: barcode.substring(52, 56).trim(),
      barcodeData: barcode,
      julianDate: julian,
      flightDate: fDate,
    );
  }

  Map<String, dynamic> toJson() => {
    "FistName": fistName,
    "LastName": lastName,
    "SEQ": seq,
    "FromCity": fromCity,
    "JulianDate": julianDate,
    "BoardTime": boardTime,
    "FromCityName": fromCityName,
    "ToCity": toCity,
    "ToCityName": toCityName,
    "AL": al,
    "FLNB": flnb,
    "ClassType": classType,
    "Class": boardingPassDataClass,
    "FlightDate": "${flightDate.year.toString().padLeft(4, '0')}-${flightDate.month.toString().padLeft(2, '0')}-${flightDate.day.toString().padLeft(2, '0')}",
    "STD": std,
    "PNR": pnr,
    "BordingTime": boardingTime,
    "Seat": seat,
    "Gate": gate,
    "FQTV": fqtv,
    "SSRs": ssRs,
    "Zone": zone,
    "ExtraSeat": extraSeat,
    "DocumentNumber": documentNumber,
    "TicketNumber": ticketNumber,
    "Agent": agent,
    "BarcodeData": barcodeData,
    "Comment": comment,
    "Remark": remark,
    "APIS": apis,
    "Optional1": optional1,
    "Optional2": optional2,
    "BaggageTotalCount": baggageTotalCount,
    "BaggageTotalWeight": baggageTotalWeight,
  };

  Flight get getFlight => Flight(
    id: '0',
    flnb: flnb,
    al: al,
    time: '--:--',
    pcb: '',
    from: fromCity,
    to: toCity,
    registration: '',
    date: flightDate,
    isTest: false,
    isInternational: false,
    gate: gate,
    aircraftId: null,
    dateTime: flightDate,
    pcbColor: 'FFFFFF',
    std: TimeOfDay(hour: 0, minute: 0),
    sta: TimeOfDay(hour: 0, minute: 0),
    btd: TimeOfDay(hour: 0, minute: 0),
    duration: Duration(),
    checkinStatusId: 1,
    boardingStatusId: 1,
    generalStatusId: 1,
    loadControlStatusId: 1,
    aircraft: null,
    needBackupConfig: false,
    etd: TimeOfDay(hour: 0, minute: 0),
    isBackup: false,
    eta: TimeOfDay(hour: 0, minute: 0),
    route: '$fromCity-$toCity',
  );

  // FlightLeg get getFlightLeg => FlightLeg(departureDatetime: getFlight.dateTime, arrivalDatetime:  getFlight.dateTime, showMore: false,departureAirport: BasicClass.airports.firstWhere((a)=>a.code3 == getFlight.from,orElse: ()=>Location(code3: getFlight.from, name: getFlight.from, type: LocationType.AIRPORT)),arrivalAirport: BasicClass.airports.firstWhere((a)=>a.code3 == getFlight.to,orElse: ()=>Location(code3: getFlight.to, name: getFlight.to, type: LocationType.AIRPORT)));

  ItinerarySegment get getFlightLeg => ItinerarySegment(
    operatingCarrier: BasicClass.getAirlineWithCode(al),
    arrival: ItinPoint(point: getFlight.to, type: LocationType.airport, dateTime: flightDate),
    departure: ItinPoint(point: getFlight.from, type: LocationType.airport, dateTime: flightDate),
    processingEntity: "ABOMIS DOC CHECK",
  );

  String get toBarcode =>
      "M1${(fistName.trim() + ' ' + lastName.trim()).padRight(20, " ").substring(0, 20)}${pnr.padRight(8)}${fromCity}${toCity}${al.padRight(3, " ")}${flnb.padRight(5, " ")}${julianDate.toString().padRight(3, " ")}${classType.padRight(1, " ")}${seat.padRight(4, " ")}${seq.padRight(5, " ")}100";

  String get getClass => classType == "F"
      ? "First"
      : classType == "B"
      ? "Business"
      : "Economy";
}

DateTime julianToDateTime(int julianDay) {
  return DateTime(DateTime.now().year).add(Duration(days: julianDay - 1));
}

int dateTimeToJulian(DateTime date) {
  final julianEpoch = DateTime.utc(-4713, 11, 24, 12, 0, 0);
  // int julianDayNumber(DateTime date) =>
  //     date.difference(julianEpoch).inDays;
  // double julianDay(DateTime date) =>
  //     date.difference(julianEpoch).inSeconds / Duration.secondsPerDay;
  // DateTime dateFromJulianDay(num julianDay) =>
  //     julianEpoch + Duration(milliseconds: (julianDay * Duration.milliSecondsPerDay).floor());
  // double modifiedJulianDay(DateTime date) => julianDay(date) - 2400000.5;

  return date.difference(DateTime(DateTime.now().year)).inDays + 1;
}

class Flight {
  Flight({
    required this.id,
    required this.flnb,
    required this.al,
    required this.time,
    required this.pcb,
    required this.from,
    required this.to,
    required this.registration,
    required this.date,
    required this.isTest,
    required this.isInternational,
    required this.gate,
    required this.aircraftId,
    required this.dateTime,
    required this.pcbColor,
    required this.std,
    required this.sta,
    required this.btd,
    required this.duration,
    required this.checkinStatusId,
    required this.boardingStatusId,
    required this.generalStatusId,
    required this.loadControlStatusId,
    required this.aircraft,
    required this.needBackupConfig,
    required this.etd,
    required this.isBackup,
    required this.eta,
    this.ata,
    this.atd,
    this.chute,
    this.noSeatLimitation,
    required this.route,
    this.needDoco = false,
    this.needDoca = false,
    this.needDocs = false,
    this.hasVoucher = false,
    this.addEachTag = false,
    this.freeSeat = false,
  });

  String id;
  String flnb;
  String al;
  String time;
  String pcb;
  String from;
  String to;
  String? registration;
  DateTime date;
  bool isTest;
  bool addEachTag;
  bool hasVoucher;
  bool needBackupConfig;
  bool isInternational;
  bool isBackup;
  String? gate;
  String? aircraft;
  int? aircraftId;
  int? noSeatLimitation;
  DateTime dateTime;
  String pcbColor;
  TimeOfDay? std;
  TimeOfDay? sta;
  TimeOfDay? btd;
  TimeOfDay? eta;
  TimeOfDay? ata;
  TimeOfDay? etd;
  TimeOfDay? atd;
  Duration duration;
  int checkinStatusId;
  int boardingStatusId;
  int generalStatusId;
  int loadControlStatusId;
  bool needDoco;
  bool needDoca;
  bool needDocs;
  bool freeSeat;

  String? route;
  String? chute;

  factory Flight.fromJson(Map<String, dynamic> json) {
    return Flight(
      id: json["ID"].toString(),
      flnb: json["FLNB"],
      al: json["AL"],
      time: json["Time"] ?? json["TIME"] ?? json["STD"],
      pcb: json["PCB"] ?? "0/0/0",
      from: json["From"],
      to: json["To"],
      noSeatLimitation: json["NoSeatLimitation"],
      registration: json["Registration"],
      date: json["Date"] == null ? DateTime.now() : DateTime.parse(json["Date"]),
      isTest: json["IsTest"],
      needDoca: json["NeedDoca"] ?? false,
      needDoco: json["NeedDoco"] ?? false,
      needDocs: json["NeedDocs"] ?? false,
      isBackup: json["IsBackup"] ?? false,
      hasVoucher: json["HasVoucher"] ?? false,
      addEachTag: json["AddEachTag"] ?? false,
      isInternational: json["IsInternational"] ?? false,
      needBackupConfig: json["NeedBackupConfig"] ?? false,
      freeSeat: json["FreeSeat"] ?? false,
      gate: json["Gate"],
      aircraftId: json["AircraftID"],
      dateTime: DateTime.parse(json["DateTime"]),
      pcbColor: json["PcbColor"] ?? "FFFFFF",
      std: json["STD"]?.toString().tryTimeOfDay,
      sta: json["STA"]?.toString().tryTimeOfDay,
      btd: json["BTD"]?.toString().tryTimeOfDay,
      eta: ((json["ETA"] ?? "").toString().trim().isEmpty) ? null : json["ETA"].toString().tryTimeOfDay!,
      etd: ((json["ETD"] ?? "").toString().trim().isEmpty) ? null : json["ETD"].toString().tryTimeOfDay!,
      ata: ((json["ATA"] ?? "").toString().trim().isEmpty) ? null : json["ATA"].toString().tryTimeOfDay!,
      atd: ((json["ATD"] ?? "").toString().trim().isEmpty) ? null : json["ATD"].toString().tryTimeOfDay!,
      duration: (json["Duration"]?.toString().tryDuration) ?? const Duration(minutes: 90),
      checkinStatusId: json["CheckinStatusID"] ?? 1,
      boardingStatusId: json["BoardingStatusID"],
      generalStatusId: json["GeneralStatusID"],
      loadControlStatusId: json["LoadControlStatusID"],
      aircraft: json["Aircraft"],
      route: json["Route"],
      chute: json["Chute"],
    );
  }

  Map<String, dynamic> toJson() => {
    "ID": id,
    "FLNB": flnb,
    "AL": al,
    "Time": time,
    "PCB": pcb,
    "From": from,
    "To": to,
    "Registration": registration,
    "NoSeatLimitation": noSeatLimitation,
    "Date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "IsTest": isTest,
    "IsInternational": isInternational,
    "FreeSeat": freeSeat,
    "Gate": gate,
    "AircraftID": aircraftId,
    "DateTime": "${dateTime.year.toString().padLeft(4, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}",
    "PcbColor": pcbColor,
    "STD": std?.format_HHmm,
    "STA": sta.format_HHmm,
    "BTD": btd.format_HHmm,
    "Duration": duration.formatHHMM,
    "CheckinStatusID": checkinStatusId,
    "BoardingStatusID": boardingStatusId,
    "GeneralStatusID": generalStatusId,
    "LoadControlStatusID": loadControlStatusId,
    "Route": route,
    "Chute": chute,
    "AddEachTag": addEachTag,
    "HasVoucher": hasVoucher,
  };

  factory Flight.example() => Flight(
    id: "1",
    flnb: "1110",
    al: "ZZ",
    time: "22:11",
    sta: TimeOfDay.now(),
    std: TimeOfDay.now(),
    btd: TimeOfDay.now(),
    pcb: "111/22/3",
    from: "YVR",
    to: "DXB",
    route: "YVR-DXB",
    duration: const Duration(minutes: 90),
    registration: "22-199",
    date: DateTime.now(),
    isTest: false,
    needBackupConfig: false,
    gate: 'A2',
    aircraft: '319',
    pcbColor: '77eb34',
    dateTime: DateTime.now(),
    loadControlStatusId: 1,
    checkinStatusId: 1,
    generalStatusId: 1,
    aircraftId: 1,
    isInternational: false,
    boardingStatusId: 1,
    etd: TimeOfDay.now(),
    eta: TimeOfDay.now(),
    isBackup: false,
  );

  Flight addPcb(Flight b) {
    String p = pcb;
    String n = b.pcb;
    String addPCB = "${int.parse(p.split("/")[0]) + int.parse(n.split("/")[0])}/${int.parse(p.split("/")[1]) + int.parse(n.split("/")[1])}/${int.parse(p.split("/")[2]) + int.parse(n.split("/")[2])}";
    Flight f = Flight.example();
    f.pcb = addPCB;
    return f;
  }

  bool validateSearch(String s) {
    return s.isEmpty || "$al $flnb $to".toLowerCase().contains(s.toLowerCase());
  }

  @override
  String toString() {
    return "${al}${flnb}";
  }
}
