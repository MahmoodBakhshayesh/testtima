// document_response.dart
import 'dart:ui';

import 'package:abds/core/classes/basic_class.dart';
import 'package:abds/core/constants/ui.dart';
import 'package:abds/core/utils_and_services/artemis_icons_icons.dart';
import 'package:abds/core/utils_and_services/icomoon_layered_presets_from_css.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../classes/timatic_response_new_class.dart';
import 'location.dart';

// -------------------- ENUM --------------------

enum EvalResult { NO, CONDITIONAL, UNKNOWN, YES }

extension EvalResultX on EvalResult {
  static EvalResult fromJson(dynamic value) {
    if (value == null) return EvalResult.UNKNOWN;
    final lower = value.toString().toLowerCase();
    return EvalResult.values.firstWhere((e) => e.name.toLowerCase() == lower, orElse: () => EvalResult.UNKNOWN);
  }

  String toJson() => name.toUpperCase();

  IconData get getIcon {
    switch (this) {
      case EvalResult.YES:
        return ArtemisIcons.tick_square;
      case EvalResult.NO:
        return ArtemisIcons.close_square;
      case EvalResult.CONDITIONAL:
        return ArtemisIcons.danger;
      case EvalResult.UNKNOWN:
        return ArtemisIcons.warning_2;
    }
  }

  IconData get getIconCircle {
    switch (this) {
      case EvalResult.YES:
        return ArtemisIcons.tick_circle;
      case EvalResult.NO:
        return ArtemisIcons.close_circle;
      case EvalResult.CONDITIONAL:
        return ArtemisIcons.danger;
      case EvalResult.UNKNOWN:
        return ArtemisIcons.warning_2;
    }
  }

  Widget get getIconWidget {
    switch (this) {
      case EvalResult.YES:
        return IcomoonLayeredCss.tick_square(colors: [MyColors.mainGreen.withOpacity(0.3), MyColors.mainGreen], size: 20);
      case EvalResult.NO:
        return IcomoonLayeredCss.close_square(colors: [MyColors.mainRed.withOpacity(0.3), MyColors.mainRed], size: 20);
      case EvalResult.CONDITIONAL:
        return IcomoonLayeredCss.danger(colors: [MyColors.mainOrange.withOpacity(0.3), MyColors.mainOrange], size: 20);
      case EvalResult.UNKNOWN:
        return IcomoonLayeredCss.info_circle(baseColor: MyColors.black);
    }
  }
  Widget get getIconWidgetMini {
    switch (this) {
      case EvalResult.YES:
        return IcomoonLayeredCss.tick_square(colors: [MyColors.mainGreen.withOpacity(0.3), MyColors.mainGreen], size: 15);
      case EvalResult.NO:
        return IcomoonLayeredCss.close_square(colors: [MyColors.mainRed.withOpacity(0.3), MyColors.mainRed], size: 15);
      case EvalResult.CONDITIONAL:
        return IcomoonLayeredCss.danger(colors: [MyColors.mainOrange.withOpacity(0.3), MyColors.mainOrange], size: 15);
      case EvalResult.UNKNOWN:
        return IcomoonLayeredCss.info_circle(baseColor: MyColors.black);
    }
  }

  Color get getColor {
    switch (this) {
      case EvalResult.YES:
        return MyColors.green2;
      case EvalResult.NO:
        return MyColors.red;
      case EvalResult.CONDITIONAL:
        return Colors.orange;
      case EvalResult.UNKNOWN:
        return Colors.grey;
    }
  }

  String get getTitle {
    switch (this) {
      case EvalResult.YES:
        return "Travel Allowed";
      case EvalResult.NO:
        return "Travel Not Allowed";
      case EvalResult.CONDITIONAL:
        return "Travel Allowed - Conditional";
      case EvalResult.UNKNOWN:
        return 'Unknown';
    }
  }

  String get getSubtitle {
    return "View Requirements";
    switch (this) {
      case EvalResult.YES:
        return "Passenger can travel";
      case EvalResult.NO:
        return "Missing or invalid documents";
      case EvalResult.CONDITIONAL:
        return "Verify additional requirements";
      case EvalResult.UNKNOWN:
        return 'Unknown';
    }
  }

