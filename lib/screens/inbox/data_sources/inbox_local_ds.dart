import 'package:abds/screens/inbox/usecases/get_messages_usecase.dart';
import 'package:abds/screens/inbox/usecases/read_msg_usecase.dart';

import '../../../core/data_base/local_data_base.dart';
import '../../../initialize.dart';
import '../interfaces/inbox_data_source_interface.dart';

class InboxLocalDataSource implements InboxDataSourceInterface {
  final LocalDataBase localDataSource = getIt<LocalDataBase>();
  InboxLocalDataSource();

  @override
  Future<GetMessagesResponse> getMessages({required GetMessagesRequest request}) {
    // TODO: implement getMessages
    throw UnimplementedError();
  }

  @override
  Future<ReadMsgResponse> readMsg({required ReadMsgRequest request}) {
    // TODO: implement readMsg
    throw UnimplementedError();
  }



}
