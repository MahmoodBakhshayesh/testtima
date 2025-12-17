import 'dart:developer';

import 'package:abds/core/classes/menu_class.dart';
import 'package:abds/core/interfaces/success_int.dart';
import 'package:abds/core/navigation/routes.dart';
import 'package:abds/core/utils_and_services/handlers/success_handler.dart';
import 'package:abds/screens/menu_item_add_edit/menu_item_add_edit_state.dart';
import 'package:abds/screens/setting_menu/setting_menu_controller.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:logging/logging.dart';
import 'package:network_manager/network_manager.dart';
import '../../core/interfaces/controller_int.dart';
import '../../core/interfaces/failures_int.dart';
import '../../core/utils_and_services/cross_helpers/build_formdata.dart';
import '../../core/utils_and_services/downloader/downloader_io.dart';
import '../../core/utils_and_services/handlers/failure_handler.dart';
import '../../initialize.dart';
import '../login/login_state.dart';

class MenuSectionController extends ControllerInterface {
  final _log = Logger('MenuSectionController');

  void editItem(SchemaNode schema, dynamic data, String label, bool isDesktop) {
    if (data is List && data.isNotEmpty) {
      data = data.first;
    }
    ref.read(editingMenuProvider.notifier).update((s) => null);
    ref.read(editingSchemaProvider.notifier).update((s) => null);
    ref.read(editingLabelProvider.notifier).update((s) => null);
    Future.delayed(Duration(milliseconds: 10), () {
      ref.read(editingMenuProvider.notifier).update((s) => data);
      ref.read(editingSchemaProvider.notifier).update((s) => schema);
      ref.read(editingLabelProvider.notifier).update((s) => label);
    });

    if (!isDesktop) {
      goNamed(Routes.menuItemAddEdit);
    }
  }

  void addItem(schema, String label, bool isDesktop) {
    ref.read(editingMenuProvider.notifier).update((s) => null);
    ref.read(editingSchemaProvider.notifier).update((s) => null);
    ref.read(editingLabelProvider.notifier).update((s) => null);
    Future.delayed(Duration(milliseconds: 10), () {
      ref.read(editingMenuProvider.notifier).update((s) => {});
      ref.read(editingSchemaProvider.notifier).update((s) => schema);
      ref.read(editingLabelProvider.notifier).update((s) => label);
    });

    if (!isDesktop) {
      goNamed(Routes.menuItemAddEdit);
    }
  }

  Future<void> getDocumentAsExcel(MenuDescriptor? section, String id) async {
    if(section == null) return;
    log("download ${section?.endpoint} ${id}");
    String url = "${NetworkOption().baseUrl ?? ""}$apiVersion${section?.endpoint}/document/$id";
    await DownloaderUtil.downloadSaveAndOpen(
      url,
      fileName: "${section!.fieldTitle}.xlsx",
      onProgress: (r, t) => log('$r / $t'),
      headers: {"Authorization": "Bearer ${ref.read(userProvider)?.token}"},
    );
  }

  Future<void> updateDocumentWithExcel(MenuDescriptor? menu, String id) async {
    final file = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ["xlsx"]);
    if (file == null) return;
    String api = "${NetworkOption().baseUrl ?? ""}$apiVersion${menu?.endpoint}/document/excel/$id";
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
        SuccessHandler.handle(ServerSuccess(code: 1, msg: "Done"));
      } else {
        FailureHandler.handle(ServerFailure(code: response.statusCode ?? -1, msg: response.statusMessage ?? 'Unknown Error', traceMsg: response.statusMessage ?? 'Unknown Error'));
      }
    }catch(e){
      log("$e");
      FailureHandler.handle(ServerFailure(code:  -1, msg: "$e", traceMsg:  'Unknown Error'));

    }
  }

  Future<void> deleteDocument(MenuDescriptor? menu, String id) async {
    String api = "${NetworkOption().baseUrl ?? ""}$apiVersion${menu?.endpoint}/document/$id";
    log("delete ${api}");
    final dio = Dio();
    try {
      final response = await dio.delete(
        api,
        options: Options(headers: {"Authorization": "Bearer ${ref.read(userProvider)!.token}"}),
      );
      if (response.statusCode == 200) {
        SuccessHandler.handle(ServerSuccess(code: 1, msg: "Done"));
      } else {
        FailureHandler.handle(ServerFailure(code: response.statusCode ?? -1, msg: response.statusMessage ?? 'Unknown Error', traceMsg: response.statusMessage ?? 'Unknown Error'));
      }
    }catch(e){
      FailureHandler.handle(ServerFailure(code:  -1, msg: "$e", traceMsg:  'Unknown Error'));
      log("$e");
    }
  }

  Future<void> duplicateDocument(MenuDescriptor? menu, String id) async {
    if(menu==null) return;
    String api = "${NetworkOption().baseUrl ?? ""}$apiVersion${menu?.endpoint}/duplicate/$id";
    log("delete ${api}");
    final dio = Dio();
    try {
      final response = await dio.post(
        api,
        options: Options(headers: {"Authorization": "Bearer ${ref.read(userProvider)!.token}"}),
      );
      if (response.statusCode == 200) {
        await getIt<SettingMenuController>().loadData(menu!);
        SuccessHandler.handle(ServerSuccess(code: 1, msg: "Done"));
      } else {
        FailureHandler.handle(ServerFailure(code: response.statusCode ?? -1, msg: response.statusMessage ?? 'Unknown Error', traceMsg: response.statusMessage ?? 'Unknown Error'));
      }
    }catch(e){
      FailureHandler.handle(ServerFailure(code:  -1, msg: "$e", traceMsg:  'Unknown Error'));
      log("$e");
    }
  }
}
