import '../../../core/data_base/local_data_base.dart';
import '../../../initialize.dart';
import '../interfaces/inbox_data_source_interface.dart';

class InboxLocalDataSource implements InboxDataSourceInterface {
  final LocalDataBase localDataSource = getIt<LocalDataBase>();
  InboxLocalDataSource();



}
