import 'package:abds/core/classes/receiver_data_class.dart';
import 'package:abds/core/classes/sender_data_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../grpc/share_data_receiver.dart';

final receiverStateProvider = ChangeNotifierProvider<ReceiverState>((_) => ReceiverState());

class ReceiverState extends ChangeNotifier {
  void setState() => notifyListeners();

  ///bool loading = false;
}

final receiverDataProvider = StateProvider<ReceiverData?>((ref) => null);
final receiverStatusProvider = StateProvider<GrpcStreamStatus>((ref) => GrpcStreamStatus.idle);
final senderDataProvider = StateProvider<SenderData?>((ref) => null);
