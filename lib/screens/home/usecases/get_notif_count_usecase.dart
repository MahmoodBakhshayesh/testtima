import 'package:flutter/material.dart';
import '../../../core/interfaces/failures_int.dart';
import '../../../core/interfaces/request_int.dart';
import '../../../core/interfaces/response_int.dart';
import '../../../core/interfaces/result_int.dart';
import '../../../core/interfaces/usecase_int.dart';
import '../home_repository.dart';

class GetNotifCountUseCase extends UseCase<GetNotifCountResponse,GetNotifCountRequest> {
  GetNotifCountUseCase();

  @override
  Future<Result<GetNotifCountResponse>> call({required GetNotifCountRequest request}) {
  if(request.validate()!=null) return Future(() =>Result.error(request.validate()!));
    HomeRepository repository = HomeRepository();
    return repository.getNotifCount(request);
  }

}

class GetNotifCountRequest extends RequestInterface {
  GetNotifCountRequest();

  @override
  Map<String, dynamic> toJson() =>{
    "Body": {
      "Execution": "GetNotifCount",
      "Token":token,
      "Request": {
      }
    }
  };

  Failure? validate(){
    return null;
  }
}


class GetNotifCountResponse extends ResponseInterface {
  final int notifCount;
  GetNotifCountResponse({required super.status, required super.message, required this.notifCount})
      : super(
          body: {
            "newMessage" : notifCount,
          },
        );

    factory GetNotifCountResponse.fromResponse(ResponseInterface res) => GetNotifCountResponse(
        status: res.status,
        message: res.message,
      notifCount :res.body["newMessage"],
      );

}


