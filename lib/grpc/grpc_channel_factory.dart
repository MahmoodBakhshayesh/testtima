import 'package:grpc/grpc.dart';
import 'package:grpc/grpc_connection_interface.dart';

import 'grpc_channel_factory_stub.dart'
if (dart.library.html) 'grpc_channel_factory_web.dart'
if (dart.library.io) 'grpc_channel_factory_io.dart';

class GrpcConfig {
  /// For native gRPC (IO): host like `sharedata.multidcs.com` (NO scheme, NO path)
  final String host;

  /// For native gRPC (IO): usually 443
  final int port;

  /// For native gRPC (IO): TLS on/off
  final bool useTls;

  /// For Web (gRPC-Web): full URL like `https://sharedata.multidcs.com/grpc`
  /// If null, we’ll fallback to `https://$host`
  final String? webUrl;

  const GrpcConfig({
    required this.host,
    this.port = 443,
    this.useTls = true,
    this.webUrl,
  });
}

class GrpcChannelFactory {
  GrpcChannelFactory(this.config);

  final GrpcConfig config;

  ClientChannelBase create() => createChannelImpl(config);
}

// /// Public function implemented per platform via conditional imports
// ClientChannelBase createChannelImpl(GrpcConfig config) {
//       return createChannelImpl(config);
// }
