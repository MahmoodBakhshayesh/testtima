// enum DateRangeEnum { thisWeek, thisMonth, lastWeek, lastMonth }
//
// /// Your rules:
// /// - thisWeek  = last 7 days from today (rolling)
// /// - thisMonth = last 30 days from today (rolling)
// /// - lastWeek  = the whole calendar week *before* the current one (Mon–Sun, ISO)
// /// - lastMonth = the whole calendar month *before* the current one
// ///
// /// Returns a Dart record: ({DateTime start, DateTime end})
// ({DateTime start, DateTime end}) getDateRange(
//     DateRangeEnum type, {
//       DateTime? now,
//       bool dateOnly = true, // snap to start/end of day
//     }) {
//   final base = now ?? DateTime.now();
//
//   DateTime startOfDay(DateTime d) => DateTime(d.year, d.month, d.day);
//   DateTime endOfDay(DateTime d) =>
//       DateTime(d.year, d.month, d.day + 1).subtract(const Duration(microseconds: 1));
//
//   // ISO week starts on Monday (weekday: 1=Mon ... 7=Sun)
//   DateTime startOfIsoWeek(DateTime d) {
//     final day = dateOnly ? startOfDay(d) : d;
//     return startOfDay(day.subtract(Duration(days: day.weekday - 1)));
//   }
//
//   // Rolling windows (include today)
//   ({DateTime start, DateTime end}) pastDays(int days) {
//     final today = dateOnly ? startOfDay(base) : base;
//     final start = (dateOnly ? startOfDay(today) : today).subtract(Duration(days: days - 1));
//     final end = dateOnly ? endOfDay(today) : base;
//     return (start: start, end: end);
//   }
//
//   switch (type) {
//     case DateRangeEnum.thisWeek:   // last 7 days (rolling)
//       return pastDays(7);
//
//     case DateRangeEnum.thisMonth:  // last 30 days (rolling)
//       return pastDays(30);
//
//     case DateRangeEnum.lastWeek:   // full previous ISO week (Mon–Sun)
//       final thisWeekStart = startOfIsoWeek(base);
//       final lastWeekStart = thisWeekStart.subtract(const Duration(days: 7));
//       final lastWeekEnd = lastWeekStart.add(const Duration(days: 6));
//       return (
//       start: dateOnly ? startOfDay(lastWeekStart) : lastWeekStart,
//       end: dateOnly ? endOfDay(lastWeekEnd) : lastWeekEnd
//       );
//
//     case DateRangeEnum.lastMonth:  // full previous calendar month
//       final thisMonthStart = DateTime(base.year, base.month, 1);
//       final lastMonthEndDay = thisMonthStart.subtract(const Duration(days: 1));
//       final lastMonthStart = DateTime(lastMonthEndDay.year, lastMonthEndDay.month, 1);
//       return (
//       start: dateOnly ? startOfDay(lastMonthStart) : lastMonthStart,
//       end: dateOnly ? endOfDay(lastMonthEndDay) : lastMonthEndDay
//       );
//   }
// }

enum DateRangeEnum {
  thisWeek,
  lastWeek,
  thisMonth,
  lastMonth;

  @override
  toString() {
    return label;
  }
}

extension DateRangeEnumExt on DateRangeEnum {
  String get label {
    switch (this) {
      case DateRangeEnum.thisWeek:
        return "This Week";
      case DateRangeEnum.lastWeek:
        return "Last Week";
      case DateRangeEnum.thisMonth:
        return "This Month";
      case DateRangeEnum.lastMonth:
        return "Last Month";
    }
  }
}

/// Calendar ranges (ISO week = Monday..Sunday)
/// - thisWeek  : current week start→end
/// - lastWeek  : previous week start→end
/// - thisMonth : current month start→end
/// - lastMonth : previous month start→end
({DateTime start, DateTime end}) getDateRange(
  DateRangeEnum type, {
  DateTime? now,
  bool dateOnly = true, // snap to 00:00:00.000 and 23:59:59.999999
}) {
  final base = now ?? DateTime.now();

  DateTime startOfDay(DateTime d) => DateTime(d.year, d.month, d.day);
  DateTime endOfDay(DateTime d) => DateTime(d.year, d.month, d.day + 1).subtract(const Duration(microseconds: 1));

  // ISO week: 1=Mon ... 7=Sun
  DateTime startOfIsoWeek(DateTime d) {
    final day = dateOnly ? startOfDay(d) : d;
    return DateTime(day.year, day.month, day.day - (day.weekday - 1));
  }

  ({DateTime start, DateTime end}) thisWeek() {
    final ws = startOfIsoWeek(base);
    final we = ws.add(const Duration(days: 6));
    return (start: dateOnly ? startOfDay(ws) : ws, end: dateOnly ? endOfDay(we) : we);
  }

  ({DateTime start, DateTime end}) lastWeek() {
    final thisWs = startOfIsoWeek(base);
    final ws = thisWs.subtract(const Duration(days: 7));
    final we = ws.add(const Duration(days: 6));
    return (start: dateOnly ? startOfDay(ws) : ws, end: dateOnly ? endOfDay(we) : we);
  }

  ({DateTime start, DateTime end}) thisMonth() {
    final ms = DateTime(base.year, base.month, 1);
    final me = DateTime(base.year, base.month + 1, 0); // last day of month
    return (start: dateOnly ? startOfDay(ms) : ms, end: dateOnly ? endOfDay(me) : me);
  }

  ({DateTime start, DateTime end}) lastMonth() {
    final thisMs = DateTime(base.year, base.month, 1);
    final me = thisMs.subtract(const Duration(days: 1)); // last day of prev month
    final ms = DateTime(me.year, me.month, 1);
    return (start: dateOnly ? startOfDay(ms) : ms, end: dateOnly ? endOfDay(me) : me);
  }

  switch (type) {
    case DateRangeEnum.thisWeek:
      return thisWeek();
    case DateRangeEnum.lastWeek:
      return lastWeek();
    case DateRangeEnum.thisMonth:
      return thisMonth();
    case DateRangeEnum.lastMonth:
      return lastMonth();
  }
}
