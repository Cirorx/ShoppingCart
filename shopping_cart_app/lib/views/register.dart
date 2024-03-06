// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shopping_cart_app/service/auth/auth_exceptions.dart';
import 'package:shopping_cart_app/service/auth/auth_service.dart';

import '../utils/constants.dart';
import '../utils/dialogs/error.dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
    const snackBar = SnackBar(
      content: Text('An email has been sent!'),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: true,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: "Email"),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(hintText: "Password"),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;

              try {
                await AuthService.firebase()
                    .createUser(email: email, password: password);

                //now that the user was successfully created, we need to verify it
                // ignore: unused_local_variable
                final user = AuthService.firebase().currentUser;
                await AuthService.firebase().sendEmailVerification();

                //little snackbar confirmation
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } on WeakPasswordAuthException {
                await showErrorDialog(
                  context,
                  "Weak passoword.",
                );
              } on EmailAlreadyInUseAuthException {
                await showErrorDialog(
                  context,
                  "Email is already in use.",
                );
              } on InvalidEmailAuthException {
                await showErrorDialog(
                  context,
                  "Invalid email was entered.",
                );
              } on GenericAuthException {
                await showErrorDialog(
                  context,
                  "Registration error.",
                );
              }
            },
            child: const Text("Register"),
          ),
          TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  loginRoute,
                  (route) => false,
                );
              },
              child: const Text("Already registered? Login here."))
        ],
      ),
    );
  }
}
