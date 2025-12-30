import 'dart:developer';

import 'package:abds/initialize.dart';
import 'package:abds/screens/setting_menu/setting_menu_state.dart';
import 'package:abds/screens/setting_menu/usecases/get_menu_usecase.dart';
import 'package:abds/screens/setting_menu/usecases/load_section_menu_usecase.dart';
import 'package:abds/screens/setting_menu/usecases/menu_get_template_usecase.dart';
import 'package:abds/screens/setting_menu/usecases/save_section_menu_usecase.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:network_manager/network_manager.dart';
import '../../core/classes/menu_class.dart';
import '../../core/interfaces/controller_int.dart';
import '../../core/interfaces/failures_int.dart';
import '../../core/interfaces/result_int.dart';
import '../../core/utils_and_services/cross_helpers/build_formdata.dart';
import '../../core/utils_and_services/downloader/downloader_util.dart';
import '../../core/utils_and_services/handlers/failure_handler.dart';
import '../login/login_state.dart';
import '../menu_item_add_edit/menu_item_add_edit_state.dart';
import '../menu_section/menu_section_state.dart';
import 'usecases/add_section_menu_usecase.dart';

class SettingMenuController extends ControllerInterface {
  final _log = Logger('SettingMenuController');

  Future<SettingMenu?> getMenu() async {
    SettingMenu? menuSetting;
    GetMenuUseCase getMenuUseCase = GetMenuUseCase();
    GetMenuRequest getMenuRequest = GetMenuRequest();
    ref.read(settingMenuProvider.notifier).update((s) => null);
    ref.read(menuSectionProvider.notifier).update((s) => null);
    ref.read(editingMenuProvider.notifier).update((s) => null);
    ref.read(editingSchemaProvider.notifier).update((s) => null);
    ref.read(editingLabelProvider.notifier).update((s) => null);
    ref.read(sectionItemsProvider.notifier).update((s) => []);

    // final menuSectionProvider = StateProvider<MenuDescriptor?>((ref) => null);
    // final sectionItemsProvider = StateProvider<List<dynamic>>((ref) => []);
    //
    // final editingMenuProvider = StateProvider<Map<String,dynamic>?>((ref) => null);
    // final editingSchemaProvider = StateProvider<SchemaNode?>((ref) => null);
    // final editingLabelProvider = StateProvider<String?>((ref) => null);

    ref.read(menuLoadingProvider.notifier).update((s) => true);
    final result = await getMenuUseCase(request: getMenuRequest);
    ref.read(menuLoadingProvider.notifier).update((s) => false);

    switch (result) {
      case Err<GetMenuResponse>():
        FailureHandler.handle(result.error);

      case Ok<GetMenuResponse>():
        final r = result.value;
        ref.read(settingMenuProvider.notifier).update((s) => r.settingMenu);
    }

    return menuSetting;
  }

  // Future<void> saveMenu(MenuDescriptor section, data) async {
  //   // log(data.toString());
  //   log("${(section.getValue(data) as List).length}");
  //   log("${(data as List).length}");
  //   var current = ref.read(menuValuesProvider);
  //   current[section.endpoint] = data;
  //   ref.read(menuValuesProvider.notifier).update((s)=>current);
  // }

  // loadData(MenuDescriptor section) {
  //   log("load data ${section.title}");
  // }
  //

  Future<List<dynamic>?> loadData(MenuDescriptor section) async {
    List<dynamic>? menu;
    LoadSectionMenuUseCase loadDataUseCase = LoadSectionMenuUseCase();
    LoadSectionMenuRequest loadSectionMenuRequest = LoadSectionMenuRequest(endPoint: section.endpoint);
    ref.read(menuLoadingProvider.notifier).update((s) => true);
    final result = await loadDataUseCase(request: loadSectionMenuRequest);

    ref.read(menuLoadingProvider.notifier).update((s) => false);

    switch (result) {
      case Err<LoadSectionMenuResponse>():
        FailureHandler.handle(result.error);

      case Ok<LoadSectionMenuResponse>():
        final r = result.value;
        Map<String, dynamic> current = {};
        current[section.endpoint] = r.menus;
        menu = r.menus;
        ref.read(menuValuesProvider.notifier).update((s) => current);
        ref.read(menuSectionProvider.notifier).update((s) => section);
        ref.read(sectionItemsProvider.notifier).update((s) => r.menus);
        log("setting menuSectionProvider");
        log("setting menuValuesProvider ${current.length}");
    }

    return menu;
  }

