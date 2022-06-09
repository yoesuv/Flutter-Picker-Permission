import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Picker'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MaterialButton(
              minWidth: 200,
              onPressed: () {},
              child: Text(
                'CHOOSE FILE',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.deepPurple,
            ),
            MaterialButton(
              minWidth: 200,
              onPressed: () {},
              child: Text(
                'TAKE PHOTO',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.deepPurple,
            ),
          ],
        ),
      ),
    );
  }
}
