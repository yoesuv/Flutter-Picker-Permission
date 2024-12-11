import 'package:flutter/material.dart';
import 'package:flutter_picker/src/module/camera/screen/take_camera_screen.dart';
import 'package:flutter_picker/src/module/datetime/date_time_screen.dart';
import 'package:flutter_picker/src/module/download/download_file_screen.dart';
import 'package:flutter_picker/src/module/file/screen/take_file_screen.dart';
import 'package:flutter_picker/src/module/gallery/screen/take_gallery_screen.dart';
import 'package:flutter_picker/src/module/location/screen/location_screen.dart';
import 'package:flutter_picker/src/module/push_notification/push_notification_screen.dart';
import 'package:flutter_picker/src/module/record_audio/record_audio_screen.dart';
import 'package:flutter_picker/src/widgets/my_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  void _goToScreen(String route) {
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Picker & Permission'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyButton(
              title: 'GALLERY',
              onPressed: () => _goToScreen(TakeGalleryScreen.routeName),
            ),
            MyButton(
              title: 'CAMERA',
              onPressed: () => _goToScreen(TakeCameraScreen.routeName),
            ),
            MyButton(
              title: 'FILE',
              onPressed: () => _goToScreen(TakeFileScreen.routeName),
            ),
            MyButton(
              title: 'LOCATION',
              onPressed: () => _goToScreen(LocationScreen.routeName),
            ),
            MyButton(
              title: 'RECORD AUDIO',
              onPressed: () => _goToScreen(RecordAudioScreen.routeName),
            ),
            MyButton(
              title: 'NOTIFICATION',
              onPressed: () => _goToScreen(PushNotificationScreen.routeName),
            ),
            MyButton(
              title: 'DOWNLOAD FILE',
              onPressed: () => _goToScreen(DownloadFileScreen.routeName),
            ),
            MyButton(
              title: 'DATE TIME',
              onPressed: () => _goToScreen(DateTimeScreen.routeName),
            ),
          ],
        ),
      ),
    );
  }
}
