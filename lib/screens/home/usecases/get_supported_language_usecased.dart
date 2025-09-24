import 'package:flutter/material.dart';
import '../../../core/classes/supported_language_class.dart';
import '../../../core/interfaces/failures_int.dart';
import '../../../core/interfaces/request_int.dart';
import '../../../core/interfaces/response_int.dart';
import '../../../core/interfaces/result_int.dart';
import '../../../core/interfaces/usecase_int.dart';
import '../home_repository.dart';

class GetSupportedLanguageUseCase extends UseCase<GetSupportedLanguageResponse,GetSupportedLanguageRequest> {
  GetSupportedLanguageUseCase();

  @override
  Future<Result<GetSupportedLanguageResponse>> call({required GetSupportedLanguageRequest request}) {
  if(request.validate()!=null) return Future(() =>Result.error(request.validate()!));
    HomeRepository repository = HomeRepository();
    return repository.getSupportedLanguage(request);
  }

}

class GetSupportedLanguageRequest extends RequestInterface {
  final String logId;

  GetSupportedLanguageRequest({required this.logId});

  @override
  Map<String, dynamic> toJson() =>{
    "Body": {
      "Execution": "GetSupportedLanguage",
      "Token":token,
      "Request": {
      }
    }
  };

  Failure? validate(){
    return null;
  }
}




class GetSupportedLanguageResponse extends ResponseInterface {
  final List<SupportedLanguage> languages;

  GetSupportedLanguageResponse({required super.status, required super.message, required this.languages})
      : super(body:languages.map((e)=>e.toJson()).toList());

  factory GetSupportedLanguageResponse.fromResponse(ResponseInterface res) => GetSupportedLanguageResponse(
        status: res.status,
        message: res.message,
        languages: List<SupportedLanguage>.from(res.body.map((x) => SupportedLanguage.fromJson(x))),
      );
}
