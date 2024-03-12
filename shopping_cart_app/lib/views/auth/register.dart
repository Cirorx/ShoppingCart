// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shopping_cart_app/service/auth/auth_exceptions.dart';
import 'package:shopping_cart_app/service/auth/auth_service.dart';

import '../../utils/constants.dart';
import '../../utils/dialogs/error_dialog.dart';
import '../../utils/widgets.dart';

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
          ElevatedButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;

              try {
                await AuthService.firebase()
                    .createUser(email: email, password: password);

                //now that the user was successfully created, we need to verify it
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
            style: getButtonStyle(),
            child: const Text("Register"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                loginRoute,
                (route) => false,
              );
            },
            style: getButtonStyle(),
            child: const Text("Already registered? Login here."),
          ),
        ],
      ),
    );
  }
}
