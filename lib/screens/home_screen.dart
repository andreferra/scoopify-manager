import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../services/user_context.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onSignOut;
  const HomeScreen({super.key, required this.onSignOut});

  @override
  Widget build(BuildContext context) {
    final user = UserProvider.of(context).user;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () async {
              await AuthService().signOut();
              UserProvider.of(context).clearUser();
              onSignOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Text(user != null ? 'Welcome ${user.email}' : 'No user'),
      ),
    );
  }
}
