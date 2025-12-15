import 'package:grpc/grpc_connection_interface.dart';
import 'package:grpc/grpc_web.dart';
import 'package:grpc/grpc.dart' show ClientChannelBase;
import 'grpc_channel_factory.dart';

ClientChannelBase createChannelImpl(GrpcConfig config) {
  final url = (config.host == null || config.host!.isEmpty)
      ? (config.host.startsWith('http') ? config.host : 'https://${config.host}')
      : config.host!;
      final uri = Uri.parse( config.host.startsWith('http') ?  config.host : 'https://${ config.host}');

      return GrpcWebClientChannel.xhr(uri);
  return GrpcWebClientChannel.xhr(Uri.parse(url));
}
