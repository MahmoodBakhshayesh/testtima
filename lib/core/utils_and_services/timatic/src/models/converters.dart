// converters.dart
// Manual helper functions for date, time, and enum parsing.

import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'location.dart';

/// --- Date / Time formatting helpers ---

/// Parses a `YYYY-MM-DD` string into a [DateTime] (date only).
DateTime? parseDate(dynamic value) {
  if (value == null) return null;
  if (value is DateTime) return value;
  if (value is String && value.trim().isNotEmpty) {
    try {
      return DateTime.parse(value);
    } catch (_) {}
  }
  return null;
}

/// Formats a [DateTime] into `YYYY-MM-DD` string, or null.
String? formatDate(DateTime? date) {
  if (date == null) return null;
  return "${date.year.toString().padLeft(4, '0')}-"
      "${date.month.toString().padLeft(2, '0')}-"
      "${date.day.toString().padLeft(2, '0')}";
}

/// Parses a `HH:mm` or `HH:mm:ss` string into a [DateTime] (time only).
TimeOfDay? parseTime(dynamic value) {
  if (value == null) return null;
  if (value is TimeOfDay) return value;
  if (value is String && value.trim().isNotEmpty) {
    try {
      final parts = value.split(':').map(int.parse).toList();
      final dt =  DateTime(0, 1, 1, parts[0], parts.length > 1 ? parts[1] : 0,
          parts.length > 2 ? parts[2] : 0);
      return TimeOfDay.fromDateTime(dt);
    } catch (_) {}
  }
  return null;
}

/// Formats a [DateTime] into `HH:mm` string, or null.
String? formatTime(DateTime? time) {
  if (time == null) return null;
  return "${time.hour.toString().padLeft(2, '0')}:"
      "${time.minute.toString().padLeft(2, '0')}";
}

/// Parses an ISO 8601 datetime string into [DateTime].
DateTime? parseDateTime(dynamic value) {
  if (value == null) return null;
  if (value is DateTime) return value;
  if (value is String && value.trim().isNotEmpty) {
    try {
      return DateTime.parse(value);
    } catch (_) {}
  }
  return null;
}

/// Formats [DateTime] into ISO 8601 string.
String? formatDateTime(DateTime? dateTime) {
  if (dateTime == null) return null;
  return DateFormat("yyyy-MM-ddThh:mm:ss").format(dateTime);
}

/// --- Enum Parsing Helpers ---

/// Case-insensitive string to enum parser
T? parseEnum<T>(List<T> values, String? input) {
  if (input == null) return null;
  final lower = input.toLowerCase();
  return values.firstWhere(
        (v) => v.toString().split('.').last.toLowerCase() == lower,
    orElse: () => null as T,
  );
}

/// Case-insensitive parser for LocationType
extension LocationTypeX on LocationType {
  static LocationType fromJson(String value) {
    final lower = value.toLowerCase();
    return LocationType.values.firstWhere(
          (e) => e.name.toLowerCase() == lower,
      orElse: () => LocationType.city, // default fallback
    );
  }
}
