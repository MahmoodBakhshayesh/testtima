import 'package:abds/core/utils_and_services/timatic/artemis_timatic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../core/classes/server_class.dart';
import '../../core/classes/user_class.dart';

final loginProvider = ChangeNotifierProvider<LoginState>((_) => LoginState());

class LoginState extends ChangeNotifier {
  void setState() => notifyListeners();

  User? admin;

}


final userProvider = StateProvider<LoginData?>((ref) => null);
final adminProvider = StateProvider<User?>((ref) => null);
final usernameProvider = StateProvider<String>((ref) => '');
final passwordProvider = StateProvider<String>((ref) => '');
final profileProvider = StateProvider<Profile?>((ref) => null);
final updatingAvatarProvider = StateProvider<bool>((ref) => false);

final selectedServerProvider = StateProvider<Server>((ref)=>Server(name: "Main", address: 'https://timatic.multidcs.com/api/v1'));
