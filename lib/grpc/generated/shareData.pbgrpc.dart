// This is a generated file - do not edit.
//
// Generated from shareData.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'shareData.pb.dart' as $0;

export 'shareData.pb.dart';

@$pb.GrpcServiceName('shareData.ShareDataService')
class ShareDataServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  ShareDataServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseStream<$0.ShareDataResponse> shareData(
    $async.Stream<$0.ShareDataRequest> request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(_$shareData, request, options: options);
  }

  // method descriptors

  static final _$shareData =
      $grpc.ClientMethod<$0.ShareDataRequest, $0.ShareDataResponse>(
          '/shareData.ShareDataService/ShareData',
          ($0.ShareDataRequest value) => value.writeToBuffer(),
          $0.ShareDataResponse.fromBuffer);
}

@$pb.GrpcServiceName('shareData.ShareDataService')
abstract class ShareDataServiceBase extends $grpc.Service {
  $core.String get $name => 'shareData.ShareDataService';

  ShareDataServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.ShareDataRequest, $0.ShareDataResponse>(
        'ShareData',
        shareData,
        true,
        true,
        ($core.List<$core.int> value) => $0.ShareDataRequest.fromBuffer(value),
        ($0.ShareDataResponse value) => value.writeToBuffer()));
  }

  $async.Stream<$0.ShareDataResponse> shareData(
      $grpc.ServiceCall call, $async.Stream<$0.ShareDataRequest> request);
}
