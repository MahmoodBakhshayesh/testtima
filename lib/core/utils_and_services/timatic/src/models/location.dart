// location.dart
// Manual models: no json_serializable, no build_runner.

// enum LocationType {
//   city,
//   country,
//   airport,
//   seaport,
//   railwayStation,
//   busTerminal,
//   heliport;
//
//   /// Case-insensitive parse from JSON string.
//   static LocationType fromJson(dynamic value) {
//     if (value == null) {
//       throw ArgumentError('LocationType.fromJson: value is null');
//     }
//     final s = value.toString().trim().toLowerCase();
//     return LocationType.values.firstWhere(
//           (e) => e.name.toLowerCase() == s,
//       orElse: () => throw ArgumentError('Unknown LocationType: $value'),
//     );
//   }
//
//   /// Uppercased string for API requests.
//   String toJson() => name.toUpperCase();
// }
//
// class Location {
//   final LocationType type;
//   final String code3;   // e.g., "AAA"
//   final String? code2;  // optional (e.g., "AA")
//   final String name;    // e.g., "Anaa"
//
//   const Location({
//     required this.type,
//     required this.code3,
//     this.code2,
//     required this.name,
//   });
//
//   Location copyWith({
//     LocationType? type,
//     String? code3,
//     String? code2,
//     String? name,
//   }) {
//     return Location(
//       type: type ?? this.type,
//       code3: code3 ?? this.code3,
//       code2: code2 ?? this.code2,
//       name: name ?? this.name,
//     );
//   }
//
//   factory Location.fromJson(Map<String, dynamic> json) {
//     if (json['type'] == null) {
//       throw ArgumentError('Location.fromJson: "type" is required');
//     }
//     // if (json['code3'] == null) {
//     //   throw ArgumentError('Location.fromJson: "code3" is required');
//     // }
//     if (json['name'] == null) {
//       throw ArgumentError('Location.fromJson: "name" is required');
//     }
//     return Location(
//       type: LocationType.fromJson(json['type']),
//       code3: (json['code3']??'').toString(),
//       code2: json['code2']?.toString(),
//       name: json['name'].toString(),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//     'type': type.toJson(), // uppercased
//     'code3': code3,
//     if (code2 != null) 'code2': code2,
//     'name': name,
//   };
//
//   @override
//   String toString() => "$code3";
//
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//           other is Location &&
//               runtimeType == other.runtimeType &&
//               type == other.type &&
//               code3 == other.code3 &&
//               code2 == other.code2 &&
//               name == other.name;
//
//   @override
//   int get hashCode => Object.hash(type, code3, code2, name);
// }
//
// class LocationsEnvelope {
//   final List<Location> locations;
//
//   const LocationsEnvelope({required this.locations});
//
//   LocationsEnvelope copyWith({List<Location>? locations}) =>
//       LocationsEnvelope(locations: locations ?? this.locations);
//
//   factory LocationsEnvelope.fromJson(Map<String, dynamic> json) {
//     final list = (json['locations'] as List<dynamic>? ?? const [])
//         .map((e) => Location.fromJson(e as Map<String, dynamic>))
//         .toList();
//     return LocationsEnvelope(locations: list);
//   }
//
//   Map<String, dynamic> toJson() => {
//     'locations': locations.map((e) => e.toJson()).toList(),
//   };
//
//   @override
//   String toString() => 'LocationsEnvelope(${locations.length} locations)';
// }
