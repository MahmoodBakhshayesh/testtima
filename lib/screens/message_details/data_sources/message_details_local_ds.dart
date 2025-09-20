import '../../../core/data_base/local_data_base.dart';
import '../../../initialize.dart';
import '../interfaces/message_details_data_source_interface.dart';

class MessageDetailsLocalDataSource implements MessageDetailsDataSourceInterface {
  final LocalDataBase localDataSource = getIt<LocalDataBase>();
  MessageDetailsLocalDataSource();



}
