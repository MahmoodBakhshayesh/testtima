import 'package:flutter/material.dart';
import '../../../core/interfaces/failures_int.dart';
import '../../../core/interfaces/request_int.dart';
import '../../../core/interfaces/response_int.dart';
import '../../../core/interfaces/result_int.dart';
import '../../../core/interfaces/usecase_int.dart';
import '../receiver_repository.dart';

class SendToReceiverUseCase extends UseCase<SendToReceiverResponse, SendToReceiverRequest> {
  SendToReceiverUseCase();

  @override
  Future<Result<SendToReceiverResponse>> call({required SendToReceiverRequest request}) {
    if (request.validate() != null) return Future(() => Result.error(request.validate()!));
    ReceiverRepository repository = ReceiverRepository();
    return repository.sendToReceiver(request);
  }
}

class SendToReceiverRequest extends RequestInterface {
  final String receiverId;
  SendToReceiverRequest({required this.receiverId});

  @override
  Map<String, dynamic> toJson() => {
    "receiverId":receiverId
  };

  Failure? validate() {
    return null;
  }
}

class SendToReceiverResponse extends ResponseInterface {
  final String msg;

  SendToReceiverResponse({required super.status, required super.message, required this.msg}) : super(body: {"String": msg});

  factory SendToReceiverResponse.fromResponse(ResponseInterface res) => SendToReceiverResponse(status: res.status, message: res.message, msg: res.message);
}
