import 'package:flutter/material.dart';
import '../../../core/classes/flight_history_data_class.dart';
import '../../../core/interfaces/failures_int.dart';
import '../../../core/interfaces/request_int.dart';
import '../../../core/interfaces/response_int.dart';
import '../../../core/interfaces/result_int.dart';
import '../../../core/interfaces/usecase_int.dart';
import '../home_repository.dart';

class FlightNumberHistoryUseCase extends UseCase<FlightNumberHistoryResponse, FlightNumberHistoryRequest> {
  FlightNumberHistoryUseCase();

  @override
  Future<Result<FlightNumberHistoryResponse>> call({required FlightNumberHistoryRequest request}) {
    if (request.validate() != null) return Future(() => Result.error(request.validate()!));
    HomeRepository repository = HomeRepository();
    return repository.flightNumberHistory(request);
  }
}

class FlightNumberHistoryRequest extends RequestInterface {
  final String flnb;

  FlightNumberHistoryRequest({required this.flnb});

  @override
  Map<String, dynamic> toJson() => {
    "Body": {"Execution": "FlightNumberHistory", "Token": token, "Request": {}},
  };

  Failure? validate() {
    return null;
  }
}

class FlightNumberHistoryResponse extends ResponseInterface {
  final List<FlightHistoryData> historyData;

  FlightNumberHistoryResponse({required super.status, required super.message, required this.historyData}) : super(body: historyData.map((e) => e.toJson()).toList());

  factory FlightNumberHistoryResponse.fromResponse(ResponseInterface res) =>
      FlightNumberHistoryResponse(status: res.status, message: res.message, historyData: List<FlightHistoryData>.from(res.body.map((x) => FlightHistoryData.fromJson(x))));
}
