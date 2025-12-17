import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import '../../../core/interfaces/failures_int.dart';
import '../../../core/interfaces/request_int.dart';
import '../../../core/interfaces/response_int.dart';
import '../../../core/interfaces/result_int.dart';
import '../../../core/interfaces/usecase_int.dart';
import '../setting_menu_repository.dart';

class AddSectionMenuUseCase extends UseCase<AddSectionMenuResponse,AddSectionMenuRequest> {
  AddSectionMenuUseCase();

  @override
  Future<Result<AddSectionMenuResponse>> call({required AddSectionMenuRequest request}) {
  if(request.validate()!=null) return Future(() =>Result.error(request.validate()!));
    SettingMenuRepository repository = SettingMenuRepository();
    return repository.addSectionMenu(request);
  }

}

class  AddSectionMenuRequest extends RequestInterface {
  String endPoint;
  dynamic data;
  AddSectionMenuRequest({required this.endPoint,required this.data});

  @override
  Map<String, dynamic> toJson() =>data is Map? data :data[0];

  Failure? validate(){
    return null;
  }
}



class AddSectionMenuResponse extends ResponseInterface {
  // final List<dynamic> menus;

  AddSectionMenuResponse({required super.status, required super.message})
      : super(body: {});

  factory AddSectionMenuResponse.fromResponse(ResponseInterface res) {
    log(jsonEncode(res.body));
    return AddSectionMenuResponse(
        status: res.status,
        message: res.message,
        // menus:(res.body is List)? res.body: res.body['permissions']??res.body["attributes"]??res.body,
      );
  }
}
