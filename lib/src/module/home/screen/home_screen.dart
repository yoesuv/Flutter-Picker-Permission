import 'package:flutter/material.dart';
import 'package:flutter_picker/src/module/camera/screen/take_camera_screen.dart';
import 'package:flutter_picker/src/module/file/screen/take_file_screen.dart';
import 'package:flutter_picker/src/module/gallery/screen/take_gallery_screen.dart';
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
            MyButton(
              title: 'GALLERY',
              onPressed: () {
                Navigator.pushNamed(context, TakeGalleryScreen.routeName);
              },
            ),
            MyButton(
              title: 'CAMERA',
              onPressed: () {
                Navigator.pushNamed(context, TakeCameraScreen.routeName);
              },
            ),
            MyButton(
              title: 'FILE',
              onPressed: () {
                Navigator.pushNamed(context, TakeFileScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
