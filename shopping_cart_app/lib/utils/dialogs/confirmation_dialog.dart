import 'package:flutter/material.dart';

import 'generic_dialog.dart';

Future<bool> confirmationDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: "Remove product",
    content: "Are you sure you want to remove this product?",
    optionsBuilder: () => {
      "Cancel": false,
      "Remove": true,
    },
  ).then(
    (value) => value ?? false,
  );
}
