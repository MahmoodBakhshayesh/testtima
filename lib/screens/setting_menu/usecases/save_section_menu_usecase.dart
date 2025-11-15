import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import '../../../core/interfaces/failures_int.dart';
import '../../../core/interfaces/request_int.dart';
import '../../../core/interfaces/response_int.dart';
import '../../../core/interfaces/result_int.dart';
import '../../../core/interfaces/usecase_int.dart';
import '../setting_menu_repository.dart';

class SaveSectionMenuUseCase extends UseCase<SaveSectionMenuResponse,SaveSectionMenuRequest> {
  SaveSectionMenuUseCase();

  @override
  Future<Result<SaveSectionMenuResponse>> call({required SaveSectionMenuRequest request}) {
  if(request.validate()!=null) return Future(() =>Result.error(request.validate()!));
    SettingMenuRepository repository = SettingMenuRepository();
    return repository.saveSectionMenu(request);
  }

}

class SaveSectionMenuRequest extends RequestInterface {
  String endPoint;
  String id;
  dynamic data;
  SaveSectionMenuRequest({required this.endPoint,required this.data,required this.id});

  @override
  Map<String, dynamic> toJson() =>data;

  Failure? validate(){
    return null;
  }
}



class SaveSectionMenuResponse extends ResponseInterface {
  final List<dynamic> menus;

  SaveSectionMenuResponse({required super.status, required super.message, required this.menus})
      : super(body: menus);

  factory SaveSectionMenuResponse.fromResponse(ResponseInterface res) {
    log(jsonEncode(res.body));
    if(res.body is Map && (res.body as Map).containsKey("_id")){
      return SaveSectionMenuResponse(
        status: res.status,
        message: res.message,
        menus:[res.body],
      );
    }
    return SaveSectionMenuResponse(
        status: res.status,
        message: res.message,
        menus:res.body is List? res.body: res.body['permissions']??res.body["attributes"]??res.body,
      );
  }
}
