import 'package:abds/core/classes/current_status_class.dart';
import 'package:abds/core/classes/timatic_response_new_class.dart';

class HeaderSummaryObject {
  final CurrentStatus currentStatus;
  final String? airline;
  final String? flnb;
  final DateTime? dateTime;
  final String? departure;
  final String? arrival;
  final String? docNumber;
  final String? showCode;
  final String? employeeId;
  final String? nationality;
  final String? resident;
  final String? issuing;
  final List<Segment> segments;

  HeaderSummaryObject({required this.currentStatus, required this.airline, required this.flnb, required this.dateTime, required this.departure, required this.arrival, required this.docNumber, required this.showCode, required this.employeeId, required this.nationality, required this.resident, required this.issuing, required this.segments});

}