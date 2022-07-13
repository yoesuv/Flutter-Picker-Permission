import 'package:equatable/equatable.dart';

abstract class TakeGalleryEvent extends Equatable {}

class TakeGalleryOpenEvent extends TakeGalleryEvent {
  @override
  List<Object?> get props => [];
}
