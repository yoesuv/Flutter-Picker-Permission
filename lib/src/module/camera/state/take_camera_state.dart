import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart';

class TakeCameraState extends Equatable {
  final String? path;
  final File? file;
  final PermissionStatus? permissionStatus;

  const TakeCameraState({
    this.path = '',
    this.file,
    this.permissionStatus,
  });

  TakeCameraState copyWith({
    String? path,
    File? file,
    PermissionStatus? permissionStatus,
  }) =>
      TakeCameraState(
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
