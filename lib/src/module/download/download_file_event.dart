import 'package:equatable/equatable.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

abstract class DownloadFileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class DownloadFileInitEvent extends DownloadFileEvent {}

class DownloadFileStartAndroidEvent extends DownloadFileEvent {}

class DownloadFileStartIOSEvent extends DownloadFileEvent {}

class DownloadFileUpdateEvent extends DownloadFileEvent {
  final DownloadTaskStatus downloadTaskStatus;
  final int progress;
  DownloadFileUpdateEvent({
    required this.downloadTaskStatus,
    required this.progress,
  });
  @override
  List<Object?> get props => [downloadTaskStatus, progress];
}
