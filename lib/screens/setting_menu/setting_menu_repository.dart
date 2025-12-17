import '../../core/interface_implementations/network_info_imp.dart';
import '../../core/interfaces/exception_int.dart';
import '../../core/interfaces/failures_int.dart';
import '../../core/interfaces/result_int.dart';
import '../../initialize.dart';
import 'interfaces/setting_menu_repository_interface.dart';
import 'data_sources/setting_menu_local_ds.dart';
import 'data_sources/setting_menu_remote_ds.dart';
import 'usecases/add_section_menu_usecase.dart';
import 'usecases/get_menu_usecase.dart';
import 'usecases/load_section_menu_usecase.dart';
import 'usecases/menu_get_template_usecase.dart';
import 'usecases/save_section_menu_usecase.dart';

class SettingMenuRepository implements SettingMenuRepositoryInterface {
  final SettingMenuRemoteDataSource settingMenuRemoteDataSource = SettingMenuRemoteDataSource();
  final SettingMenuLocalDataSource settingMenuLocalDataSource = SettingMenuLocalDataSource();
  final NetworkInfoImp networkInfo = getIt<NetworkInfoImp>();

  SettingMenuRepository();

  @override
  Future<Result<GetMenuResponse>> getMenu(GetMenuRequest request) async {
    try {
      GetMenuResponse getMenuResponse;
      if (await networkInfo.isConnected) {
        getMenuResponse = await settingMenuRemoteDataSource.getMenu(request: request);
      } else {
        getMenuResponse = await settingMenuLocalDataSource.getMenu(request: request);
      }
      return Result.ok(getMenuResponse);
    } on AppException catch (e) {
      return Result.error(ServerFailure.fromAppException(e));
    }
  }

  @override
  Future<Result<LoadSectionMenuResponse>> loadSectionMenu(LoadSectionMenuRequest request) async {
    try {
      LoadSectionMenuResponse loadSectionMenuResponse;
      if (await networkInfo.isConnected) {
        loadSectionMenuResponse = await settingMenuRemoteDataSource.loadSectionMenu(request: request);
      } else {
        loadSectionMenuResponse = await settingMenuLocalDataSource.loadSectionMenu(request: request);
      }
      return Result.ok(loadSectionMenuResponse);
    } on AppException catch (e) {
      return Result.error(ServerFailure.fromAppException(e));
    }
  }

  @override
  Future<Result<SaveSectionMenuResponse>> saveSectionMenu(SaveSectionMenuRequest request) async {
    try {
      SaveSectionMenuResponse saveSectionMenuResponse;
      if (await networkInfo.isConnected) {
        saveSectionMenuResponse = await settingMenuRemoteDataSource.saveSectionMenu(request: request);
      } else {
        saveSectionMenuResponse = await settingMenuLocalDataSource.saveSectionMenu(request: request);
      }
      return Result.ok(saveSectionMenuResponse);
    } on AppException catch (e) {
      return Result.error(ServerFailure.fromAppException(e));
    }
  }

  @override
  Future<Result<AddSectionMenuResponse>> addSectionMenu(AddSectionMenuRequest request) async {
    try {
      AddSectionMenuResponse addSectionMenuResponse;
      if (await networkInfo.isConnected) {
        addSectionMenuResponse = await settingMenuRemoteDataSource.addSectionMenu(request: request);
      } else {
        addSectionMenuResponse = await settingMenuLocalDataSource.addSectionMenu(request: request);
      }
      return Result.ok(addSectionMenuResponse);
    } on AppException catch (e) {
      return Result.error(ServerFailure.fromAppException(e));
    }
  }

    @override
      Future<Result<MenuGetTemplateResponse>> menuGetTemplate(MenuGetTemplateRequest request) async {
        try {
          MenuGetTemplateResponse menuGetTemplateResponse;
          if (await networkInfo.isConnected) {
            menuGetTemplateResponse = await settingMenuRemoteDataSource.menuGetTemplate(request: request);
          } else {
            menuGetTemplateResponse = await settingMenuLocalDataSource.menuGetTemplate(request: request);
          }
          return Result.ok(menuGetTemplateResponse);
        } on AppException catch (e) {
          return Result.error(ServerFailure.fromAppException(e));
        }
      }
}
