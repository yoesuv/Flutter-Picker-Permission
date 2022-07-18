import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart';

class TakeFileState extends Equatable {
  final String? path;
  final PermissionStatus? permissionStatus;

  const TakeFileState({
    this.path = '',
    this.permissionStatus,
  });

  TakeFileState copyWith({
    String? path,
    PermissionStatus? permissionStatus,
  }) =>
      TakeFileState(
        path: path ?? this.path,
        permissionStatus: permissionStatus ?? this.permissionStatus,
      );

  @override
  List<Object?> get props => [
        path,
        permissionStatus,
      ];
}
