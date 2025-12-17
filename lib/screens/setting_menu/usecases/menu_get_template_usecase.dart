import 'dart:developer';

import 'package:flutter/material.dart';
import '../../../core/interfaces/failures_int.dart';
import '../../../core/interfaces/request_int.dart';
import '../../../core/interfaces/response_int.dart';
import '../../../core/interfaces/result_int.dart';
import '../../../core/interfaces/usecase_int.dart';
import '../setting_menu_repository.dart';

class MenuGetTemplateUseCase extends UseCase<MenuGetTemplateResponse,MenuGetTemplateRequest> {
  MenuGetTemplateUseCase();

  @override
  Future<Result<MenuGetTemplateResponse>> call({required MenuGetTemplateRequest request}) {
  if(request.validate()!=null) return Future(() =>Result.error(request.validate()!));
    SettingMenuRepository repository = SettingMenuRepository();
    return repository.menuGetTemplate(request);
  }

}

class MenuGetTemplateRequest extends RequestInterface {
  String endPoint;
  MenuGetTemplateRequest({required this.endPoint});


  @override
  Map<String, dynamic> toJson() =>{
    "Body": {
      "Execution": "MenuGetTemplate",
      "Token":token,
      "Request": {
      }
    }
  };

  Failure? validate(){
    return null;
  }
}


class MenuGetTemplateResponse extends ResponseInterface {
  final String msg;
  MenuGetTemplateResponse({required super.status, required super.message, required this.msg})
      : super(
          body: {
          },
        );

    factory MenuGetTemplateResponse.fromResponse(ResponseInterface res) {
      log("${res.body}");
      return MenuGetTemplateResponse(
        status: res.status,
        message: res.message,
        msg: res.message
      );
    }

}


