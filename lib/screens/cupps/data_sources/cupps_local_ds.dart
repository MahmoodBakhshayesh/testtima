import '../../../core/data_base/local_data_base.dart';
import '../../../initialize.dart';
import '../interfaces/cupps_data_source_interface.dart';

class CuppsLocalDataSource implements CuppsDataSourceInterface {
  final LocalDataBase localDataSource = getIt<LocalDataBase>();
  CuppsLocalDataSource();



}
