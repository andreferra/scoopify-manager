import 'package:flutter/material.dart';

import '../models/user_model.dart';

class UserNotifier extends ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  void setUser(UserModel? user) {
    _user = user;
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }
}

class UserProvider extends InheritedNotifier<UserNotifier> {
  const UserProvider({super.key, required UserNotifier notifier, required Widget child})
      : super(notifier: notifier, child: child);

  static UserNotifier of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<UserProvider>();
    assert(provider != null, 'No UserProvider found in context');
    return provider!.notifier!;
  }
}
