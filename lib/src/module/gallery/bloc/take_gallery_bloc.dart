import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/src/module/gallery/event/take_gallery_event.dart';
import 'package:flutter_picker/src/module/gallery/state/take_gallery_state.dart';

class TakeGalleryBloc extends Bloc<TakeGalleryEvent, TakeGalleryState> {
  TakeGalleryBloc() : super(const TakeGalleryState()) {
    on<TakeGalleryOpenEvent>(_openGallery);
  }

  void _openGallery(
    TakeGalleryOpenEvent event,
    Emitter<TakeGalleryState> emit,
  ) {
    print('TakeGalleryBloc # open gallery');
  }
}
