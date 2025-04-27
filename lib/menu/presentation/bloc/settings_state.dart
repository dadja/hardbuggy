import 'package:hardbuggy/menu/domain/entities/settings_entity.dart';

class SettingsState {
  final SettingsEntity settings;
  final bool isLoading;

  const SettingsState({required this.settings, this.isLoading = false});

  SettingsState copyWith({SettingsEntity? settings, bool? isLoading}) {
    return SettingsState(
      settings: settings ?? this.settings,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
