import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  final bool isLoading;
  const MyButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 200,
      onPressed: isLoading ? () {} : () => onPressed(),
      color: Colors.deepPurple,
      child: isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
          : Text(title, style: const TextStyle(color: Colors.white)),
    );
  }
}
