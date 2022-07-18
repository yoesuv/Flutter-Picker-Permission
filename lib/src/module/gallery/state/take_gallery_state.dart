import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart';

class TakeGalleryState extends Equatable {
  final String? path;
  final File? file;
  final PermissionStatus? permissionStatus;

  const TakeGalleryState({
    this.path = '',
    this.file,
    this.permissionStatus,
  });

  TakeGalleryState copyWith({
    String? path,
    File? file,
    PermissionStatus? permissionStatus,
  }) =>
      TakeGalleryState(
        path: path ?? this.path,
        file: file ?? this.file,
        permissionStatus: permissionStatus,
      );

  @override
  List<Object?> get props => [
        path,
        file,
        permissionStatus,
      ];
}
