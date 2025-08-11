import '../../../core/data_base/local_data_base.dart';
import '../../../initialize.dart';
import '../interfaces/mrz_reader_data_source_interface.dart';

class MrzReaderLocalDataSource implements MrzReaderDataSourceInterface {
  final LocalDataBase localDataSource = getIt<LocalDataBase>();
  MrzReaderLocalDataSource();



}