  Widget get getSubtitleWidget {
    switch (this) {
      case EvalResult.YES:
        return SizedBox();
      // case EvalResult.NO:
      //   return Container(
      //     height: 72,
      //     decoration: BoxDecoration(color: getColor, borderRadius: BorderRadius.circular(12)),
      //     child: Center(
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           Icon(getIcon, color: Colors.white, size: 25),
      //           const SizedBox(width: 4),
      //           Text(
      //             getSubtitle,
      //             style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15),
      //           ),
      //         ],
      //       ),
      //     ),
      //   );
      // case EvalResult.CONDITIONAL:
      //   return "Verify additional requirements";
      // case EvalResult.UNKNOWN:
      default:
        return Container(
          height: 40,
          margin: EdgeInsets.only(top: 12),
          decoration: BoxDecoration(color: getColor, borderRadius: BorderRadius.circular(12)),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(getIcon, color: Colors.white, size: 20),
                const SizedBox(width: 4),
                Text(
                  getSubtitle,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15),
                ),
              ],
            ),
          ),
        );
    }
  }

  String get getActionName {
    switch (this) {
      case EvalResult.YES:
        return "Check Next Passenger";
      case EvalResult.NO:
        return "View Requirements";
      case EvalResult.CONDITIONAL:
        return "View Requirements";
      case EvalResult.UNKNOWN:
        return 'Unknown';
    }
  }
}

// -------------------- MODELS --------------------

class DocumentResponse {
  final String? transactionId;
  String? refCode;
  int? status;
  final String? passengerId;
  final EvalResult evaluationResult;
  final List<SubmittedDocument>? submittedDocuments;
  final List<SegmentResult> segmentResults;
  final List<dynamic>? traces;

  DocumentResponse({this.status, required this.transactionId, required this.refCode, this.passengerId, this.evaluationResult = EvalResult.UNKNOWN, this.submittedDocuments, required this.segmentResults, this.traces});

  factory DocumentResponse.fromJson(Map<String, dynamic> json) {
    return DocumentResponse(
      transactionId: json['transactionId'],
      refCode: json['refCode'],
      status: json['status'],
      passengerId: json['passengerId'],
      evaluationResult: EvalResultX.fromJson(json['evaluationResult']),
      submittedDocuments: ((json['submittedDocuments'] ?? []) as List?)?.map((e) => SubmittedDocument.fromJson(e)).toList(),
      segmentResults: ((json['segmentResults'] ?? []) as List).map((e) => SegmentResult.fromJson(e)).toList(),
      traces: json['traces'] as List?,
    );
  }

  Map<String, dynamic> toJson() => {
    'transactionId': transactionId,
    'passengerId': passengerId,
    'status': status,
    'refCode': refCode,
    'evaluationResult': evaluationResult.toJson(),
    'submittedDocuments': submittedDocuments?.map((e) => e.toJson()).toList(),
    'segmentResults': segmentResults.map((e) => e.toJson()).toList(),
    'traces': traces,
  };

  DocumentResponse setStatus(int? status) {
    var res = this;
    res.status = status;
    return DocumentResponse.fromJson(res.toJson());
  }
}

class SubmittedDocument {
  final List<DocumentUsability> documentUsability;
  final CodeName? documentCategory;
  final String? documentExpiryDate;
  final CodeName? documentIssueCountry;
  final CodeName? documentCode;

  SubmittedDocument({required this.documentUsability, this.documentCategory, this.documentExpiryDate, required this.documentIssueCountry, required this.documentCode});

  factory SubmittedDocument.fromJson(Map<String, dynamic> json) {
    return SubmittedDocument(
      documentUsability: (json['documentUsability'] as List).map((e) => DocumentUsability.fromJson(e)).toList(),
      documentCategory: json['documentCategory'] != null ? CodeName.fromJson(json['documentCategory']) : null,
      documentExpiryDate: json['documentExpiryDate'],
      documentIssueCountry: json['documentIssueCountry'] == null ? null : CodeName.fromJson(json['documentIssueCountry']),
      documentCode: json['documentCode'] == null ? null : CodeName.fromJson(json['documentCode']),
    );
  }

  Map<String, dynamic> toJson() => {
    'documentUsability': documentUsability.map((e) => e.toJson()).toList(),
    'documentCategory': documentCategory?.toJson(),
    'documentExpiryDate': documentExpiryDate,
    'documentIssueCountry': documentIssueCountry?.toJson(),
    'documentCode': documentCode?.toJson(),
  };
}

