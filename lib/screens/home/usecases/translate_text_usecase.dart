import 'package:flutter/material.dart';
import '../../../core/interfaces/failures_int.dart';
import '../../../core/interfaces/request_int.dart';
import '../../../core/interfaces/response_int.dart';
import '../../../core/interfaces/result_int.dart';
import '../../../core/interfaces/usecase_int.dart';
import '../home_repository.dart';

class TranslateTextUseCase extends UseCase<TranslateTextResponse,TranslateTextRequest> {
  TranslateTextUseCase();

  @override
  Future<Result<TranslateTextResponse>> call({required TranslateTextRequest request}) {
  if(request.validate()!=null) return Future(() =>Result.error(request.validate()!));
    HomeRepository repository = HomeRepository();
    return repository.translateText(request);
  }

}

class TranslateTextRequest extends RequestInterface {
  final String lang;
  final List<String> texts;

  TranslateTextRequest({required this.lang, required this.texts});

  @override
  Map<String, dynamic> toJson() =>{
    "text": texts
  };

  Failure? validate(){
    return null;
  }
}


class TranslateTextResponse extends ResponseInterface {
  final String translate;
  TranslateTextResponse({required super.status, required super.message, required this.translate})
      : super(
          body: {

          },
        );

    factory TranslateTextResponse.fromResponse(ResponseInterface res) => TranslateTextResponse(
        status: res.status,
        message: res.message,
        translate:(res.body as List).join()
      );

}

