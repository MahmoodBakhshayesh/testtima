import 'package:abds/core/classes/inbox_message_class.dart';
import 'package:flutter/material.dart';
import '../../../core/interfaces/failures_int.dart';
import '../../../core/interfaces/request_int.dart';
import '../../../core/interfaces/response_int.dart';
import '../../../core/interfaces/result_int.dart';
import '../../../core/interfaces/usecase_int.dart';
import '../inbox_repository.dart';

class GetMessagesUseCase extends UseCase<GetMessagesResponse, GetMessagesRequest> {
  GetMessagesUseCase();

  @override
  Future<Result<GetMessagesResponse>> call({required GetMessagesRequest request}) {
    if (request.validate() != null) return Future(() => Result.error(request.validate()!));
    InboxRepository repository = InboxRepository();
    return repository.getMessages(request);
  }
}

class GetMessagesRequest extends RequestInterface {
  final int? nextMessageId;
  GetMessagesRequest({required this.nextMessageId});

  @override
  Map<String, dynamic> toJson() => {
    "Body": {"Execution": "GetMessages", "Token": token, "Request": {}},
  };

  Failure? validate() {
    return null;
  }
}

class GetMessagesResponse extends ResponseInterface {
  final List<InboxMessage> messages;
  final int? nextMessageId;


  GetMessagesResponse({required super.status, required super.message, required this.messages, required this.nextMessageId}) : super(body: {"messages": messages.map((e) => e.toJson()).toList(), "next": nextMessageId});

  factory GetMessagesResponse.fromResponse(ResponseInterface res) =>
      GetMessagesResponse(status: res.status, message: res.message, nextMessageId: res.body["next"], messages: List<InboxMessage>.from(res.body["messages"].map((x) => InboxMessage.fromJson(x))));
}
