import 'package:flutter/material.dart';
import '../../../core/classes/current_status_class.dart';
import '../../../core/classes/ref_history_log_class.dart';
import '../../../core/interfaces/failures_int.dart';
import '../../../core/interfaces/request_int.dart';
import '../../../core/interfaces/response_int.dart';
import '../../../core/interfaces/result_int.dart';
import '../../../core/interfaces/usecase_int.dart';
import '../inbox_repository.dart';

class ReadMsgUseCase extends UseCase<ReadMsgResponse, ReadMsgRequest> {
  ReadMsgUseCase();

  @override
  Future<Result<ReadMsgResponse>> call({required ReadMsgRequest request}) {
    if (request.validate() != null) return Future(() => Result.error(request.validate()!));
    InboxRepository repository = InboxRepository();
    return repository.readMsg(request);
  }
}

class ReadMsgRequest extends RequestInterface {
  final String id;

  ReadMsgRequest({required this.id});

  @override
  Map<String, dynamic> toJson() => {
    "Body": {"Execution": "ReadMsg", "Token": token, "Request": {}},
  };

  Failure? validate() {
    return null;
  }
}

class ReadMsgResponse extends ResponseInterface {
  final RefHistory history;
  final CurrentStatus currentStatus;

  ReadMsgResponse({required super.status, required super.message, required this.history, required this.currentStatus})
    : super(
        body: history.toJson(),
        // currentStatus: currentStatus.toJson(),
      );

  factory ReadMsgResponse.fromResponse(ResponseInterface res) => ReadMsgResponse(status: res.status, message: res.message, history: RefHistory.fromJson(res.body), currentStatus: CurrentStatus.fromJson(res.body["result"]));
}
