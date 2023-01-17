import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/src/module/camera/bloc/take_camera_bloc.dart';
import 'package:flutter_picker/src/module/camera/screen/take_camera_screen.dart';
import 'package:flutter_picker/src/module/file/bloc/take_file_bloc.dart';
import 'package:flutter_picker/src/module/file/screen/take_file_screen.dart';
import 'package:flutter_picker/src/module/gallery/bloc/take_gallery_bloc.dart';
import 'package:flutter_picker/src/module/gallery/screen/take_gallery_screen.dart';
import 'package:flutter_picker/src/module/home/screen/home_screen.dart';
import 'package:flutter_picker/src/module/location/screen/location_screen.dart';

class AppRoute {
  static Route<dynamic> routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (context) {
          return const HomeScreen();
        },
      );
    } else if (settings.name == TakeCameraScreen.routeName) {
      return MaterialPageRoute(
        builder: (context) {
          return BlocProvider(
            create: (context) => TakeCameraBloc(),
            child: const TakeCameraScreen(),
          );
        },
      );
    } else if (settings.name == TakeGalleryScreen.routeName) {
      return MaterialPageRoute(
        builder: (context) {
          return BlocProvider(
            create: (context) => TakeGalleryBloc(),
            child: const TakeGalleryScreen(),
          );
        },
      );
    } else if (settings.name == TakeFileScreen.routeName) {
      return MaterialPageRoute(
        builder: (context) {
          return BlocProvider(
            create: (context) => TakeFileBloc(),
            child: const TakeFileScreen(),
          );
        },
      );
    } else if (settings.name == LocationScreen.routeName) {
      return MaterialPageRoute(
        builder: (context) {
          return LocationScreen();
        },
      );
    } else {
      return MaterialPageRoute(
        builder: (context) {
          return const Scaffold(
            body: Center(
              child: Text('Page Not Found'),
            ),
          );
        },
      );
    }
  }
}