class DocumentUsability {
  final List<RuleSetEvaluation> ruleSets;
  final bool canUse;
  final int? segmentIndex;

  DocumentUsability({required this.ruleSets, required this.canUse, this.segmentIndex});

  factory DocumentUsability.fromJson(Map<String, dynamic> json) {
    return DocumentUsability(ruleSets: (json['ruleSets'] as List).map((e) => RuleSetEvaluation.fromJson(e)).toList(), canUse: json['canUse'] ?? false, segmentIndex: json['segmentIndex']);
  }

  Map<String, dynamic> toJson() => {'ruleSets': ruleSets.map((e) => e.toJson()).toList(), 'canUse': canUse, 'segmentIndex': segmentIndex};
}

class SegmentResult {
  final NameOnly arrivingCountry;
  final NameOnly departureCountry;
  final ItinPointLite arrival;
  final ItinPointLite departure;
  final String? regulationApplicability;
  final EvalResult segmentEvaluationResult;
  final List<RuleSetEvaluation> ruleSetEvaluations;
  final CommonBorder? commonBorder;

  SegmentResult({
    required this.arrivingCountry,
    required this.departureCountry,
    required this.arrival,
    required this.departure,
    this.regulationApplicability,
    this.commonBorder,
    this.segmentEvaluationResult = EvalResult.UNKNOWN,
    required this.ruleSetEvaluations,
  });

  factory SegmentResult.fromJson(Map<String, dynamic> json) {
    return SegmentResult(
      arrivingCountry: NameOnly.fromJson(json['arrivingCountry']),
      departureCountry: NameOnly.fromJson(json['departureCountry']),
      arrival: ItinPointLite.fromJson(json['arrival']),
      departure: ItinPointLite.fromJson(json['departure']),
      commonBorder: json["commonBorder"] == null ? null : CommonBorder.fromJson(json["commonBorder"]),
      regulationApplicability: json['regulationApplicability'],
      segmentEvaluationResult: EvalResultX.fromJson(json['segmentEvaluationResult']),
      ruleSetEvaluations: ((json['ruleSetEvaluations'] ?? []) as List).map((e) => RuleSetEvaluation.fromJson(e)).toList(),
    );
  }

  String get route => "${departure.point}-${arrival.point}";

  Map<String, dynamic> toJson() => {
    'arrivingCountry': arrivingCountry.toJson(),
    'departureCountry': departureCountry.toJson(),
    'arrival': arrival.toJson(),
    'departure': departure.toJson(),
    'commonBorder': commonBorder?.toJson(),
    'regulationApplicability': regulationApplicability,
    'segmentEvaluationResult': segmentEvaluationResult.toJson(),
    'ruleSetEvaluations': ruleSetEvaluations.map((e) => e.toJson()).toList(),
  };
}

class ItinPointLite {
  final String point;

  // final LocationType type;
  final String? dateTime;

  ItinPointLite({required this.point, this.dateTime});

  factory ItinPointLite.fromJson(Map<String, dynamic> json) {
    return ItinPointLite(
      point: json['point'],
      // type: LocationType.values.firstWhere((e) => e.name.toLowerCase() == json['type'].toString().toLowerCase(), orElse: () => LocationType.city),
      dateTime: json['dateTime'],
    );
  }

  Map<String, dynamic> toJson() => {
    'point': point,
    // 'type': type.name,
    'dateTime': dateTime,
  };
}

