import 'package:flutter/material.dart';
import 'package:shopping_cart_app/service/auth/auth_service.dart';

import '../../utils/constants.dart';
import '../../utils/widgets.dart';

class VerifiyEmailView extends StatefulWidget {
  const VerifiyEmailView({super.key});

  @override
  State<VerifiyEmailView> createState() => _VerifiyEmailViewState();
}

class _VerifiyEmailViewState extends State<VerifiyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Email verification"),
      ),
      body: Column(
        children: [
          const Text("We've sent you a verification email, please check your inbox."),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute,
                (route) => false,
              );
            },
            style: getButtonStyle(),
            child: const Text("Haven't received an email yet? Re-send email."),
          ),
          ElevatedButton(
            onPressed: () async {
              await AuthService.firebase().logOut();
              Navigator.of(context).pushNamedAndRemoveUntil(registerRoute, (route) => false);
            },
            style: getButtonStyle(),
            child: const Text("Restart."),
          ),
        ],
      ),
    );
  }
}
