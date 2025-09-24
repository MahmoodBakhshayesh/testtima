import 'package:flutter/material.dart';
import '../../../core/interfaces/failures_int.dart';
import '../../../core/interfaces/request_int.dart';
import '../../../core/interfaces/response_int.dart';
import '../../../core/interfaces/result_int.dart';
import '../../../core/interfaces/usecase_int.dart';
import '../home_repository.dart';

class LockUnlockResponseUseCase extends UseCase<LockUnlockResponseResponse,LockUnlockResponseRequest> {
  LockUnlockResponseUseCase();

  @override
  Future<Result<LockUnlockResponseResponse>> call({required LockUnlockResponseRequest request}) {
  if(request.validate()!=null) return Future(() =>Result.error(request.validate()!));
    HomeRepository repository = HomeRepository();
    return repository.lockUnlockResponse(request);
  }

}

class LockUnlockResponseRequest extends RequestInterface {
  final String logId;
  final bool lock;

  LockUnlockResponseRequest({required this.logId, required this.lock});


  @override
  Map<String, dynamic> toJson() =>{
    "lock":lock
  };

  Failure? validate(){
    return null;
  }
}


class LockUnlockResponseResponse extends ResponseInterface {
  final String msg;
  LockUnlockResponseResponse({required super.status, required super.message, required this.msg})
      : super(
          body: {
          },
        );

    factory LockUnlockResponseResponse.fromResponse(ResponseInterface res) => LockUnlockResponseResponse(
        status: res.status,
        message: res.message,
        msg:res.message,
      );

}


