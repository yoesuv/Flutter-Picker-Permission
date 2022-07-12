import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  const MyButton({Key? key, required this.title, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 200,
      onPressed: () => onPressed,
      color: Colors.deepPurple,
      child: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
