import 'package:dartz/dartz.dart';

import '../../../core/interfaces/result_int.dart';
import '../usecases/get_outbox_messages_usecase.dart';


abstract class OutboxRepositoryInterface {
  Future<Result<GetOutboxMessagesResponse>> getOutboxMessages(GetOutboxMessagesRequest request);
}