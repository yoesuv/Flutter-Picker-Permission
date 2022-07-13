import 'package:equatable/equatable.dart';

class TakeGalleryState extends Equatable {
  final String? path;

  const TakeGalleryState({this.path});

  TakeGalleryState copyWith({
    String? path,
  }) =>
      TakeGalleryState(
        path: path ?? this.path,
      );

  @override
  List<Object?> get props => [path];
}
