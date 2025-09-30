class FlightHistoryData {
  final String? region;
  final String? flightNumber;
  final String? airline;
  final String? from;
  final String? to;

  FlightHistoryData({
    this.region,
    this.flightNumber,
    this.airline,
    this.from,
    this.to,
  });

  FlightHistoryData copyWith({
    String? region,
    String? flightNumber,
    String? airline,
    String? from,
    String? to,
  }) =>
      FlightHistoryData(
        region: region ?? this.region,
        flightNumber: flightNumber ?? this.flightNumber,
        airline: airline ?? this.airline,
        from: from ?? this.from,
        to: to ?? this.to,
      );

  factory FlightHistoryData.fromJson(Map<String, dynamic> json) => FlightHistoryData(
    region: json["region"],
    flightNumber: json["flightNumber"],
    airline: json["airline"],
    from: json["from"],
    to: json["to"],
  );

  Map<String, dynamic> toJson() => {
    "region": region,
    "flightNumber": flightNumber,
    "airline": airline,
    "from": from,
    "to": to,
  };
}