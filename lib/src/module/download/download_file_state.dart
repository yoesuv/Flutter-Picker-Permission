import 'package:equatable/equatable.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadFileState extends Equatable {
  const DownloadFileState({
    this.progress = 0,
    this.downloadTaskStatus = DownloadTaskStatus.undefined,
    this.permissionStatus,
  });

  final int progress;
  final DownloadTaskStatus downloadTaskStatus;
  final PermissionStatus? permissionStatus;

  DownloadFileState copyWith({
    int? progress,
    DownloadTaskStatus? downloadTaskStatus,
    PermissionStatus? permissionStatus,
  }) {
    return DownloadFileState(
      progress: progress ?? this.progress,
      downloadTaskStatus: downloadTaskStatus ?? this.downloadTaskStatus,
      permissionStatus: permissionStatus,
    );
  }

  @override
  List<Object?> get props => [progress, downloadTaskStatus, permissionStatus];
}
