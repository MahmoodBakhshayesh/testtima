import 'package:flutter/material.dart';
import '../../../core/classes/receiver_data_class.dart';
import '../../../core/interfaces/failures_int.dart';
import '../../../core/interfaces/request_int.dart';
import '../../../core/interfaces/response_int.dart';
import '../../../core/interfaces/result_int.dart';
import '../../../core/interfaces/usecase_int.dart';
import '../receiver_repository.dart';

class GetReceiverQrUseCase extends UseCase<GetReceiverQrResponse,GetReceiverQrRequest> {
  GetReceiverQrUseCase();

  @override
  Future<Result<GetReceiverQrResponse>> call({required GetReceiverQrRequest request}) {
  if(request.validate()!=null) return Future(() =>Result.error(request.validate()!));
    ReceiverRepository repository = ReceiverRepository();
    return repository.getReceiverQr(request);
  }

}

class GetReceiverQrRequest extends RequestInterface {
  GetReceiverQrRequest();

  @override
  Map<String, dynamic> toJson() =>{
    "Body": {
      "Execution": "GetReceiverQr",
      "Token":token,
      "Request": {
      }
    }
  };
  
  Failure? validate(){
    return null;
  }
}


class GetReceiverQrResponse extends ResponseInterface {
  final ReceiverData data;
  GetReceiverQrResponse({required super.status, required super.message, required this.data})
      : super(
          body: data.toJson(),
        );

    factory GetReceiverQrResponse.fromResponse(ResponseInterface res) => GetReceiverQrResponse(
        status: res.status,
        message: res.message,
        data:ReceiverData.fromJson(res.body),
      );
  
}

