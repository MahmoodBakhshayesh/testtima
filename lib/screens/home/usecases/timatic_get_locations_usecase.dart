// import 'package:abds/core/utils_and_services/timatic/artemis_timatic.dart';
// import 'package:flutter/material.dart';
// import '../../../core/interfaces/failures_int.dart';
// import '../../../core/interfaces/request_int.dart';
// import '../../../core/interfaces/response_int.dart';
// import '../../../core/interfaces/result_int.dart';
// import '../../../core/interfaces/usecase_int.dart';
// import '../home_repository.dart';
//
// class TimaticGetLocationsUseCase extends UseCase<TimaticGetLocationsResponse,TimaticGetLocationsRequest> {
//   TimaticGetLocationsUseCase();
//
//   @override
//   Future<Result<TimaticGetLocationsResponse>> call({required TimaticGetLocationsRequest request}) {
//   if(request.validate()!=null) return Future(() =>Result.error(request.validate()!));
//     HomeRepository repository = HomeRepository();
//     return repository.timaticGetLocations(request);
//   }
//
// }
//
// class TimaticGetLocationsRequest extends RequestInterface {
//   final String? code;
//   final String? name;
//
//   TimaticGetLocationsRequest({required this.code, required this.name});
//
//   @override
//   Map<String, dynamic> toJson() =>{
//     "Body": {
//       "Execution": "TimaticGetLocations",
//       "Token":token,
//       "Request": {
//       }
//     }
//   };
//
//   Failure? validate(){
//     return null;
//   }
// }
//
//
//
//
//
