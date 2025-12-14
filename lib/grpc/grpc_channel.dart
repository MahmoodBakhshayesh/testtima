import 'package:grpc/grpc.dart';

class GrpcConfig {
  final String host;
  final int port;
  final bool useTls;

  const GrpcConfig({
    required this.host,
    required this.port,
    this.useTls = true,
  });
}

class GrpcChannelFactory {
  GrpcChannelFactory(this.config);

  final GrpcConfig config;

  ClientChannel create() {
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
}
