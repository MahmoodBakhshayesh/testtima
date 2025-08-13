import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/classes/people_class.dart';

final usersStateProvider = ChangeNotifierProvider<UsersState>((_) => UsersState());

class UsersState extends ChangeNotifier {
  void setState() => notifyListeners();

  ///bool loading = false;

}

final peopleListProvider = StateProvider<List<People>>((ref) => []);
final loadingUsersProvider = StateProvider<bool>((ref) => false);


///final userProvider = StateProvider<User?>((ref) => null);
