import 'package:flutter/material.dart';
import 'package:flutter_picker/src/widgets/my_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Picker'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyButton(title: 'GALLERY', onPressed: () {}),
            MyButton(title: 'CAMERA', onPressed: () {}),
            MyButton(title: 'FILE', onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
