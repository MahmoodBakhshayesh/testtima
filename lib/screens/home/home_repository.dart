import 'dart:developer';
import 'package:dartz/dartz.dart';
import '../../core/interface_implementations/network_info_imp.dart';
import '../../core/interfaces/exception_int.dart';
import '../../core/interfaces/failures_int.dart';
import '../../core/interfaces/result_int.dart';
import '../../initialize.dart';
import 'interfaces/home_repository_interface.dart';
import 'data_sources/home_local_ds.dart';
import 'data_sources/home_remote_ds.dart';
import 'usecases/get_ref_code_log_usecase.dart';

class HomeRepository implements HomeRepositoryInterface {
  final HomeRemoteDataSource homeRemoteDataSource = HomeRemoteDataSource();
  final HomeLocalDataSource homeLocalDataSource = HomeLocalDataSource();
  final NetworkInfoImp networkInfo = getIt<NetworkInfoImp>();

  HomeRepository();

  @override
  Future<Result<GetRefCodeLogResponse>> getRefCodeLog(GetRefCodeLogRequest request) async {
    try {
      GetRefCodeLogResponse getRefCodeLogResponse;
      if (await networkInfo.isConnected) {
        getRefCodeLogResponse = await homeRemoteDataSource.getRefCodeLog(request: request);
      } else {
        getRefCodeLogResponse = await homeLocalDataSource.getRefCodeLog(request: request);
      }
      return Result.ok(getRefCodeLogResponse);
    } on AppException catch (e) {
      return Result.error(ServerFailure.fromAppException(e));
    }
  }
}
