import 'package:flutter/material.dart';
import '../../../core/interfaces/failures_int.dart';
import '../../../core/interfaces/request_int.dart';
import '../../../core/interfaces/response_int.dart';
import '../../../core/interfaces/result_int.dart';
import '../../../core/interfaces/usecase_int.dart';
import '../sender_repository.dart';

class DisconnectFromReceiverUseCase extends UseCase<DisconnectFromReceiverResponse,DisconnectFromReceiverRequest> {
  DisconnectFromReceiverUseCase();

  @override
  Future<Result<DisconnectFromReceiverResponse>> call({required DisconnectFromReceiverRequest request}) {
  if(request.validate()!=null) return Future(() =>Result.error(request.validate()!));
    SenderRepository repository = SenderRepository();
    return repository.disconnectFromReceiver(request);
  }

}

class DisconnectFromReceiverRequest extends RequestInterface {
  DisconnectFromReceiverRequest();

  @override
  Map<String, dynamic> toJson() =>{
    "Body": {
      "Execution": "DisconnectFromReceiver",
      "Token":token,
      "Request": {
      }
    }
  };

  Failure? validate(){
    return null;
  }
}


class DisconnectFromReceiverResponse extends ResponseInterface {
  final String msg;
  DisconnectFromReceiverResponse({required super.status, required super.message, required this.msg})
      : super(
          body: {

          },
        );

    factory DisconnectFromReceiverResponse.fromResponse(ResponseInterface res) => DisconnectFromReceiverResponse(
        status: res.status,
        message: res.message,
        msg:res.message
      );

}


