import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import '../../domain/track_model.dart';

class MusicState {
  final Track? currentTrack;
  final bool isPlaying;
  final Duration position;
  final double volume;

  const MusicState({
    this.currentTrack,
    this.isPlaying = false,
    this.position = Duration.zero,
    this.volume = 0.8,
  });

  MusicState copyWith({
    Track? currentTrack,
    bool? isPlaying,
    Duration? position,
    double? volume,
  }) {
    return MusicState(
      currentTrack: currentTrack ?? this.currentTrack,
      isPlaying: isPlaying ?? this.isPlaying,
      position: position ?? this.position,
      volume: volume ?? this.volume,
    );
  }
}

class MusicNotifier extends Notifier<MusicState> {
  late final AudioPlayer _player;
  final List<Track> _playlist = elitePlaylist;

  @override
  MusicState build() {
    _player = AudioPlayer();
    
    ref.onDispose(() {
      _player.dispose();
    });

    _player.onPositionChanged.listen((pos) {
      state = state.copyWith(position: pos);
    });

    _player.onPlayerComplete.listen((_) {
      playNext();
    });
    
    // Removed synchronous setVolume on startup for web compatibility.
    // Web audio nodes often crash if properties are set before a track is played.
    
    return const MusicState(volume: 0.8);
  }

  Future<void> playTrack(Track track) async {
    state = state.copyWith(currentTrack: track, isPlaying: true, position: Duration.zero);
    try {
      await _player.play(UrlSource(track.audioUrl));
    } catch (e) {
      debugPrint('Audio playback error: $e');
      state = state.copyWith(isPlaying: false);
    }
  }

  Future<void> togglePlayPause() async {
    if (state.currentTrack == null && _playlist.isNotEmpty) {
      await playTrack(_playlist.first);
      return;
    }

    try {
      if (state.isPlaying) {
        await _player.pause();
        state = state.copyWith(isPlaying: false);
      } else {
        await _player.resume();
        state = state.copyWith(isPlaying: true);
      }
    } catch (e) {
      debugPrint('Audio toggle error: $e');
      state = state.copyWith(isPlaying: false);
    }
  }

  Future<void> seek(Duration position) async {
    try {
      await _player.seek(position);
      state = state.copyWith(position: position);
    } catch (e) {
      debugPrint('Audio seek error: $e');
    }
  }

  Future<void> setVolume(double volume) async {
    try {
      await _player.setVolume(volume);
      state = state.copyWith(volume: volume);
    } catch (e) {
      debugPrint('Audio volume error: $e');
    }
  }

  void playNext() {
    if (state.currentTrack == null) return;
    final currentIndex = _playlist.indexWhere((t) => t.id == state.currentTrack!.id);
    if (currentIndex < _playlist.length - 1) {
      playTrack(_playlist[currentIndex + 1]);
    } else {
      playTrack(_playlist.first); // loop back
    }
  }

  void playPrevious() {
    if (state.currentTrack == null) return;
    final currentIndex = _playlist.indexWhere((t) => t.id == state.currentTrack!.id);
    if (currentIndex > 0) {
      playTrack(_playlist[currentIndex - 1]);
    } else {
      playTrack(_playlist.last); // loop to end
    }
  }
}

final musicProvider = NotifierProvider<MusicNotifier, MusicState>(() {
  return MusicNotifier();
});
