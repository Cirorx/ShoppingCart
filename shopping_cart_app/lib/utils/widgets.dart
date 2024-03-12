import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget infoWidget(String label) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Text(
      label,
      style: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 17,
      ),
    ),
  );
}

ButtonStyle getButtonStyle() {
  return ButtonStyle(
    textStyle: MaterialStateProperty.all<TextStyle>(
      const TextStyle(
        color: Colors.white,
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
    ),
    backgroundColor: MaterialStateProperty.all<Color>(
      const Color.fromARGB(255, 177, 195, 245),
    ),
    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 24.0,
      ),
    ),
    shape: MaterialStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
    overlayColor: MaterialStateProperty.all<Color>(
      Colors.blueAccent.withOpacity(0.5),
    ),
  );
}

void showToast(String text) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.black45,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassoword;

  const AuthTextField({
    required this.controller,
    required this.hintText,
    this.isPassoword = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassoword,
      enableSuggestions: !isPassoword,
      autocorrect: !isPassoword,
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(
        color: Colors
            .black, // Use the appropriate color from your design guidelines
        fontSize: 16.0, // Use the appropriate font size
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.grey, // Use the appropriate hint text color
        ),
      ),
    );
  }
}
