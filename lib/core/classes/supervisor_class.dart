
class Supervisor {
  final String? id;
  final String? name;

  Supervisor({
    this.id,
    this.name,
  });

  Supervisor copyWith({
    String? id,
    String? name,
  }) =>
      Supervisor(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory Supervisor.fromJson(Map<String, dynamic> json) => Supervisor(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };

  @override
  String toString() {
    return name??'Unknow';
  }
}