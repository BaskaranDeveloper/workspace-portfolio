import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:workspace/shared_ui/widgets/liquid_glass.dart';
import '../providers/music_provider.dart';

class MusicPlayerBar extends ConsumerWidget {
  const MusicPlayerBar({super.key});

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(musicProvider);
    final notifier = ref.read(musicProvider.notifier);

    final track = state.currentTrack;
    final progress = track != null && track.duration.inMilliseconds > 0
        ? state.position.inMilliseconds / track.duration.inMilliseconds
        : 0.0;

    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.8),
        border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.1))),
      ),
      child: ClipRRect(
        child: LiquidGlass(
          intensity: 0.5,
          showGrain: true,
          holographic: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                // Now Playing Info
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      if (track != null)
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: NetworkImage(track.coverUrl),
                              fit: BoxFit.cover,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.pinkAccent.withValues(alpha: 0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                        )
                      else
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(LucideIcons.music, color: Colors.white24),
                        ),
                      const SizedBox(width: 16),
                      if (track != null)
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                track.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                track.artist,
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.6),
                                  fontSize: 12,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),

                // Controls & Scrubber
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(LucideIcons.skipBack, color: Colors.white, size: 20),
                            onPressed: () => notifier.playPrevious(),
                          ),
                          const SizedBox(width: 16),
                          GestureDetector(
                            onTap: () => notifier.togglePlayPause(),
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                state.isPlaying ? LucideIcons.pause : LucideIcons.play,
                                color: Colors.black,
                                size: 20,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          IconButton(
                            icon: const Icon(LucideIcons.skipForward, color: Colors.white, size: 20),
                            onPressed: () => notifier.playNext(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            _formatDuration(state.position),
                            style: const TextStyle(color: Colors.white54, fontSize: 10),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: SliderTheme(
                              data: SliderThemeData(
                                trackHeight: 4,
                                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                                overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
                                activeTrackColor: Colors.pinkAccent,
                                inactiveTrackColor: Colors.white.withValues(alpha: 0.1),
                                thumbColor: Colors.white,
                              ),
                              child: Slider(
                                value: progress.clamp(0.0, 1.0),
                                onChanged: (val) {
                                  if (track != null) {
                                    final newPosMs = val * track.duration.inMilliseconds;
                                    notifier.seek(Duration(milliseconds: newPosMs.toInt()));
                                  }
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            track != null ? _formatDuration(track.duration) : '0:00',
                            style: const TextStyle(color: Colors.white54, fontSize: 10),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Volume Controls
                Expanded(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(LucideIcons.volume1, color: Colors.white54, size: 16),
                      SizedBox(
                        width: 100,
                        child: SliderTheme(
                          data: SliderThemeData(
                            trackHeight: 4,
                            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                            activeTrackColor: Colors.white54,
                            inactiveTrackColor: Colors.white.withValues(alpha: 0.1),
                            thumbColor: Colors.white,
                          ),
                          child: Slider(
                            value: state.volume.clamp(0.0, 1.0),
                            onChanged: (val) => notifier.setVolume(val),
                          ),
                        ),
                      ),
                      const Icon(LucideIcons.volume2, color: Colors.white54, size: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
