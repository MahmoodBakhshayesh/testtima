import 'package:get/get.dart';

enum PurposeOfStayType {
  vocation,
  business,
  duty;

  @override
  toString() => title.capitalizeFirst!;
}

extension StayTypeDetails on PurposeOfStayType {
  String get title {
    switch (this) {
      case PurposeOfStayType.vocation:
        return 'Tourism/Vacation';
      case PurposeOfStayType.business:
        return 'Business';
      case PurposeOfStayType.duty:
        return 'Duty';
    }
  }

  String get value {
    switch (this) {
      case PurposeOfStayType.vocation:
        return 'VACATION';
      case PurposeOfStayType.business:
        return 'BUSINESS';
      case PurposeOfStayType.duty:
        return 'DUTY';
    }
  }

  static PurposeOfStayType? fromValue(String? v) {
    if (v == null) return null;
    v = v.toUpperCase();
    return PurposeOfStayType.values.firstWhere((e) => e.value == v, orElse: () => throw ArgumentError('Unknown PurposeOfStayType: $v'));
  }

  PurposeOfStayType? purposeOfStayTypeFromJson(String? v) => v == null ? null : PurposeOfStayType.values.firstWhere((e) => e.value == v.toUpperCase(), orElse: () => throw ArgumentError('Unknown PurposeOfStayType: $v'));

  String? purposeOfStayTypeToJson(PurposeOfStayType? t) => t?.value;
}

enum TicketStatus {
  ticket,
  noTicket;

  @override
  toString() => title.capitalizeFirst!;
}

extension TicketStatusDetails on TicketStatus {
  String get title {
    switch (this) {
      case TicketStatus.ticket:
        return "Return/Onward Ticket";
      case TicketStatus.noTicket:
        return "No Ticket";
    }
  }

  String get value {
    switch (this) {
      case TicketStatus.ticket:
        return "TICKET";
      case TicketStatus.noTicket:
        return "NOTICKET";
    }
  }

  static TicketStatus? fromValue(String? v) {
    if (v == null) return null;
    v = v.toUpperCase();
    return TicketStatus.values.firstWhere((e) => e.value == v, orElse: () => throw ArgumentError('Unknown TicketStatus: $v'));
  }

  TicketStatus? ticketStatusFromJson(String? v) => v == null ? null : TicketStatus.values.firstWhere((e) => e.value == v.toUpperCase(), orElse: () => throw ArgumentError('Unknown TicketStatus: $v'));

  String? ticketStatusToJson(TicketStatus? t) => t?.value;
}

enum DocumentFeature {
  biometric,
  digital,
  mrd,
  mrdWithDigitalPhoto,
  none;

  @override
  toString() => title;
}

extension DocumentFeatureDetails on DocumentFeature {
  String get title {
    switch (this) {
      case DocumentFeature.biometric:
        return 'Biometric';
      case DocumentFeature.digital:
        return 'Digital';
      case DocumentFeature.mrd:
        return 'Machine-readable document';
      case DocumentFeature.mrdWithDigitalPhoto:
        return 'Machine-readable document with digital photo';
      case DocumentFeature.none:
        return 'None';
    }
  }

  String get value {
    switch (this) {
      case DocumentFeature.biometric:
        return 'BIOMETRIC';
      case DocumentFeature.digital:
        return 'DIGITAL';
      case DocumentFeature.mrd:
        return 'MRD';
      case DocumentFeature.mrdWithDigitalPhoto:
        return 'MRDWITHDIGITALPHOTO';
      case DocumentFeature.none:
        return 'NONE';
    }
  }

  static DocumentFeature? fromValue(String? v) {
    if (v == null) return null;
    v = v.toUpperCase();
    return DocumentFeature.values.firstWhere((e) => e.value == v, orElse: () => throw ArgumentError('Unknown DocumentFeature: $v'));
  }

  DocumentFeature? documentFeatureFromJson(String? v) => v == null ? null : DocumentFeature.values.firstWhere((e) => e.value == v.toUpperCase(), orElse: () => throw ArgumentError('Unknown DocumentFeature: $v'));

  String? documentFeatureToJson(DocumentFeature? t) => t?.value;
}

enum Gender { male, female, other, undisclosedU, unspecifiedX }

extension GenderDetails on Gender {
  String get title {
    switch (this) {
      case Gender.male:
        return "Male";
      case Gender.female:
        return "Female";
      case (Gender.other):
        return "Other";
      case Gender.undisclosedU:
        return "Undisclosed U";
      case Gender.unspecifiedX:
        return "Unspecified X";
    }
  }

  String get value {
    switch (this) {
      case Gender.male:
        return "M";
      case Gender.female:
        return "F";
      case Gender.other:
        return "O";
      case Gender.undisclosedU:
        return "U";
      case Gender.unspecifiedX:
        return "X";
    }
  }

  static Gender? fromValue(String? v) {
    if (v == null) return null;
    v = v.toUpperCase();
    return Gender.values.firstWhere((e) => e.value == v, orElse: () => throw ArgumentError('Unknown Gender: $v'));
  }

  Gender? genderFromJson(String? v) => v == null ? null : Gender.values.firstWhere((e) => e.value == v.toUpperCase(), orElse: () => throw ArgumentError('Unknown Gender: $v'));

  String? genderToJson(Gender? t) => t?.value;
}

enum SegmentType {
  entry,
  transit;

  @override
  toString() {
    return title.toUpperCase();
  }
}

extension SegmentTypeDetails on SegmentType {
  String get title {
    switch (this) {
      case SegmentType.transit:
        return "Transit";
      case SegmentType.entry:
        return "Entry";
    }
  }

  String get value {
    switch (this) {
      case SegmentType.entry:
        return toString();
      case SegmentType.transit:
        return toString();
    }
  }

  static SegmentType? fromValue(String? v) {
    if (v == null) return null;
    v = v.toUpperCase();
    return SegmentType.values.firstWhere((e) => e.value.toUpperCase() == v?.toUpperCase(), orElse: () => throw ArgumentError('Unknown SegmentType: $v'));
  }

  SegmentType? segmentTypeFromJson(String? v) => v == null ? null : SegmentType.values.firstWhere((e) => e.value.toUpperCase() == v.toUpperCase(), orElse: () => throw ArgumentError('Unknown Gender: $v'));

  String? genderToJson(SegmentType? t) => t?.value;
}
