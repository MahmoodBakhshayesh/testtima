import 'dart:convert';

import 'package:flutter/material.dart';
import '../../../core/classes/menu_class.dart';
import '../../../core/interfaces/failures_int.dart';
import '../../../core/interfaces/request_int.dart';
import '../../../core/interfaces/response_int.dart';
import '../../../core/interfaces/result_int.dart';
import '../../../core/interfaces/usecase_int.dart';
import '../setting_menu_repository.dart';

class GetMenuUseCase extends UseCase<GetMenuResponse, GetMenuRequest> {
  GetMenuUseCase();

  @override
  Future<Result<GetMenuResponse>> call({required GetMenuRequest request}) {
    if (request.validate() != null) return Future(() => Result.error(request.validate()!));
    SettingMenuRepository repository = SettingMenuRepository();
    return repository.getMenu(request);
  }
}

class GetMenuRequest extends RequestInterface {
  GetMenuRequest();

  @override
  Map<String, dynamic> toJson() => {
    "Body": {"Execution": "GetMenu", "Token": token, "Request": {}},
  };

  Failure? validate() {
    return null;
  }
}

class GetMenuResponse extends ResponseInterface {
  final SettingMenu settingMenu;

  GetMenuResponse({required super.status, required super.message, required this.settingMenu}) : super(body: settingMenu.toJson());

  factory GetMenuResponse.fromResponse(ResponseInterface res) => GetMenuResponse(status: res.status, message: res.message, settingMenu: SettingMenu.fromDynamic(res.body));
}
