// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shopping_cart_app/service/auth/auth_exceptions.dart';
import 'package:shopping_cart_app/service/auth/auth_service.dart';

import '../../utils/constants.dart';
import '../../utils/dialogs/error_dialog.dart';
import '../../utils/widgets.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Login"), backgroundColor: const Color.fromARGB(255, 177, 195, 245)),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AuthTextField(
              controller: _email,
              hintText: "Email",
            ),
            AuthTextField(
              controller: _password,
              hintText: "Password",
              isPassoword: true,
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;

                try {
                  await AuthService.firebase().logIn(email: email, password: password);
                  final user = AuthService.firebase().currentUser;
                  if (user?.isEmailVerified ?? false) {
                    //user is verified
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      homeRoute,
                      (route) => false,
                    );
                  } else {
                    //user isn't verified
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      verifyEmailRoute,
                      (route) => false,
                    );
                  }
                } on UserNotFoundAuthException {
                  await showErrorDialog(
                    context,
                    "User not found.",
                  );
                } on WrongPasswordAuthException {
                  await showErrorDialog(
                    context,
                    "Wrong credentials.",
                  );
                } on GenericAuthException {
                  await showErrorDialog(
                    context,
                    "Authentication error.",
                  );
                }
              },
              style: getButtonStyle(),
              child: const Text("Login"),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  registerRoute,
                  (route) => false,
                );
              },
              style: getButtonStyle(),
              child: const Text("Not registered? \n Register here!"),
            ),
          ],
        ),
      ),
    );
  }
}
