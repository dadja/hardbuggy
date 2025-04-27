class SettingsEntity {
  final bool isMusicMuted;
  final bool isSoundMuted;

  const SettingsEntity({
    required this.isMusicMuted,
    required this.isSoundMuted,
  });

  SettingsEntity copyWith({
    bool? isMusicMuted,
    bool? isSoundMuted,
  }) {
    return SettingsEntity(
      isMusicMuted: isMusicMuted ?? this.isMusicMuted,
      isSoundMuted: isSoundMuted ?? this.isSoundMuted,
    );
  }

  @override
  String toString() {
    return 'SettingsEntity{isMusicMuted: $isMusicMuted, isSoundMuted: $isSoundMuted}';
  }
}