// class RuleSetEvaluation {
//   final bool applicable;
//   final CodeName ruleSetType;
//   final EvalResult evaluationResult;
//   final bool evaluationResultOverridden;
//   final List<DocumentResult> documentResults;
//   final List<Regulation> regulations;
//
//   RuleSetEvaluation({required this.applicable, required this.ruleSetType, this.evaluationResult = EvalResult.UNKNOWN, required this.evaluationResultOverridden, required this.documentResults, required this.regulations});
//
//   factory RuleSetEvaluation.fromJson(Map<String, dynamic> json) {
//     return RuleSetEvaluation(
//       applicable: json['applicable'] ?? false,
//       ruleSetType: CodeName.fromJson(json['ruleSetType']),
//       evaluationResult: EvalResultX.fromJson(json['evaluationResult']),
//       evaluationResultOverridden: json['evaluationResultOverridden'] ?? false,
//       documentResults: ((json['documentResults'] ?? []) as List).map((e) => DocumentResult.fromJson(e)).toList(),
//       regulations: ((json['regulations'] ?? []) as List).map((e) => Regulation.fromJson(e)).toList(),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//     'applicable': applicable,
//     'ruleSetType': ruleSetType.toJson(),
//     'evaluationResult': evaluationResult.toJson(),
//     'evaluationResultOverridden': evaluationResultOverridden,
//     'documentResults': documentResults.map((e) => e.toJson()).toList(),
//     'regulations': regulations.map((e) => e.toJson()).toList(),
//   };
//
//   Color get getColor => BasicClass.getColorForEvaluationResult(evaluationResult.name);
//
//   // evaluationResult.name.toLowerCase() == "no" ? MyColors.red : MyColors.green2;
//
//   IconData get getIcon => evaluationResult.getIcon;
// }

// class DocumentResult {
//   final int documentIndex;
//   final EvalResult evaluationResult;
//   final List<Regulation> regulations;
//
//   DocumentResult({required this.documentIndex, this.evaluationResult = EvalResult.UNKNOWN, required this.regulations});
//
//   factory DocumentResult.fromJson(Map<String, dynamic> json) {
//     return DocumentResult(documentIndex: json['documentIndex'] ?? 0, evaluationResult: EvalResultX.fromJson(json['evaluationResult']), regulations: (json['regulations'] as List).map((e) => Regulation.fromJson(e)).toList());
//   }
//
//   Map<String, dynamic> toJson() => {'documentIndex': documentIndex, 'evaluationResult': evaluationResult.toJson(), 'regulations': regulations.map((e) => e.toJson()).toList()};
// }

// class Regulation {
//   final String code;
//   final String name;
//   final EvalResult evaluationResult;
//   final List<RichTextBlock>? texts;
//   final String? verificationBy;
//
//   Regulation({required this.code, required this.name, this.evaluationResult = EvalResult.UNKNOWN, this.texts, this.verificationBy});
//
//   factory Regulation.fromJson(Map<String, dynamic> json) {
//     return Regulation(
//       code: json['code'],
//       name: json['name'],
//       evaluationResult: EvalResultX.fromJson(json['evaluationResult']),
//       texts: (json['texts'] as List?)?.map((e) => RichTextBlock.fromJson(e)).toList(),
//       verificationBy: json['verificationBy'],
//     );
//   }
//
//   Map<String, dynamic> toJson() => {'code': code, 'name': name, 'evaluationResult': evaluationResult.toJson(), 'texts': texts?.map((e) => e.toJson()).toList(), 'verificationBy': verificationBy};
// }

class RichTextBlock {
  final String text;
  final List<CodeName>? categories;
  final String? verificationMethod;

  RichTextBlock({required this.text, this.categories, this.verificationMethod});

  factory RichTextBlock.fromJson(Map<String, dynamic> json) {
    return RichTextBlock(text: json['text'], categories: (json['categories'] as List?)?.map((e) => CodeName.fromJson(e)).toList(), verificationMethod: json['verificationMethod']);
  }

  Map<String, dynamic> toJson() => {'text': text, 'categories': categories?.map((e) => e.toJson()).toList(), 'verificationMethod': verificationMethod};
}

class CodeName {
  final String code;
  final String name;

  CodeName({required this.code, required this.name});

  factory CodeName.fromJson(Map<String, dynamic> json) {
    return CodeName(code: json['code'], name: json['name']);
  }

  Map<String, dynamic> toJson() => {'code': code, 'name': name};
}

class NameOnly {
  final String name;

  NameOnly({required this.name});

  factory NameOnly.fromJson(Map<String, dynamic> json) {
    return NameOnly(name: json['name']);
  }

  Map<String, dynamic> toJson() => {'name': name};
}

class CommonBorder {
  final String? value;
  final String? text;

  CommonBorder({this.value, this.text});

  factory CommonBorder.fromJson(Map<String, dynamic> json) => CommonBorder(value: json["value"], text: json["text"]);

  Map<String, dynamic> toJson() => {"value": value, "text": text};
}
