import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/src/module/camera/bloc/take_camera_bloc.dart';
import 'package:flutter_picker/src/module/camera/screen/take_camera_screen.dart';
import 'package:flutter_picker/src/module/file/bloc/take_file_bloc.dart';
import 'package:flutter_picker/src/module/file/screen/take_file_screen.dart';
import 'package:flutter_picker/src/module/gallery/bloc/take_gallery_bloc.dart';
import 'package:flutter_picker/src/module/gallery/screen/take_gallery_screen.dart';
import 'package:flutter_picker/src/module/home/screen/home_screen.dart';
import 'package:flutter_picker/src/module/location/bloc/location_bloc.dart';
import 'package:flutter_picker/src/module/location/screen/location_screen.dart';
import 'package:flutter_picker/src/module/push_notification/push_notification_bloc.dart';
import 'package:flutter_picker/src/module/push_notification/push_notification_screen.dart';
import 'package:flutter_picker/src/module/record_audio/record_audio_bloc.dart';
import 'package:flutter_picker/src/module/record_audio/record_audio_screen.dart';

class AppRoute {
  static Route<dynamic> routes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) {
            return const HomeScreen();
          },
        );
      case TakeCameraScreen.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => TakeCameraBloc(),
              child: const TakeCameraScreen(),
            );
          },
        );
      case TakeGalleryScreen.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => TakeGalleryBloc(),
              child: const TakeGalleryScreen(),
            );
          },
        );
      case TakeFileScreen.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => TakeFileBloc(),
              child: const TakeFileScreen(),
            );
          },
        );
      case LocationScreen.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => LocationBloc(),
              child: const LocationScreen(),
            );
          },
        );
      case RecordAudioScreen.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => RecordAudioBloc(),
              child: const RecordAudioScreen(),
            );
          },
        );
      case PushNotificationScreen.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => PushNotificationBloc(),
              child: const PushNotificationScreen(),
            );
          },
        );
      default:
        return MaterialPageRoute(
          builder: (context) {
            return const Scaffold(
              body: Center(
                child: Text(
                  'Page Not Found',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                  ),
                ),
              ),
            );
          },
        );
    }
  }
}
