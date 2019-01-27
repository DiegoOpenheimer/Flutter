import 'package:audioplayers/audio_cache.dart';

class AudioPlayer {

  String prefix;
  String name;
  AudioCache _audioCache;


  AudioPlayer(this.name, { this.prefix = '' }) {
   _audioCache = AudioCache(prefix: prefix);
  }

  void play() {
    _audioCache.play(name);
  }

  void clear() {
    _audioCache.clear(name);
  }

}