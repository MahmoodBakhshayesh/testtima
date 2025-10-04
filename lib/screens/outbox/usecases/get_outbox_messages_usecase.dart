import 'package:abds/core/classes/outbox_message_class.dart';
import 'package:flutter/material.dart';
import '../../../core/interfaces/failures_int.dart';
import '../../../core/interfaces/request_int.dart';
import '../../../core/interfaces/response_int.dart';
import '../../../core/interfaces/result_int.dart';
import '../../../core/interfaces/usecase_int.dart';
import '../outbox_repository.dart';

class GetOutboxMessagesUseCase extends UseCase<GetOutboxMessagesResponse,GetOutboxMessagesRequest> {
  GetOutboxMessagesUseCase();

  @override
  Future<Result<GetOutboxMessagesResponse>> call({required GetOutboxMessagesRequest request}) {
  if(request.validate()!=null) return Future(() =>Result.error(request.validate()!));
    OutboxRepository repository = OutboxRepository();
    return repository.getOutboxMessages(request);
  }

}

class GetOutboxMessagesRequest extends RequestInterface {
  final int? nextMessageId;

  GetOutboxMessagesRequest({required this.nextMessageId});

  @override
  Map<String, dynamic> toJson() =>{
    "Body": {
      "Execution": "GetOutboxMessages",
      "Token":token,
      "Request": {
      }
    }
  };

  Failure? validate(){
    return null;
  }
}




class GetOutboxMessagesResponse extends ResponseInterface {
  final int? nextMessageId;
  final List<OutboxMessage> messages;

  GetOutboxMessagesResponse({required super.status, required super.message, required this.messages, required this.nextMessageId})
      : super(body:{
        "next":nextMessageId,
        "messages": messages.map((e)=>e.toJson()).toList()});

  factory GetOutboxMessagesResponse.fromResponse(ResponseInterface res) => GetOutboxMessagesResponse(
        status: res.status,
        message: res.message,
        nextMessageId:res.body["next"],
        messages: List<OutboxMessage>.from(res.body["messages"].map((x) => OutboxMessage.fromJson(x))),
      );
}
