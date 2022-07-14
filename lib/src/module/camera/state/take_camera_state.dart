import 'package:equatable/equatable.dart';

class TakeCameraState extends Equatable {
  final String? path;

  const TakeCameraState({this.path = ''});

  @override
  List<Object?> get props => [path];
}
