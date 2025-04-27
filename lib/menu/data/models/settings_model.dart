import 'package:hardbuggy/menu/domain/entities/settings_entity.dart';
import 'package:hive/hive.dart';

part 'settings_model.g.dart';

@HiveType(typeId: 0)
class SettingsModel {
  @HiveField(0)
  final bool isMusicMuted;

  @HiveField(1)
  final bool isSoundMuted;

  SettingsModel({
    required this.isMusicMuted,
    required this.isSoundMuted,
  });

  factory SettingsModel.fromEntity(SettingsEntity entity) {
    return SettingsModel(
      isMusicMuted: entity.isMusicMuted,
      isSoundMuted: entity.isSoundMuted,
    );
  }

  SettingsEntity toEntity() {
    return SettingsEntity(
      isMusicMuted: isMusicMuted,
      isSoundMuted: isSoundMuted,
    );
  }
}
