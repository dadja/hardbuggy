abstract class AudioRepository {
  Future<void> playBackgroundMusic();

  Future<void> stopBackgroundMusic();

  Future<void> playSfx(String fileName);

  Future<void> muteAll();

  Future<void> unMuteAll();
}
