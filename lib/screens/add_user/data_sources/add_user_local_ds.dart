import '../../../core/data_base/local_data_base.dart';
import '../../../initialize.dart';
import '../interfaces/add_user_data_source_interface.dart';

class AddUserLocalDataSource implements AddUserDataSourceInterface {
  final LocalDataBase localDataSource = getIt<LocalDataBase>();
  AddUserLocalDataSource();



}
