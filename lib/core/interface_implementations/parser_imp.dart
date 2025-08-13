
import 'package:flutter/foundation.dart';

import '../interfaces/exception_int.dart';
import '../interfaces/failures_int.dart';
import '../interfaces/parser_int.dart';
import '../interfaces/request_int.dart';
import 'exceptions_imp.dart';

class Parser implements ParserInterface {
  @override
  Future<R> parse<M, R>(ComputeCallback<M, R> callback, M toBeParsed, {String? debugLabel, String startingErrorMessage = '', required RequestInterface executionReq}) async {
    try {
      final res = await compute(callback, toBeParsed);
      return res;
    } catch (e, tr) {
      ParseException pe = ParseException(message: e.toString(), trace: tr);
      Failure f = ServerFailure.fromAppException(ParseException(message: e.toString(), trace: tr));
      throw pe;
    }
  }
}
