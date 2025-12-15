// This is a generated file - do not edit.
//
// Generated from shareData.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use shareDataResponseDescriptor instead')
const ShareDataResponse$json = {
  '1': 'ShareDataResponse',
  '2': [
    {'1': 'command', '3': 1, '4': 1, '5': 9, '10': 'command'},
    {'1': 'data', '3': 2, '4': 1, '5': 9, '10': 'data'},
  ],
};

/// Descriptor for `ShareDataResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List shareDataResponseDescriptor = $convert.base64Decode(
    'ChFTaGFyZURhdGFSZXNwb25zZRIYCgdjb21tYW5kGAEgASgJUgdjb21tYW5kEhIKBGRhdGEYAi'
    'ABKAlSBGRhdGE=');

@$core.Deprecated('Use shareDataRequestDescriptor instead')
const ShareDataRequest$json = {
  '1': 'ShareDataRequest',
};

/// Descriptor for `ShareDataRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List shareDataRequestDescriptor =
    $convert.base64Decode('ChBTaGFyZURhdGFSZXF1ZXN0');
