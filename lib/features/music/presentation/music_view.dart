import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:workspace/shared_ui/widgets/liquid_glass.dart';
import '../domain/track_model.dart';
import 'providers/music_provider.dart';
import 'widgets/music_sidebar.dart';
import 'widgets/music_player_bar.dart';

class MusicView extends ConsumerStatefulWidget {
  const MusicView({super.key});

  @override
  ConsumerState<MusicView> createState() => _MusicViewState();
}

class _MusicViewState extends ConsumerState<MusicView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Background Gradient specific to music app (Apple Music style blur)
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF2A0826), // Deep purple/pink
                    Color(0xFF0F0518), // Darker tone
                    Colors.black,
                  ],
                ),
              ),
            ),
          ),
          
          Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    // Sidebar
                    const MusicSidebar(),
                    
                    // Main Content Area
                    Expanded(
                      child: ClipRRect(
                        child: LiquidGlass(
                          intensity: 0.1,
                          holographic: false,
                          child: _buildMainContent(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Bottom Player Bar
              const MusicPlayerBar(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.5),
                        blurRadius: 30,
                        offset: const Offset(0, 15),
                      )
                    ],
                    image: const DecorationImage(
                      image: NetworkImage(
                          'https://picsum.photos/seed/playlist/400/400'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 32),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Playlist',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Elite Portfolio VIBES',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 48,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -1,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Curated for coding and deep focus. 4 songs, 24 minutes.',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.7),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              ref.read(musicProvider.notifier).togglePlayPause();
                            },
                            icon: Icon(
                              ref.watch(musicProvider).isPlaying ? LucideIcons.pause : LucideIcons.play,
                              color: Colors.black,
                            ),
                            label: Text(
                              ref.watch(musicProvider).isPlaying ? 'Pause' : 'Play',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pinkAccent,
                              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(LucideIcons.shuffle, color: Colors.white70),
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.white.withValues(alpha: 0.1),
                              padding: const EdgeInsets.all(16),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              children: [
                const Divider(color: Colors.white24),
                const SizedBox(height: 16),
                _buildTrackList(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTrackList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: elitePlaylist.length,
      itemBuilder: (context, index) {
        final track = elitePlaylist[index];
        final state = ref.watch(musicProvider);
        final isPlayingThisTrack = state.currentTrack?.id == track.id;
        
        return Material(
          color: Colors.transparent,
          child: InkWell(
            onDoubleTap: () {
               ref.read(musicProvider.notifier).playTrack(track);
            },
            borderRadius: BorderRadius.circular(8),
            splashColor: Colors.pinkAccent.withValues(alpha: 0.2),
            highlightColor: Colors.white.withValues(alpha: 0.05),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isPlayingThisTrack ? Colors.white.withValues(alpha: 0.1) : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 32,
                    child: isPlayingThisTrack && state.isPlaying
                        ? const Icon(LucideIcons.barChart2, color: Colors.pinkAccent, size: 16)
                        : Text(
                            '${index + 1}',
                            style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 13),
                          ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      image: DecorationImage(
                        image: NetworkImage(track.coverUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          track.title,
                          style: TextStyle(
                            color: isPlayingThisTrack ? Colors.pinkAccent : Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          track.artist,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.6),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    track.album,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(width: 60),
                  Text(
                    _formatDuration(track.duration),
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
