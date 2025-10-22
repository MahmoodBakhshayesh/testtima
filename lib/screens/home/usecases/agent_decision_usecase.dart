import 'package:flutter/material.dart';
import '../../../core/classes/current_status_class.dart';
import '../../../core/interfaces/failures_int.dart';
import '../../../core/interfaces/request_int.dart';
import '../../../core/interfaces/response_int.dart';
import '../../../core/interfaces/result_int.dart';
import '../../../core/interfaces/usecase_int.dart';
import '../home_repository.dart';

class AgentDecisionUseCase extends UseCase<AgentDecisionResponse, AgentDecisionRequest> {
  AgentDecisionUseCase();

  @override
  Future<Result<AgentDecisionResponse>> call({required AgentDecisionRequest request}) {
    if (request.validate() != null) return Future(() => Result.error(request.validate()!));
    HomeRepository repository = HomeRepository();
    return repository.agentDecision(request);
  }
}

class AgentDecisionRequest extends RequestInterface {
  AgentDecisionRequest();

  @override
  Map<String, dynamic> toJson() => {
    "Body": {"Execution": "AgentDecision", "Token": token, "Request": {}},
  };

  Failure? validate() {
    return null;
  }
}

class AgentDecisionResponse extends ResponseInterface {
  final CurrentStatus currentStatus;

  AgentDecisionResponse({required super.status, required super.message, required this.currentStatus}) : super(body: {"CurrentStatus": currentStatus.toJson()});

  factory AgentDecisionResponse.fromResponse(ResponseInterface res) => AgentDecisionResponse(status: res.status, message: res.message, currentStatus: CurrentStatus.fromJson(res.body["CurrentStatus"]));
}
