import 'package:hardbuggy/menu/domain/entities/settings_entity.dart';

abstract class SettingsRepository {
  Future<SettingsEntity> loadSettings();

  Future<void> saveSettings(SettingsEntity entity);
}
