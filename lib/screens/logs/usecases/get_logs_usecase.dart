import 'package:abds/core/classes/timatic_log.dart';
import 'package:flutter/material.dart';
import '../../../core/interfaces/failures_int.dart';
import '../../../core/interfaces/request_int.dart';
import '../../../core/interfaces/response_int.dart';
import '../../../core/interfaces/result_int.dart';
import '../../../core/interfaces/usecase_int.dart';
import '../logs_repository.dart';

class GetLogsUseCase extends UseCase<GetLogsResponse,GetLogsRequest> {
  GetLogsUseCase();

  @override
  Future<Result<GetLogsResponse>> call({required GetLogsRequest request}) {
  if(request.validate()!=null) return Future(() =>Result.error(request.validate()!));
    LogsRepository repository = LogsRepository();
    return repository.getLogs(request);
  }

}

class GetLogsRequest extends RequestInterface {
  GetLogsRequest();

  @override
  Map<String, dynamic> toJson() =>{
    "Body": {
      "Execution": "GetLogs",
      "Token":token,
      "Request": {
      }
    }
  };

  Failure? validate(){
    return null;
  }
}



class GetLogsResponse extends ResponseInterface {
  final List<TimaticLog> logs;

  GetLogsResponse({required super.status, required super.message, required this.logs})
      : super(body:{"items": logs.map((e)=>e.toJson()).toList()});

  factory GetLogsResponse.fromResponse(ResponseInterface res) => GetLogsResponse(
        status: res.status,
        message: res.message,
        logs: List<TimaticLog>.from(res.body["items"].map((x) => TimaticLog.fromJson(x))),
      );
}
