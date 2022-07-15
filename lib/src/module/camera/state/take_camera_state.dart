import 'dart:io';

import 'package:equatable/equatable.dart';

class TakeCameraState extends Equatable {
  final String? path;
  final File? file;

  const TakeCameraState({this.path = '', this.file});

  TakeCameraState copyWith({
    String? path,
    File? file,
  }) =>
      TakeCameraState(
        path: path ?? this.path,
        file: file ?? this.file,
      );

  @override
  List<Object?> get props => [path, file];
}
