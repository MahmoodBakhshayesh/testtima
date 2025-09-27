// // lib/src/models/aggregates.dart
// import 'dart:developer';
//
// import '../../../../classes/constant_data_class.dart';
// import 'parameters.dart';
// import 'parameter_type.dart';
// import 'location.dart';
//
// class TimaticParams {
//   final Map<ParameterType, List<ParameterValue>> byType;
//   TimaticParams({required this.byType});
//
//   List<ParameterValue> of(ParameterType type) => byType[type] ?? const [];
// }
//
// class TimaticLocations {
//   final Map<LocationType, List<Location>> byType;
//   TimaticLocations({required this.byType});
//
//   List<Location> of(LocationType type) {
//     final res =  byType[type] ?? const [];
//
//     res.sort((a,b)=>a.code3.compareTo(b.code3));
//     // log("${res.firstOrNull?.code3} ${res.firstOrNull?.toString()} ${res.firstOrNull?.name}");
//     return res.where((a)=>a.code3.isNotEmpty).toList();
//   }
// }
//
// class TimaticData {
//   final TimaticParams params;
//   final TimaticLocations locations;
//   TimaticData({required this.params, required this.locations});
// }
