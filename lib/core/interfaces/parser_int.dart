import 'package:flutter/foundation.dart';

import 'request_int.dart';

abstract class ParserInterface {
  Future<R> parse<M, R>(ComputeCallback<M, R> callback, M toBeParsed, {String? debugLabel, String startingErrorMessage = '', required RequestInterface executionReq});
}
