import 'package:flutter/material.dart';
import 'package:zoom/data/services/auth/auth_services.dart';
import 'package:zoom/presentation/routes.dart';
import 'package:zoom/presentation/screens/auth/login.dart';
import 'package:zoom/presentation/screens/auth/verify.dart';
import 'package:zoom/presentation/screens/notes/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AuthServices.firebase().intialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bloc Notes',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const BuilderScreen(),
      routes: {
        loginroute: (context) => const LoginScreen(),
      },
    );
  }
}

class BuilderScreen extends StatelessWidget {
  const BuilderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthServices.firebase().intialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthServices.firebase().currentUser;
            if (user != null) {
              if (user.isEmailVerified) {
                return const HomeScreen();
              } else {
                return const VerifyScreen();
              }
            } else {
              return const LoginScreen();
            }
          default:
            return const Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }
}
