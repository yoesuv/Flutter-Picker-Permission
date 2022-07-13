import 'package:equatable/equatable.dart';

abstract class TakeGalleryEvent extends Equatable {}

class TakeGalleryOpen extends TakeGalleryEvent {
  @override
  List<Object?> get props => [];
}
