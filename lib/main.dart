import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'screens/sign_in_screen.dart';
import 'screens/sign_up_screen.dart';
import 'screens/home_screen.dart';
import 'services/user_context.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final userNotifier = UserNotifier();
  runApp(UserProvider(notifier: userNotifier, child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _showSignUp = false;

  void _handleSignOut() {
    setState(() {
      _showSignUp = false;
    });
  }

  void _toggleScreen() {
    setState(() {
      _showSignUp = !_showSignUp;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = UserProvider.of(context).user;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: user != null
          ? HomeScreen(onSignOut: _handleSignOut)
          : _showSignUp
              ? SignUpScreen(onSignInTap: _toggleScreen)
              : SignInScreen(onSignUpTap: _toggleScreen),
    );
  }
}
