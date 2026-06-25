import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class MusicSidebar extends StatelessWidget {
  const MusicSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Colors.black.withValues(alpha: 0.3),
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        children: [
          Row(
            children: [
              const Icon(LucideIcons.music, color: Colors.pinkAccent, size: 24),
              const SizedBox(width: 12),
              const Text(
                'Music',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          
          _buildSectionTitle('Library'),
          _buildNavItem(LucideIcons.clock, 'Recently Added', false),
          _buildNavItem(LucideIcons.mic, 'Artists', false),
          _buildNavItem(LucideIcons.disc, 'Albums', false),
          _buildNavItem(LucideIcons.listMusic, 'Songs', true),
          
          const SizedBox(height: 24),
          _buildSectionTitle('Playlists'),
          _buildNavItem(LucideIcons.folder, 'All Playlists', false),
          _buildNavItem(LucideIcons.list, 'Elite Portfolio VIBES', true),
          _buildNavItem(LucideIcons.list, 'Coding Focus', false),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          color: Colors.white54,
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String title, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white.withValues(alpha: 0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Icon(icon, color: isSelected ? Colors.pinkAccent : Colors.white70, size: 16),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.white70,
                    fontSize: 13,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
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
