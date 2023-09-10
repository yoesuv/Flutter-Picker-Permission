import 'package:equatable/equatable.dart';

abstract class DownloadFileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class DownloadFileStartAndroidEvent extends DownloadFileEvent {}

class DownloadFileStartIOSEvent extends DownloadFileEvent {}