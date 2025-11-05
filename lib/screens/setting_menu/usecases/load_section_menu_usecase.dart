import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import '../../../core/interfaces/failures_int.dart';
import '../../../core/interfaces/request_int.dart';
import '../../../core/interfaces/response_int.dart';
import '../../../core/interfaces/result_int.dart';
import '../../../core/interfaces/usecase_int.dart';
import '../setting_menu_repository.dart';

class LoadSectionMenuUseCase extends UseCase<LoadSectionMenuResponse,LoadSectionMenuRequest> {
  LoadSectionMenuUseCase();

  @override
  Future<Result<LoadSectionMenuResponse>> call({required LoadSectionMenuRequest request}) {
  if(request.validate()!=null) return Future(() =>Result.error(request.validate()!));
    SettingMenuRepository repository = SettingMenuRepository();
    return repository.loadSectionMenu(request);
  }

}

class LoadSectionMenuRequest extends RequestInterface {
  String endPoint;
  LoadSectionMenuRequest({required this.endPoint});

  @override
  Map<String, dynamic> toJson() =>{
    "Body": {
      "Execution": "LoadSectionMenu",
      "Token":token,
      "Request": {
      }
    }
  };

  Failure? validate(){
    return null;
  }
}



class LoadSectionMenuResponse extends ResponseInterface {
  final List<dynamic> menus;

  LoadSectionMenuResponse({required super.status, required super.message, required this.menus})
      : super(body: menus);

  factory LoadSectionMenuResponse.fromResponse(ResponseInterface res) {
    log(jsonEncode(res.body));
    return LoadSectionMenuResponse(
        status: res.status,
        message: res.message,
        menus:res.body is List? res.body: res.body['permissions']??res.body["attributes"]??res.body,
      );
  }
}
