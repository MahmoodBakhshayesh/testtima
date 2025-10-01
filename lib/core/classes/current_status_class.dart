class CurrentStatus {
  final List<StatusSupervisor>? supervisor;
  final int? status;
  final bool? read;
  final String? airline;
  final String? employeeId;
  final DateTime? flightDt;
  final String? flightNumber;
  final String? from;
  final String? nationality;
  final int? timaticResult;
  final String? to;
  final String? user;

  CurrentStatus({
    this.supervisor,
    this.status,
    this.read,
    this.airline,
    this.employeeId,
    this.flightDt,
    this.flightNumber,
    this.from,
    this.nationality,
    this.timaticResult,
    this.to,
    this.user,
  });

  CurrentStatus copyWith({
    List<StatusSupervisor>? supervisor,
    int? status,
    bool? read,
    String? airline,
    String? employeeId,
    DateTime? flightDt,
    String? flightNumber,
    String? from,
    String? nationality,
    int? timaticResult,
    String? to,
    String? user,
  }) =>
      CurrentStatus(
        supervisor: supervisor ?? this.supervisor,
        status: status ?? this.status,
        read: read ?? this.read,
        airline: airline ?? this.airline,
        employeeId: employeeId ?? this.employeeId,
        flightDt: flightDt ?? this.flightDt,
        flightNumber: flightNumber ?? this.flightNumber,
        from: from ?? this.from,
        nationality: nationality ?? this.nationality,
        timaticResult: timaticResult ?? this.timaticResult,
        to: to ?? this.to,
        user: user ?? this.user,
      );

  factory CurrentStatus.fromJson(Map<String, dynamic> json) => CurrentStatus(
    supervisor: json["supervisor"] == null ? [] : List<StatusSupervisor>.from(json["supervisor"]!.map((x) => StatusSupervisor.fromJson(x))),
    status: json["status"],
    read: json["read"],
    airline: json["airline"],
    employeeId: json["employeeId"],
    flightDt: json["flightDT"] == null ? null : DateTime.parse(json["flightDT"]),
    flightNumber: json["flightNumber"],
    from: json["from"],
    nationality: json["nationality"],
    timaticResult: json["timaticResult"],
    to: json["to"],
    user: json["user_"],
  );

  bool get isLocked => status ==1;


  Map<String, dynamic> toJson() => {
    "supervisor": supervisor == null ? [] : List<dynamic>.from(supervisor!.map((x) => x.toJson())),
    "status": status,
    "read": read,
    "airline": airline,
    "employeeId": employeeId,
    "flightDT": flightDt?.toIso8601String(),
    "flightNumber": flightNumber,
    "from": from,
    "nationality": nationality,
    "timaticResult": timaticResult,
    "to": to,
    "user_": user,
  };
}

class StatusSupervisor {
  final String? id;
  final int? action;

  StatusSupervisor({
    this.id,
    this.action,
  });

  StatusSupervisor copyWith({
    String? id,
    int? action,
  }) =>
      StatusSupervisor(
        id: id ?? this.id,
        action: action ?? this.action,
      );

  factory StatusSupervisor.fromJson(Map<String, dynamic> json) => StatusSupervisor(
    id: json["id"],
    action: json["action"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "action": action,
  };
}
