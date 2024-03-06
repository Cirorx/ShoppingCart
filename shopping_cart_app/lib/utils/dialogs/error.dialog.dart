//error dialog only notifies the user about an error,
//and offers a ok button for confirmation

import 'package:flutter/cupertino.dart';

import 'generic_dialog.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog<void>(
    context: context,
    title: "An error occurred.",
    content: text,
    optionsBuilder: () => {
      "Ok": null,
    },
  );
}
