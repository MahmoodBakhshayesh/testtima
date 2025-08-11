import 'package:abds/core/interfaces/result_int.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'failures_int.dart';

abstract class UseCase<Type, Params> {
  Future<Result<Type>> call({required Params request});
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}