import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/track_model.dart';

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

class MusicNotifier extends StateNotifier<MusicState> {
  final AudioPlayer _player = AudioPlayer();
  final List<Track> _playlist = elitePlaylist;

  MusicNotifier() : super(const MusicState()) {
    _init();
  }

  void _init() {
    _player.onPositionChanged.listen((pos) {
      if (!mounted) return;
      state = state.copyWith(position: pos);
    });

    _player.onPlayerComplete.listen((_) {
      if (!mounted) return;
      playNext();
    });
    
    // Set default volume
    _player.setVolume(state.volume);
  }

  Future<void> playTrack(Track track) async {
    state = state.copyWith(currentTrack: track, isPlaying: true, position: Duration.zero);
    await _player.play(UrlSource(track.audioUrl));
  }

  Future<void> togglePlayPause() async {
    if (state.currentTrack == null && _playlist.isNotEmpty) {
      await playTrack(_playlist.first);
      return;
    }

    if (state.isPlaying) {
      await _player.pause();
      state = state.copyWith(isPlaying: false);
    } else {
      await _player.resume();
      state = state.copyWith(isPlaying: true);
    }
  }

  Future<void> seek(Duration position) async {
    await _player.seek(position);
    state = state.copyWith(position: position);
  }

  Future<void> setVolume(double volume) async {
    await _player.setVolume(volume);
    state = state.copyWith(volume: volume);
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

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}

final musicProvider = StateNotifierProvider<MusicNotifier, MusicState>((ref) {
  return MusicNotifier();
});
