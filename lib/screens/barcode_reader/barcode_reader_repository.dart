import '../../core/interface_implementations/network_info_imp.dart';
import '../../initialize.dart';
import 'interfaces/barcode_reader_repository_interface.dart';
import 'data_sources/barcode_reader_local_ds.dart';
import 'data_sources/barcode_reader_remote_ds.dart';

class BarcodeReaderRepository implements BarcodeReaderRepositoryInterface {
  final BarcodeReaderRemoteDataSource barcodeReaderRemoteDataSource = BarcodeReaderRemoteDataSource();
  final BarcodeReaderLocalDataSource barcodeReaderLocalDataSource = BarcodeReaderLocalDataSource();
  final NetworkInfoImp networkInfo = getIt<NetworkInfoImp>();

  BarcodeReaderRepository();
}
