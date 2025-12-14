import 'package:flutter/material.dart';
import '../../../core/interfaces/failures_int.dart';
import '../../../core/interfaces/request_int.dart';
import '../../../core/interfaces/response_int.dart';
import '../../../core/interfaces/result_int.dart';
import '../../../core/interfaces/usecase_int.dart';
import '../sender_repository.dart';

class ConnectToReceiverUseCase extends UseCase<ConnectToReceiverResponse,ConnectToReceiverRequest> {
  ConnectToReceiverUseCase();

  @override
  Future<Result<ConnectToReceiverResponse>> call({required ConnectToReceiverRequest request}) {
  if(request.validate()!=null) return Future(() =>Result.error(request.validate()!));
    SenderRepository repository = SenderRepository();
    return repository.connectToReceiver(request);
  }

}

class ConnectToReceiverRequest extends RequestInterface {
  final String receiverId;
  ConnectToReceiverRequest({required this.receiverId});

  @override
  Map<String, dynamic> toJson() => {
    "receiverId":receiverId
  };

  Failure? validate(){
    return null;
  }
}


class ConnectToReceiverResponse extends ResponseInterface {
  final String msg;
  ConnectToReceiverResponse({required super.status, required super.message, required this.msg})
      : super(
          body: {

          },
        );

    factory ConnectToReceiverResponse.fromResponse(ResponseInterface res) => ConnectToReceiverResponse(
        status: res.status,
        message: res.message,
        msg:res.message
      );

}

