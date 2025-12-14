import 'package:flutter/foundation.dart';
import 'package:grpc/grpc.dart';
import 'package:grpc/grpc_web.dart';            // ✅ comes from grpc package
import 'package:grpc/grpc_or_grpcweb.dart';
import 'package:grpc/src/client/channel.dart' hide ClientChannel;     // ✅ comes from grpc package

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

  ClientChannelBase create() {

    if (kIsWeb) {
      // Option A: direct grpc-web channel
      final uri = Uri.parse( config.host.startsWith('http') ?  config.host : 'https://${ config.host}');

      return GrpcWebClientChannel.xhr(uri);
    }
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
