import 'package:abds/core/classes/current_status_class.dart';
import 'package:flutter/material.dart';
import '../../../core/classes/ref_history_log_class.dart';
import '../../../core/interfaces/failures_int.dart';
import '../../../core/interfaces/request_int.dart';
import '../../../core/interfaces/response_int.dart';
import '../../../core/interfaces/result_int.dart';
import '../../../core/interfaces/usecase_int.dart';
import '../home_repository.dart';

class GetRefCodeLogUseCase extends UseCase<GetRefCodeLogResponse,GetRefCodeLogRequest> {
  GetRefCodeLogUseCase();

  @override
  Future<Result<GetRefCodeLogResponse>> call({required GetRefCodeLogRequest request}) {
  if(request.validate()!=null) return Future(() =>Result.error(request.validate()!));
    HomeRepository repository = HomeRepository();
    return repository.getRefCodeLog(request);
  }

}

class GetRefCodeLogRequest extends RequestInterface {
  final String? code;
  final String? showCode;
  GetRefCodeLogRequest({required this.code,required this.showCode});

  @override
  Map<String, dynamic> toJson() =>{
    "Body": {
      "Execution": "GetRefCodeLog",
      "Token":token,
      "Request": {
      }
    }
  };

  Failure? validate(){
    return null;
  }
}


class GetRefCodeLogResponse extends ResponseInterface {
  final RefHistory history;
  final CurrentStatus currentStatus;
  GetRefCodeLogResponse({required super.status, required super.message, required this.history, required this.currentStatus})
      : super(
          body: history.toJson(),
          // currentStatus: currentStatus.toJson(),
        );

    factory GetRefCodeLogResponse.fromResponse(ResponseInterface res) => GetRefCodeLogResponse(
        status: res.status,
        message: res.message,
        history:RefHistory.fromJson(res.body),
        currentStatus:CurrentStatus.fromJson(res.body["result"]),
      );

}


