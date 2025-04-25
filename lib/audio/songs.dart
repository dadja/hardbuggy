const Set<Song> songs = {
  Song('music.ogg', 'Music', artist: 'Music Game'),
  Song('music2.ogg', 'Music', artist: 'Music Game'),
  Song('music3.ogg', 'Music', artist: 'Music Game'),
};

class Song {
  final String filename;

  final String name;

  final String? artist;

  const Song(this.filename, this.name, {this.artist});

  @override
  String toString() => 'Song<$filename>';
}
