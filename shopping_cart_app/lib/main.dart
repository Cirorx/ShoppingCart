import 'package:flutter/material.dart';
import 'package:shopping_cart_app/views/home.dart';
import 'service/auth/auth_service.dart';
import 'utils/constants.dart';
import 'views/login.dart';
import 'views/register.dart';
import 'views/verify_email.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'A simple Shopping Cart :)',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const HomePage(),
      routes: {
        homeRoute: (context) => const HomeScreen(),
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        verifyEmailRoute: (context) => const VerifiyEmailView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;

            if (user == null) {
              //Go to login
              return const LoginView();
            } else if (!user.isEmailVerified) {
              //Offer the user to verify email
              return const VerifiyEmailView();
            } else {
              //Home page of the app
              return const HomeScreen();
            }

          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
