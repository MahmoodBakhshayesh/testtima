class DurationOfStay {
  String timeUnit;
  int duration;

  DurationOfStay({
    required this.timeUnit,
    required this.duration,
  });

  factory DurationOfStay.fromJson(Map<String, dynamic> json) {
    return DurationOfStay(
      timeUnit: json['timeUnit'] ?? '',
      duration: json['duration'] is int
          ? json['duration']
          : int.tryParse(json['duration']?.toString() ?? '0') ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'timeUnit': timeUnit,
    'duration': duration,
  };

  String get formatDurationUnit => "$duration $timeUnit";
}
