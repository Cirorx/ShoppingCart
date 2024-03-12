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

ButtonStyle getCartButtonStyle() {
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

void showCartToast(String productTitle, bool added) {
  String action = added ? 'added' : 'removed';
  Fluttertoast.showToast(
    msg: '$productTitle was $action from your cart.',
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.black45,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
