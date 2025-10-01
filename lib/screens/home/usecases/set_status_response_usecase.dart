import 'package:abds/core/classes/current_status_class.dart';
import 'package:flutter/material.dart';
import '../../../core/interfaces/failures_int.dart';
import '../../../core/interfaces/request_int.dart';
import '../../../core/interfaces/response_int.dart';
import '../../../core/interfaces/result_int.dart';
import '../../../core/interfaces/usecase_int.dart';
import '../home_repository.dart';

class SetStatusResponseUseCase extends UseCase<SetStatusResponseResponse,SetStatusResponseRequest> {
  SetStatusResponseUseCase();

  @override
  Future<Result<SetStatusResponseResponse>> call({required SetStatusResponseRequest request}) {
  if(request.validate()!=null) return Future(() =>Result.error(request.validate()!));
    HomeRepository repository = HomeRepository();
    return repository.lockUnlockResponse(request);
  }

}

class SetStatusResponseRequest extends RequestInterface {
  final String logId;
  final int status;

  SetStatusResponseRequest({required this.logId, required this.status});


  @override
  Map<String, dynamic> toJson() =>{
    "status":status
  };

  Failure? validate(){
    return null;
  }
}


class SetStatusResponseResponse extends ResponseInterface {
  final String msg;
  final CurrentStatus currentStatus;
  SetStatusResponseResponse({required super.status, required super.message, required this.msg,required this.currentStatus})
      : super(
          body: {
            "result":currentStatus.toJson()
          },
        );

    factory SetStatusResponseResponse.fromResponse(ResponseInterface res) => SetStatusResponseResponse(
        status: res.status,
        message: res.message,
        msg:res.message,
        currentStatus: CurrentStatus.fromJson(res.body["result"])
      );

}


