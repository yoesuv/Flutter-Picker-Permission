import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/src/module/record_audio/player_audio/player_audio_event.dart';
import 'package:flutter_picker/src/module/record_audio/player_audio/player_audio_state.dart';

class PlayerAudioBloc extends Bloc<PlayerAudioEvent, PlayerAudioState> {
  PlayerAudioBloc() : super(const PlayerAudioState()) {
    on<PlayerAudioInitEvent>(_onInit);
  }

  void _onInit(PlayerAudioInitEvent event, Emitter<PlayerAudioState> emit) {
    emit(state.copyWith(
      path: event.path,
    ));
  }
}
