import 'package:grpc/grpc_connection_interface.dart';
import 'grpc_channel_factory.dart';

ClientChannelBase createChannelImpl(GrpcConfig config) {
  throw UnsupportedError('No gRPC channel implementation for this platform.');
}
