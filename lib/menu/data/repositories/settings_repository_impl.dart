import 'package:hardbuggy/menu/data/models/settings_model.dart';
import 'package:hardbuggy/menu/domain/entities/settings_entity.dart';
import 'package:hardbuggy/menu/domain/repositories/settings_repository.dart';
import 'package:hive/hive.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final Box<SettingsModel> _settingsBox;

  SettingsRepositoryImpl(this._settingsBox);

  @override
  Future<SettingsEntity> loadSettings() async {
    final model = _settingsBox.get('user_settings');
    if (model != null) {
      return model.toEntity();
    } else {
      // Default settings
      return const SettingsEntity(isMusicMuted: false, isSoundMuted: false);
    }
  }

  @override
  Future<void> saveSettings(SettingsEntity entity) async {
    await _settingsBox.put('user_settings', SettingsModel.fromEntity(entity)).then((success)=>print('savveeddd'));
  }
}
