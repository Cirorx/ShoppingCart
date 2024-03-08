import 'package:flutter/material.dart';

Widget infoWidget(String label, String value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 3),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(value),
      ],
    ),
  );
}
