import '../../../core/data_base/local_data_base.dart';
import '../../../initialize.dart';
import '../interfaces/barcode_reader_data_source_interface.dart';

class BarcodeReaderLocalDataSource implements BarcodeReaderDataSourceInterface {
  final LocalDataBase localDataSource = getIt<LocalDataBase>();
  BarcodeReaderLocalDataSource();



}
