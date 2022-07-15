import 'package:equatable/equatable.dart';

class TakeFileState extends Equatable {
  final String? path;

  const TakeFileState({this.path = ''});

  TakeFileState copyWith({
    String? path,
  }) =>
      TakeFileState(
        path: path ?? this.path,
      );

  @override
  List<Object?> get props => [path];
}
