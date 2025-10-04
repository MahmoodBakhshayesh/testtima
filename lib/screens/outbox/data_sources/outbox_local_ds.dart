import 'package:abds/screens/outbox/usecases/get_outbox_messages_usecase.dart';

import '../../../core/data_base/local_data_base.dart';
import '../../../initialize.dart';
import '../interfaces/outbox_data_source_interface.dart';

class OutboxLocalDataSource implements OutboxDataSourceInterface {
  final LocalDataBase localDataSource = getIt<LocalDataBase>();
  OutboxLocalDataSource();

  @override
  Future<GetOutboxMessagesResponse> getOutboxMessages({required GetOutboxMessagesRequest request}) {
    // TODO: implement getOutboxMessages
    throw UnimplementedError();
  }



}
