import 'package:abds/initialize.dart';

import '../../../core/interface_implementations/network_manager_imp.dart';
import '../../../core/data_base/local_data_base.dart';
import '../../../core/interface_implementations/parser_imp.dart';
import '../../../core/interfaces/response_int.dart';
import '../interfaces/setting_menu_data_source_interface.dart';
import '../usecases/add_section_menu_usecase.dart';
import '../usecases/get_menu_usecase.dart';
import '../usecases/load_section_menu_usecase.dart';
import '../usecases/menu_get_template_usecase.dart';
import '../usecases/save_section_menu_usecase.dart';
import 'setting_menu_local_ds.dart';

class SettingMenuRemoteDataSource implements SettingMenuDataSourceInterface {
  final SettingMenuLocalDataSource localDataSource = SettingMenuLocalDataSource();
  final NetworkManagerImp networkManager = NetworkManagerImp();

  SettingMenuRemoteDataSource();

  @override
  Future<GetMenuResponse> getMenu({required GetMenuRequest request}) async {
    final String api = "$apiVersion/admin/menu";
    ResponseInterface res = await networkManager.get(api);
    GetMenuResponse response = await Parser().parse(GetMenuResponse.fromResponse, res, executionReq: request);
    return response;
  }

  @override
  Future<LoadSectionMenuResponse> loadSectionMenu({required LoadSectionMenuRequest request}) async {
    final String api = "$apiVersion${request.endPoint}";
    ResponseInterface res = await networkManager.get(api);
    LoadSectionMenuResponse response = await Parser().parse(LoadSectionMenuResponse.fromResponse, res, executionReq: request);
    return response;
  }

  @override
  Future<SaveSectionMenuResponse> saveSectionMenu({required SaveSectionMenuRequest request}) async {
    final String api = "$apiVersion${request.endPoint}/document/${request.id}";
    ResponseInterface res = await networkManager.put(request, api: api);
    SaveSectionMenuResponse response = await Parser().parse(SaveSectionMenuResponse.fromResponse, res, executionReq: request);
    return response;
  }

  @override
  Future<AddSectionMenuResponse> addSectionMenu({required AddSectionMenuRequest request}) async {
    final String api = "$apiVersion${request.endPoint}";
    ResponseInterface res = await networkManager.post(request, api: api);
    AddSectionMenuResponse response = await Parser().parse(AddSectionMenuResponse.fromResponse, res, executionReq: request);
    return response;
  }

  @override
  Future<MenuGetTemplateResponse> menuGetTemplate({required MenuGetTemplateRequest request}) async {
    final String api = "$apiVersion${request.endPoint}/template";
    ResponseInterface res = await networkManager.get(api);
    MenuGetTemplateResponse response = await Parser().parse(MenuGetTemplateResponse.fromResponse, res, executionReq: request);
    return response;
  }
}
