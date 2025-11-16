import 'package:abds/core/utils_and_services/timatic/artemis_timatic.dart';

import '../../../core/interface_implementations/response_imp.dart';
import '../../../core/interfaces/request_int.dart';
import '../../../core/interfaces/device_info_service_int.dart';
import '../../../core/interfaces/failures_int.dart';
import '../../../core/interfaces/result_int.dart';
import '../../../core/interfaces/usecase_int.dart';
import 'package:dartz/dartz.dart';
import '../../../core/classes/user_class.dart';
import '../../../core/utils_and_services/app_config.dart';
import '../login_repository.dart';

class LoginUseCase extends UseCase<LoginResponse, LoginRequest> {
  LoginUseCase();

  @override
  Future<Result<LoginResponse>> call({required LoginRequest request}) {
    if (request.validate() != null) return Future(() => Result.error(request.validate()!));
    LoginRepository repository = LoginRepository();
    return repository.login(request);
  }
}

class LoginRequest extends RequestInterface{
  final String username;
  final String password;

  /// Arbitrary JSON blobs passed straight to the API.
  /// Example: {"name":"DCS One","id":"1e5rt71e", ...}
  final Map<String, dynamic> firebase;
  final Map<String, dynamic> app;
  final Map<String, dynamic> device;
  final Map<String, dynamic> network;

  LoginRequest({
    required this.username,
    required this.password,
    required this.firebase,
    required this.app,
    required this.device,
    required this.network,
  });

  LoginRequest copyWith({
    String? username,
    String? password,
    Map<String, dynamic>? firebase,
    Map<String, dynamic>? app,
    Map<String, dynamic>? device,
    Map<String, dynamic>? network,
  }) {
    return LoginRequest(
      username: username ?? this.username,
      password: password ?? this.password,

      app: app ?? Map<String, dynamic>.from(this.app),
      firebase: firebase ?? Map<String, dynamic>.from(this.firebase),
      device: device ?? Map<String, dynamic>.from(this.device),
      network: network ?? Map<String, dynamic>.from(this.network),
    );
  }

  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    return LoginRequest(
      username: (json['username'] ?? '').toString(),
      password: (json['password'] ?? '').toString(),
      firebase: Map<String, dynamic>.from(json['firebase'] ?? const {}),
      app: Map<String, dynamic>.from(json['app'] ?? const {}),
      device: Map<String, dynamic>.from(json['device'] ?? const {}),
      network: Map<String, dynamic>.from(json['network'] ?? const {}),
    );
  }

  Map<String, dynamic> toJson() => {
    'username': username,
    'password': password,
    'app': app,
    'firebase': firebase,
    'device': device,
    'network': network,
  };

  Failure? validate() {
    return null;
  }
}

class LoginResponse extends ResponseImplementation {
  final LoginData user;

  LoginResponse({required int status, required String message, required this.user})
      : super(
    status: status,
    message: message,
    body:user.toJson(),
  );

  factory LoginResponse.fromResponse(ResponseImplementation res) => LoginResponse(
    status: res.status,
    message: res.message,
    user: LoginData.fromJson(res.body),
  );
}
