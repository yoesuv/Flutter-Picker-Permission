import 'package:equatable/equatable.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

class DownloadFileState extends Equatable {
  const DownloadFileState({
    this.progress = 0,
    this.downloadTaskStatus = DownloadTaskStatus.undefined,
  });

  final int progress;
  final DownloadTaskStatus downloadTaskStatus;

  DownloadFileState copyWith({
    int? progress,
    DownloadTaskStatus? downloadTaskStatus,
  }) {
    return DownloadFileState(
      progress: progress ?? this.progress,
      downloadTaskStatus: downloadTaskStatus ?? this.downloadTaskStatus,
    );
  }

  @override
  List<Object?> get props => [
        progress,
        downloadTaskStatus,
      ];
}
