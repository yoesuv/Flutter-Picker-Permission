import 'package:flutter/material.dart';

void showErrorSnackBar(BuildContext context, String text) {
  final snackBar = SnackBar(
    backgroundColor: Colors.red[600],
    content: Row(
      children: [
        const Icon(Icons.info_outlined, color: Colors.white),
        const SizedBox(width: 16),
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
