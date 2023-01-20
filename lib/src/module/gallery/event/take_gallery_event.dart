import 'package:equatable/equatable.dart';

abstract class TakeGalleryEvent extends Equatable {}

class TakeGalleryOpenAndroidEvent extends TakeGalleryEvent {
  @override
  List<Object?> get props => [];
}

class TakeGalleryOpenIosEvent extends TakeGalleryEvent {
  @override
  List<Object?> get props => [];
}