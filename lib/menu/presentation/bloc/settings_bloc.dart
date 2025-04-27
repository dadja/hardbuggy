import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hardbuggy/menu/domain/entities/settings_entity.dart';
import 'package:hardbuggy/menu/domain/repositories/settings_repository.dart';

import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository repository;

  SettingsBloc({required this.repository})
      : super(const SettingsState(
          settings: SettingsEntity(isMusicMuted: false, isSoundMuted: false),
          isLoading: true,
        )) {
    on<LoadSettings>(_onLoadSettings);
    on<ToggleMusicMute>(_onToggleMusicMute);
    on<ToggleSoundMute>(_onToggleSoundMute);
  }

  Future<void> _onLoadSettings(
      LoadSettings event, Emitter<SettingsState> emit) async {
    emit(state.copyWith(isLoading: true));
    final settings = await repository.loadSettings();
    emit(state.copyWith(settings: settings, isLoading: false));
  }

  Future<void> _onToggleMusicMute(
      ToggleMusicMute event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.settings.copyWith(isMusicMuted: !state.settings.isMusicMuted);
    await repository.saveSettings(newSettings);
    emit(state.copyWith(settings: newSettings));
  }

  Future<void> _onToggleSoundMute(
      ToggleSoundMute event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.settings.copyWith(isSoundMuted: !state.settings.isSoundMuted);
    await repository.saveSettings(newSettings);
    emit(state.copyWith(settings: newSettings));
  }
}
