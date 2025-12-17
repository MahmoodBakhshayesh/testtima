import 'package:dartz/dartz.dart';

import '../../../core/interfaces/result_int.dart';
import '../usecases/add_section_menu_usecase.dart';
import '../usecases/get_menu_usecase.dart';
import '../usecases/load_section_menu_usecase.dart';
import '../usecases/menu_get_template_usecase.dart';
import '../usecases/save_section_menu_usecase.dart';


abstract class SettingMenuRepositoryInterface {
  Future<Result<GetMenuResponse>> getMenu(GetMenuRequest request);
  Future<Result<LoadSectionMenuResponse>> loadSectionMenu(LoadSectionMenuRequest request);
  Future<Result<SaveSectionMenuResponse>> saveSectionMenu(SaveSectionMenuRequest request);
  Future<Result<AddSectionMenuResponse>> addSectionMenu(AddSectionMenuRequest request);
  Future<Result<MenuGetTemplateResponse>> menuGetTemplate(MenuGetTemplateRequest request);
}