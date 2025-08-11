// auth_request.dart
class LoginRequest {
  final String username;
  final String password;

  /// Arbitrary JSON blobs passed straight to the API.
  /// Example: {"name":"DCS One","id":"1e5rt71e", ...}
  final Map<String, dynamic> app;
  final Map<String, dynamic> device;
  final Map<String, dynamic> network;

  const LoginRequest({
    required this.username,
    required this.password,
    required this.app,
    required this.device,
    required this.network,
  });

  LoginRequest copyWith({
    String? username,
    String? password,
    Map<String, dynamic>? app,
    Map<String, dynamic>? device,
    Map<String, dynamic>? network,
  }) {
    return LoginRequest(
      username: username ?? this.username,
      password: password ?? this.password,
      app: app ?? Map<String, dynamic>.from(this.app),
      device: device ?? Map<String, dynamic>.from(this.device),
      network: network ?? Map<String, dynamic>.from(this.network),
    );
  }

  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    return LoginRequest(
      username: (json['username'] ?? '').toString(),
      password: (json['password'] ?? '').toString(),
      app: Map<String, dynamic>.from(json['app'] ?? const {}),
      device: Map<String, dynamic>.from(json['device'] ?? const {}),
      network: Map<String, dynamic>.from(json['network'] ?? const {}),
    );
  }

  Map<String, dynamic> toJson() => {
    'username': username,
    'password': password,
    'app': app,
    'device': device,
    'network': network,
  };

  @override
  String toString() =>
      'LoginRequest(username: $username, password: [HIDDEN], app: $app, device: $device, network: $network)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is LoginRequest &&
              runtimeType == other.runtimeType &&
              username == other.username &&
              password == other.password &&
              _mapEquals(app, other.app) &&
              _mapEquals(device, other.device) &&
              _mapEquals(network, other.network);

  @override
  int get hashCode => Object.hash(
    username,
    password,
    Object.hashAll(app.entries),
    Object.hashAll(device.entries),
    Object.hashAll(network.entries),
  );
}

bool _mapEquals(Map<String, dynamic> a, Map<String, dynamic> b) {
  if (a.length != b.length) return false;
  for (final key in a.keys) {
    if (!b.containsKey(key) || a[key] != b[key]) return false;
  }
  return true;
}
