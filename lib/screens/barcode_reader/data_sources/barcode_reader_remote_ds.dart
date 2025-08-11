import '../../../core/interface_implementations/network_manager_imp.dart';
import '../../../core/data_base/local_data_base.dart';
import '../interfaces/barcode_reader_data_source_interface.dart';
import 'barcode_reader_local_ds.dart';

class BarcodeReaderRemoteDataSource implements BarcodeReaderDataSourceInterface {
  final BarcodeReaderLocalDataSource localDataSource = BarcodeReaderLocalDataSource();
  final NetworkManagerImp networkManager = NetworkManagerImp();
  BarcodeReaderRemoteDataSource();
}
