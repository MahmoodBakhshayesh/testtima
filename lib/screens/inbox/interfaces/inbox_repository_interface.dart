import 'package:dartz/dartz.dart';

import '../../../core/interfaces/result_int.dart';
import '../usecases/get_messages_usecase.dart';
import '../usecases/read_msg_usecase.dart';


abstract class InboxRepositoryInterface {
  Future<Result<GetMessagesResponse>> getMessages(GetMessagesRequest request);
  Future<Result<ReadMsgResponse>> readMsg(ReadMsgRequest request);
}