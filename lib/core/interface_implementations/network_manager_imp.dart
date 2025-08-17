import 'dart:convert';
import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:network_manager/network_manager.dart';
import '../../core/interface_implementations/response_imp.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart' as dio;
import '../../initialize.dart';
import '../../screens/login/login_state.dart';
import '../interfaces/exception_int.dart';
import '../interfaces/network_manager_int.dart';
import '../interfaces/request_int.dart';
import '../interfaces/response_int.dart';
import '../constants/apis.dart';
import 'exceptions_imp.dart';

class NetworkManagerImp implements NetworkManagerInterface {
  NetworkManagerImp();

  @override
  Future<ResponseImplementation> post(RequestInterface request, {String? api, Map<String, String>? headers, Duration? timeout,bool isBridge = false}) async {
    NetworkOption option = NetworkOption();

    String apiAddress = api == null
        ? option.baseUrl!
        : api.contains("http")
        ? api
        : option.baseUrl! + api;

    dynamic reqJson = request.toJson();

    NetworkRequest networkRequest = NetworkRequest(api: apiAddress, data: reqJson);

    String? token = getIt<WidgetRef>().read(userProvider)?.token;
    if (token != null) {
      networkRequest.options.headers?.addAll({"Authorization": "Bearer $token"});
    }
    if (headers != null) {
      networkRequest.options.headers?.addAll(headers);
    }

    NetworkResponse networkResponse = await networkRequest.post();
    log(jsonEncode(networkResponse.responseBody));
    if (networkResponse.status) {
      try {
        ResponseImplementation res = ResponseImplementation.fromJson(networkResponse.responseBody);

        return res;
      } catch (e, trace) {
        log("ParseException");
        throw ParseException(message: e.toString(), trace: trace);
      }
    } else {
      String? errorMsg = jsonDecode(networkResponse.responseBody)["message"];

      throw ServerException(code: networkResponse.responseCode, message:errorMsg?? networkResponse.extractedMessage!, trace: StackTrace.fromString("NetworkManagerImp.post"), data: networkResponse.responseBody);
    }
  }

  @override
  Future<ResponseImplementation> get(
      String? url, {
        Map<String, String>? headers,
      }) async {
    NetworkOption option = NetworkOption();
    String apiAddress = url == null
        ? option.baseUrl!
        : url.contains("http")
        ? url
        : option.baseUrl! + url;

    NetworkRequest networkRequest = NetworkRequest(api: apiAddress, data: '');
    String? token = getIt<WidgetRef>().read(userProvider)?.token;
    log(getIt<WidgetRef>().read(userProvider)?.token.toString()??'');

    if (token != null) {
      log("no null token");
      networkRequest.options.headers?.addAll({"Authorization": "Bearer $token"});
      log(networkRequest.options.headers.toString());

    }

    if (headers != null) {
      log("no null header");
      networkRequest.options.headers?.addAll(headers);
    }

    log(jsonEncode(networkRequest.options.headers));
    NetworkResponse networkResponse = await networkRequest.get();

    if (networkResponse.status) {
      try {
        ResponseImplementation res = ResponseImplementation.fromJson(networkResponse.responseBody);

        return res;
      } catch (e, trace) {
        throw ParseException(message: e.toString(), trace: trace);
      }
    } else {
      String? errorMsg = jsonDecode(networkResponse.responseBody)["message"];

      throw ServerException(code: networkResponse.responseCode, message:errorMsg?? networkResponse.extractedMessage!, trace: StackTrace.fromString("NetworkManagerImp.post"), data: networkResponse.responseBody);
    }
    // return res;
  }

  @override
  Future<ResponseImplementation> delete(RequestInterface request, {String? api, Map<String, String>? headers, Duration? timeout}) async {
    NetworkOption option = NetworkOption();

    String apiAddress = api == null
        ? option.baseUrl!
        : api.contains("http")
        ? api
        : option.baseUrl! + api;

    dynamic reqJson = request.toJson();
    NetworkRequest networkRequest = NetworkRequest(api: apiAddress, data: reqJson);

    String? token = getIt<WidgetRef>().read(userProvider)?.token;
    if (token != null) {
      networkRequest.options.headers?.addAll({"Authorization": "Bearer $token"});
    }
    if (headers != null) {
      networkRequest.options.headers?.addAll(headers);
    }

    NetworkResponse networkResponse = await networkRequest.delete();

    if (networkResponse.status) {
      try {
        ResponseImplementation res = ResponseImplementation.fromJson(networkResponse.responseBody);
        return res;
      } catch (e, trace) {
        throw ParseException(message: e.toString(), trace: trace);
      }
    } else {
      String? errorMsg = jsonDecode(networkResponse.responseBody)["message"];

      throw ServerException(code: networkResponse.responseCode, message:errorMsg?? networkResponse.extractedMessage!, trace: StackTrace.fromString("NetworkManagerImp.post"), data: networkResponse.responseBody);
    }
  }

  Future<ResponseImplementation> patch(RequestInterface request, {String? api, Map<String, String>? headers, Duration? timeout}) async {
    NetworkOption option = NetworkOption();

    String apiAddress = api == null
        ? option.baseUrl!
        : api.contains("http")
        ? api
        : option.baseUrl! + api;

    dynamic reqJson = request.toJson();
    NetworkRequest networkRequest = NetworkRequest(api: apiAddress, data: reqJson);

    String? token = getIt<WidgetRef>().read(userProvider)?.token;
    if (token != null) {
      networkRequest.options.headers?.addAll({"Authorization": "Bearer $token"});
    }
    if (headers != null) {
      networkRequest.options.headers?.addAll(headers);
    }

    NetworkResponse networkResponse = await networkRequest.patch();

    if (networkResponse.status) {
      try {
        ResponseImplementation res = ResponseImplementation.fromJson(networkResponse.responseBody);
        return res;
      } catch (e, trace) {
        throw ParseException(message: e.toString(), trace: trace);
      }
    } else {
      String? errorMsg = jsonDecode(networkResponse.responseBody)["message"];

      throw ServerException(code: networkResponse.responseCode, message:errorMsg?? networkResponse.extractedMessage!, trace: StackTrace.fromString("NetworkManagerImp.post"), data: networkResponse.responseBody);
    }
  }

  @override
  Future<ResponseImplementation> put(RequestInterface request, {String? api, Map<String, String>? headers, Duration? timeout}) async {
    NetworkOption option = NetworkOption();

    String apiAddress = api == null
        ? option.baseUrl!
        : api.contains("http")
        ? api
        : option.baseUrl! + api;

    dynamic reqJson = request.toJson();
    NetworkRequest networkRequest = NetworkRequest(api: apiAddress, data: reqJson);

    String? token = getIt<WidgetRef>().read(userProvider)?.token;
    if (token != null) {
      networkRequest.options.headers?.addAll({"Authorization": "Bearer $token"});
    }
    if (headers != null) {
      networkRequest.options.headers?.addAll(headers);
    }

    NetworkResponse networkResponse = await networkRequest.put();
    if (networkResponse.status) {
      try {
        ResponseImplementation res = ResponseImplementation.fromJson(networkResponse.responseBody);
        return res;
      } catch (e, trace) {
        throw ParseException(message: e.toString(), trace: trace);
      }
    } else {
      String? errorMsg = jsonDecode(networkResponse.responseBody)["message"];

      throw ServerException(code: networkResponse.responseCode, message:errorMsg?? networkResponse.extractedMessage!, trace: StackTrace.fromString("NetworkManagerImp.post"), data: networkResponse.responseBody);
    }
  }
}
