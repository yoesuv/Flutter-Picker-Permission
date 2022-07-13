import 'dart:io';

import 'package:equatable/equatable.dart';

class TakeGalleryState extends Equatable {
  final String? path;
  final File? file;

  const TakeGalleryState({
    this.path = '',
    this.file,
  });

  TakeGalleryState copyWith({
    String? path,
    File? file,
  }) =>
      TakeGalleryState(
        path: path ?? this.path,
        file: file ?? this.file,
      );

  @override
  List<Object?> get props => [
        path,
        file,
      ];
}
