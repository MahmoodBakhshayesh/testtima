class OverallPerformance {
  final int timaticResult;
  final String totalResultRole;
  final int totalResult;
  final int count;

  OverallPerformance({
    required this.timaticResult,
    required this.totalResultRole,
    required this.totalResult,
    required this.count,
  });

  OverallPerformance copyWith({
    int? timaticResult,
    String? totalResultRole,
    int? totalResult,
    int? count,
  }) =>
      OverallPerformance(
        timaticResult: timaticResult ?? this.timaticResult,
        totalResultRole: totalResultRole ?? this.totalResultRole,
        totalResult: totalResult ?? this.totalResult,
        count: count ?? this.count,
      );

  factory OverallPerformance.fromJson(Map<String, dynamic> json) => OverallPerformance(
    timaticResult: json["timaticResult"],
    totalResultRole: json["totalResultRole"],
    totalResult: json["totalResult"],
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "timaticResult": timaticResult,
    "totalResultRole": totalResultRole,
    "totalResult": totalResult,
    "count": count,
  };
}