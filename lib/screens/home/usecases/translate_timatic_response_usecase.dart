import 'package:abds/core/utils_and_services/timatic/artemis_timatic.dart';
import 'package:flutter/material.dart';
import '../../../core/interfaces/failures_int.dart';
import '../../../core/interfaces/request_int.dart';
import '../../../core/interfaces/response_int.dart';
import '../../../core/interfaces/result_int.dart';
import '../../../core/interfaces/usecase_int.dart';
import '../home_repository.dart';

class TranslateTimaticResponseUseCase extends UseCase<TranslateTimaticResponseResponse,TranslateTimaticResponseRequest> {
  TranslateTimaticResponseUseCase();

  @override
  Future<Result<TranslateTimaticResponseResponse>> call({required TranslateTimaticResponseRequest request}) {
  if(request.validate()!=null) return Future(() =>Result.error(request.validate()!));
    HomeRepository repository = HomeRepository();
    return repository.translateTimaticResponse(request);
  }

}

class TranslateTimaticResponseRequest extends RequestInterface {
  final String logId;
  final String language;

  TranslateTimaticResponseRequest({required this.logId, required this.language});

  @override
  Map<String, dynamic> toJson() =>{
    "Body": {
      "Execution": "TranslateTimaticResponse",
      "Token":token,
      "Request": {
      }
    }
  };

  Failure? validate(){
    return null;
  }
}


class TranslateTimaticResponseResponse extends ResponseInterface {
  final DocumentResponse translated;
  TranslateTimaticResponseResponse({required super.status, required super.message, required this.translated})
      : super(
          body: translated.toJson(),
        );

    factory TranslateTimaticResponseResponse.fromResponse(ResponseInterface res) => TranslateTimaticResponseResponse(
        status: res.status,
        message: res.message,
        translated:DocumentResponse.fromJson(res.body),
      );

}

