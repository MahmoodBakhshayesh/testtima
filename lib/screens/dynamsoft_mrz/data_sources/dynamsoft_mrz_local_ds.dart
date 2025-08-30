import '../../../core/data_base/local_data_base.dart';
import '../../../initialize.dart';
import '../interfaces/dynamsoft_mrz_data_source_interface.dart';

class DynamsoftMrzLocalDataSource implements DynamsoftMrzDataSourceInterface {
  final LocalDataBase localDataSource = getIt<LocalDataBase>();
  DynamsoftMrzLocalDataSource();



}