  Future<bool> saveMenuSection(MenuDescriptor section, data, String id) async {
    SaveSectionMenuUseCase saveMenuSectionUseCase = SaveSectionMenuUseCase();
    SaveSectionMenuRequest saveSectionMenuRequest = SaveSectionMenuRequest(endPoint: section.endpoint, data: data, id: id);
    final result = await saveMenuSectionUseCase(request: saveSectionMenuRequest);

    switch (result) {
      case Err<SaveSectionMenuResponse>():
        FailureHandler.handle(result.error);
        return false;

      case Ok<SaveSectionMenuResponse>():
        final r = result.value;
        return true;
    }
  }

  Future<bool> addMenuSection(MenuDescriptor section, data) async {
    AddSectionMenuUseCase addMenuSectionUseCase = AddSectionMenuUseCase();
    AddSectionMenuRequest addSectionMenuRequest = AddSectionMenuRequest(endPoint: section.endpoint, data: data);
    final result = await addMenuSectionUseCase(request: addSectionMenuRequest);

    switch (result) {
      case Err<AddSectionMenuResponse>():
        FailureHandler.handle(result.error);
        return false;

      case Ok<AddSectionMenuResponse>():
        final r = result.value;
        return true;
    }
  }

  Future<void> getMenuTemplate(MenuDescriptor menu) async {
    String url = "${NetworkOption().baseUrl ?? ""}$apiVersion${menu.endpoint}/template";
    await DownloaderUtil.downloadSaveAndOpen(
      url,
      onProgress: (r, t) => log('$r / $t'),
      fileName: "${menu.fieldTitle}.xlsx",
      headers: {"Authorization": "Bearer ${ref.read(userProvider)?.token}"},
    );
  }

  Future<void> addMenuWithExcel(MenuDescriptor menu) async {
    final file = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ["xlsx"]);
    if (file == null) return;
    String api = "${NetworkOption().baseUrl ?? ""}$apiVersion${menu.endpoint}/excel";
    log(api);
    final dio = Dio();
    log("${"Bearer ${ref.read(userProvider)!.token}"}");
    final formData = await buildFormDataFromPaths(
      images: file.files.map((a)=>a.path!).toList(),
      voices: [],
      data: {},
      attachFieldName: "excel"
    );
    try {
      final response = await dio.post(
        api,
        data: formData,
        options: Options(headers: {"Content-Type": "multipart/form-data", "Authorization": "Bearer ${ref.read(userProvider)!.token}"}),
      );
      if (response.statusCode == 200) {

      } else {
        FailureHandler.handle(ServerFailure(code: response.statusCode ?? -1, msg: response.statusMessage ?? 'Unknown Error', traceMsg: response.statusMessage ?? 'Unknown Error'));
      }
    }catch(e){
      log("$e");
    }
  }

  Future<void> getMenuAsExcel(MenuDescriptor section) async {
    String url = "${NetworkOption().baseUrl ?? ""}$apiVersion${section.endpoint}/collection";
    log("$url");
    try {
      await DownloaderUtil.downloadSaveAndOpen(
        url,
        onProgress: (r, t) => log('$r / $t'),
        fileName: "${section.fieldTitle}.xlsx",
        headers: {"Authorization": "Bearer ${ref
            .read(userProvider)
            ?.token}"},
      );
    }catch(e){
      log("$e");
    }
  }

  Future<void> updateCollectionWithExcel(MenuDescriptor section) async {
    final file = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ["xlsx"]);
    if (file == null) return;
    String api = "${NetworkOption().baseUrl ?? ""}$apiVersion${section.endpoint}/excel";
    log(api);
    final dio = Dio();
    final formData = await buildFormDataFromPaths(
        images: file.files.map((a)=>a.path!).toList(),
        voices: [],
        data: {},
        attachFieldName: "excel"
    );
    try {
      final response = await dio.put(
        api,
        data: formData,
        options: Options(headers: {"Content-Type": "multipart/form-data", "Authorization": "Bearer ${ref.read(userProvider)!.token}"}),
      );
      if (response.statusCode == 200) {

      } else {
        FailureHandler.handle(ServerFailure(code: response.statusCode ?? -1, msg: response.statusMessage ?? 'Unknown Error', traceMsg: response.statusMessage ?? 'Unknown Error'));
      }
    }catch(e){
      log("$e");
    }
  }

  // Future<void> updateDocumentWithExcel(MenuDescriptor menu) async {
  //
  // }
}
