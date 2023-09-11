import 'package:equatable/equatable.dart';

class DownloadFileState extends Equatable {
  const DownloadFileState({
    this.progress = 0,
  });

  final int progress;

  DownloadFileState copyWith({
    int? progress,
  }) {
    return DownloadFileState(
      progress: progress ?? this.progress,
    );
  }

  @override
  List<Object?> get props => [
        progress,
      ];
}
