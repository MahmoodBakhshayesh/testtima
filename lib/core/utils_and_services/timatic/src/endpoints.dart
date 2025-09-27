// import 'dart:convert';
// import 'dart:developer';
// import 'package:abds/core/interfaces/failures_int.dart';
// import 'package:abds/core/utils_and_services/handlers/failure_handler.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import '../../../../initialize.dart';
// import '../../../../screens/login/login_controller.dart';
// import '../../../../screens/login/usecases/login_usecase.dart';
// import '../../../classes/constant_data_class.dart';
// import 'defaults.dart';
// import 'errors.dart';
// import 'models/accepted_values.dart';
// import 'models/aggregates.dart';
// import 'models/document_request.dart';
// import 'models/document_response.dart';
// import 'models/location.dart';
// import 'models/parameter_type.dart';
// import 'models/parameters.dart';
// import 'timatic_client.dart';
// import 'models/auth_request.dart';
// import 'models/auth_response.dart';
//
// class TimaticApi {
//   final TimaticClient _client;
//
//   // ===== In-memory cache (simple) =====
//   TimaticParams? _cachedParams;
//   TimaticLocations? _cachedLocations;
//
//   TimaticApi(this._client);
//
//   Future<LoginData> login(LoginRequest body) async {
//     try {
//       final res = await _client.dio.post('/user/login', data: jsonEncode(body.toJson()));
//
//       if (res.statusCode == 200 && res.data is Map<String, dynamic>) {
//         final env = LoginEnvelope.fromJson(Map<String, dynamic>.from(res.data));
//         if (env.success && env.data != null) {
//           // store token for subsequent requests
//           _client.setAuthToken(env.data!.token);
//           return env.data!;
//         }
//         throw TimaticError(env.message ?? 'Login failed', statusCode: res.statusCode);
//       }
//       throw TimaticParsingError('Unexpected response for /user/login');
//     } on DioException catch (e) {
//       log("*" * 100);
//       String? error = e.response?.data["message"];
//       log(jsonEncode(e.response?.data));
//       log("*" * 100);
//       throw TimaticNetworkError(error ?? e.message ?? 'Network error', statusCode: e.response?.statusCode, cause: e);
//     } catch (e) {
//       log(e.toString());
//       log(e.runtimeType.toString());
//       if (e is TimaticError) {
//         throw e;
//       }
//       if (e is String) {
//         throw TimaticError(e, cause: e);
//       }
//       throw TimaticError('Unknown error during login', cause: e);
//     }
//   }
//   Future<void> setToken(String token) async {
//     _client.setAuthToken(token);
//   }
//   Future<void> setUrl(String url) async {
//     _client.setUrl(url);
//   }
//   //
//   // /// GET /locations/:locationType?code=&name=
//   // Future<List<Location>> listLocationsByType(LocationType type, {String? code, String? name}) async {
//   //   try {
//   //     final res = await _client.dio.get(
//   //       '/locations/${type.name}', // enum names match API (e.g., "AIRPORT")
//   //       queryParameters: {if (code != null && code.isNotEmpty) 'code': code, if (name != null && name.isNotEmpty) 'name': name},
//   //     );
//   //
//   //     if (res.statusCode == 200 && res.data is Map<String, dynamic>) {
//   //       final env = LocationsEnvelope.fromJson(Map<String, dynamic>.from(res.data));
//   //       return env.locations;
//   //     }
//   //     throw TimaticParsingError('Unexpected response for /locations/${type.name}');
//   //   } on DioException catch (e) {
//   //     throw TimaticNetworkError(e.message ?? 'Network error', statusCode: e.response?.statusCode, cause: e);
//   //   } catch (e) {
//   //     if (e is Error) {
//   //       log(e.stackTrace.toString());
//   //     }
//   //     throw TimaticError('Unknown error fetching locations', cause: e);
//   //   }
//   // }
//   //
//   // /// GET /locations?locationType=CITY&locationType=AIRPORT&code=&name=
//   // Future<List<Location>> searchLocations({List<LocationType>? types, String? code, String? name}) async {
//   //   try {
//   //     final qp = <String, dynamic>{if (code != null && code.isNotEmpty) 'code': code, if (name != null && name.isNotEmpty) 'name': name};
//   //
//   //     // Repeat locationType params if provided
//   //     if (types != null && types.isNotEmpty) {
//   //       // Dio supports lists to create repeated query params
//   //       qp['locationType'] = types.map((t) => t.name).toList();
//   //     }
//   //
//   //     final res = await _client.dio.get('/locations', queryParameters: qp);
//   //
//   //     if (res.statusCode == 200 && res.data is Map<String, dynamic>) {
//   //       final env = LocationsEnvelope.fromJson(Map<String, dynamic>.from(res.data));
//   //       return env.locations;
//   //     }
//   //     throw TimaticParsingError('Unexpected response for /locations');
//   //   } on DioException catch (e) {
//   //     throw TimaticNetworkError(e.message ?? 'Network error', statusCode: e.response?.statusCode, cause: e);
//   //   } catch (e) {
//   //     throw TimaticError('Unknown error searching locations', cause: e);
//   //   }
//   // }
//   //
//   // /// GET /parameters?code=pets&code=channel&name=Cat
//   // ///
//   // /// Pass multiple codes; they will be sent as repeated ?code= params.
//   // Future<ParametersEnvelope> getParameters({required List<String> codes, String? name}) async {
//   //   try {
//   //     final qp = <String, dynamic>{
//   //       if (codes.isNotEmpty) 'code': codes, // Dio repeats query for lists
//   //       if (name != null && name.isNotEmpty) 'name': name,
//   //     };
//   //
//   //     final res = await _client.dio.get('/parameters', queryParameters: qp);
//   //
//   //     if (res.statusCode == 200 && res.data is Map<String, dynamic>) {
//   //       return ParametersEnvelope.fromJson(Map<String, dynamic>.from(res.data));
//   //     }
//   //     throw TimaticParsingError('Unexpected response for /parameters');
//   //   } on DioException catch (e) {
//   //     throw TimaticNetworkError(e.message ?? 'Network error', statusCode: e.response?.statusCode, cause: e);
//   //   } catch (e) {
//   //     throw TimaticError('Unknown error fetching parameters', cause: e);
//   //   }
//   // }
//   //
//   // /// GET /accepted-values/:countryCode/:parameter?ruleSetTypes=REQDOC&ruleSetTypes=...
//   // // Future<AcceptedValuesEnvelope> getAcceptedValues({
//   // //   required String countryCode,
//   // //   required String parameter, // e.g., "docIssueCountry"
//   // //   List<String>? ruleSetTypes, // e.g., ["REQTIX","INFTST","REQDOC"]
//   // // }) async {
//   // //   try {
//   // //     final qp = <String, dynamic>{
//   // //       if (ruleSetTypes != null && ruleSetTypes.isNotEmpty) 'ruleSetTypes': ruleSetTypes, // Dio repeats for lists
//   // //     };
//   // //
//   // //     final res = await _client.dio.get('/accepted-values/$countryCode/$parameter', queryParameters: qp);
//   // //
//   // //     if (res.statusCode == 200 && res.data is Map<String, dynamic>) {
//   // //       return AcceptedValuesEnvelope.fromJson(Map<String, dynamic>.from(res.data));
//   // //     }
//   // //     throw TimaticParsingError('Unexpected response for /accepted-values');
//   // //   } on DioException catch (e) {
//   // //     throw TimaticNetworkError(e.message ?? 'Network error', statusCode: e.response?.statusCode, cause: e);
//   // //   } catch (e) {
//   // //     throw TimaticError('Unknown error fetching accepted values', cause: e);
//   // //   }
//   // // }
//
//   /// POST /documentRequest
//   Future<DocumentResponse> submitDocumentRequest(DocumentRequest body) async {
//     try {
//       final res = await _client.dio.post(
//         '/documentRequest',
//         data: body.toJson(), // json_serializable handles maps
//       );
//       log(jsonEncode(body.toJson()));
//       if(res.statusCode == 401){
//         // LoginController homeController = getIt<LoginController>();
//         // homeController.logout(isTokenExpire: true);
//         // throw TimaticNetworkError('Token Expired',statusCode: 401);
//
//
//
//
//       }else if (res.statusCode == 200 && res.data is Map<String, dynamic>) {
//         if (res.data["timaticErrors"] is List) {
//           final erL = (res.data["timaticErrors"] as List<dynamic>).map((a) => a["details"].toString());
//           throw TimaticError(erL.join("\n"), cause: res.data["timaticErrors"]);
//         } else {
//           // log(res.data["timaticErrors"].runtimeType.toString());
//         }
//
//         return DocumentResponse.fromJson(Map<String, dynamic>.from(res.data));
//       }
//       throw TimaticParsingError('Unexpected response for /documentRequest');
//     } on DioException catch (e) {
//
//       if(e.response?.statusCode == 401){
//         log("-"* 100 );
//         log("${e.response?.data}");
//         String? message;
//         if(e.response?.data is Map<String,dynamic>){
//           message =  e.response?.data["message"];
//         }
//         message=message??"Token Expire";
//         LoginController homeController = getIt<LoginController>();
//         homeController.logout(isTokenExpire: true);
//         Future.delayed(Duration(milliseconds: 300),(){
//           FailureHandler.handle(ServerFailure(code: 401, msg: message!, traceMsg: message!));
//         });
//       }
//       throw TimaticNetworkError(e.message ?? 'Network error', statusCode: e.response?.statusCode, cause: e);
//
//     } catch (e) {
//       throw TimaticError(e.toString(), cause: e);
//     }
//   }
//
//
// }
