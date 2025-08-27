import 'package:abds/screens/mrz_reader/usecases/send_logs_usecase.dart';

import '../../../core/data_base/local_data_base.dart';
import '../../../initialize.dart';
import '../interfaces/mrz_reader_data_source_interface.dart';

class MrzReaderLocalDataSource implements MrzReaderDataSourceInterface {
  final LocalDataBase localDataSource = getIt<LocalDataBase>();
  MrzReaderLocalDataSource();

  @override
  Future<SendLogsResponse> sendLogs({required SendLogsRequest request}) {
    // TODO: implement sendLogs
    throw UnimplementedError();
  }



}
