class TimaticError implements Exception {
  final String message;
  final int? statusCode;
  final Object? cause;

  TimaticError(this.message, {this.statusCode, this.cause});

  @override
  String toString() => 'TimaticError: $message';
}

class TimaticNetworkError extends TimaticError {
  TimaticNetworkError(super.message, {super.statusCode, super.cause});
}

class TimaticParsingError extends TimaticError {
  TimaticParsingError(super.message, {super.cause});
}
