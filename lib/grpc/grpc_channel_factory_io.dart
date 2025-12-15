import 'package:grpc/grpc.dart';
import 'package:grpc/grpc_connection_interface.dart';
import 'grpc_channel_factory.dart';

ClientChannelBase createChannelImpl(GrpcConfig config) {
  return ClientChannel(
    config.host,
    port: config.port,
    options: ChannelOptions(
      credentials: config.useTls
          ? const ChannelCredentials.secure()
          : const ChannelCredentials.insecure(),
    ),
  );
}
