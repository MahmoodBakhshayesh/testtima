// lib/src/models/aggregates.dart
import 'parameters.dart';
import 'parameter_type.dart';
import 'location.dart';

class TimaticParams {
  final Map<ParameterType, List<ParameterValue>> byType;
  TimaticParams({required this.byType});

  List<ParameterValue> of(ParameterType type) => byType[type] ?? const [];
}

class TimaticLocations {
  final Map<LocationType, List<Location>> byType;
  TimaticLocations({required this.byType});

  List<Location> of(LocationType type) => byType[type] ?? const [];
}

class TimaticData {
  final TimaticParams params;
  final TimaticLocations locations;
  TimaticData({required this.params, required this.locations});
}
