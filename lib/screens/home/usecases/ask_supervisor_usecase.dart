import 'package:flutter/material.dart';
import '../../../core/interfaces/failures_int.dart';
import '../../../core/interfaces/request_int.dart';
import '../../../core/interfaces/response_int.dart';
import '../../../core/interfaces/result_int.dart';
import '../../../core/interfaces/usecase_int.dart';
import '../home_repository.dart';

class AskSupervisorUseCase extends UseCase<AskSupervisorResponse,AskSupervisorRequest> {
  AskSupervisorUseCase();

  @override
  Future<Result<AskSupervisorResponse>> call({required AskSupervisorRequest request}) {
  if(request.validate()!=null) return Future(() =>Result.error(request.validate()!));
    HomeRepository repository = HomeRepository();
    return repository.askSupervisor(request);
  }

}

class AskSupervisorRequest extends RequestInterface {
  final String logId;
  final String supervisorId;
  final String message;

  AskSupervisorRequest({required this.logId,required this.supervisorId, required this.message});

  @override
  Map<String, dynamic> toJson() =>{
    "supervisorId":supervisorId,
    "message": message
  };

  Failure? validate(){
    return null;
  }
}


class AskSupervisorResponse extends ResponseInterface {
  final String msg;
  AskSupervisorResponse({required super.status, required super.message, required this.msg})
      : super(
          body: {
          },
        );

    factory AskSupervisorResponse.fromResponse(ResponseInterface res) => AskSupervisorResponse(
        status: res.status,
        message: res.message,
        msg:res.message
      );

}


