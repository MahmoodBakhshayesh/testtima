import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:grpc/grpc.dart';

import '../generated/shareData.pbgrpc.dart'; // <-- adjust import to your path

class ShareDataGrpcApi {
  ShareDataGrpcApi(this._client);

  final ShareDataServiceClient _client;

  /// Example for a bidi streaming RPC:
  /// rpc ShareData(stream ShareDataRequest) returns (stream ShareDataResponse);
  Stream<ShareDataResponse> shareData({
    required Stream<ShareDataRequest> requests,
    Duration timeout = const Duration(seconds: 300000),
    Map<String, String> metadata = const {},
  }) {
    log("meta data is ${jsonEncode(metadata)}");
    final options = CallOptions(timeout: timeout, metadata: metadata);
    return _client.shareData(requests, options: options);
  }
}
