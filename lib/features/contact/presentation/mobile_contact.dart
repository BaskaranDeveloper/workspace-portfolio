import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:workspace/shared_ui/theme/app_colors.dart';
import 'package:workspace/shared_ui/widgets/liquid_glass.dart';
import 'package:url_launcher/url_launcher.dart';

class MobileContact extends StatelessWidget {
  const MobileContact({super.key});

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.black,
            expandedHeight: 120,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'COMMAND CENTER',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 4,
                ),
              ),
              centerTitle: true,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildSocialSection(),
                const SizedBox(height: 48),
                _buildFormSection(context),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialSection() {
    return Column(
      children: [
        _MobileSocialNode(
          icon: LucideIcons.mail,
          label: 'EMAIL_SECURE',
          value: 'baskarandeveloper1423@gmail.com',
          accentColor: Colors.blueAccent,
          onTap: () => _launchUrl('mailto:baskarandeveloper1423@gmail.com'),
        ),
        const SizedBox(height: 16),
        _MobileSocialNode(
          icon: FontAwesomeIcons.linkedin,
          label: 'LINKEDIN_PROF',
          value: 'baskaran-m',
          accentColor: const Color(0xFF0077B5),
          onTap: () => _launchUrl('https://linkedin.com/in/baskaran-m'),
        ),
        const SizedBox(height: 16),
        _MobileSocialNode(
          icon: FontAwesomeIcons.github,
          label: 'GITHUB_REPOS',
          value: 'BaskaranDeveloper',
          accentColor: Colors.purpleAccent,
          onTap: () => _launchUrl('https://github.com/BaskaranDeveloper'),
        ),
      ],
    );
  }

  Widget _buildFormSection(BuildContext context) {
    return LiquidGlass(
      intensity: 0.8,
      borderRadius: 16,
      padding: const EdgeInsets.all(24),
      accentColor: AppColors.terminalBlue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.terminal, color: AppColors.terminalBlue, size: 14),
              const SizedBox(width: 8),
              Text(
                'MESSAGE_TERMINAL',
                style: TextStyle(
                  color: AppColors.terminalBlue,
                  fontSize: 8,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          _MobileField(label: 'IDENTIFIER', hint: 'Your Name'),
          const SizedBox(height: 24),
          _MobileField(label: 'COORDINATES', hint: 'Email'),
          const SizedBox(height: 24),
          _MobileField(label: 'DATA', hint: 'Message', maxLines: 4),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Transmission Successful.')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.terminalBlue,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'SEND TRANSMISSION',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MobileSocialNode extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color accentColor;
  final VoidCallback onTap;

  const _MobileSocialNode({
    required this.icon,
    required this.label,
    required this.value,
    required this.accentColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return LiquidGlass(
      intensity: 0.7,
      borderRadius: 12,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      accentColor: accentColor,
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon, color: accentColor, size: 18),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      color: accentColor.withValues(alpha: 0.6),
                      fontSize: 8,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                    ),
                  ),
                  Text(
                    value,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Icon(LucideIcons.arrowUpRight, size: 12, color: Colors.white24),
          ],
        ),
      ),
    );
  }
}

class _MobileField extends StatelessWidget {
  final String label;
  final String hint;
  final int maxLines;

  const _MobileField({required this.label, required this.hint, this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white38,
            fontSize: 8,
            fontWeight: FontWeight.w900,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          maxLines: maxLines,
          style: const TextStyle(color: Colors.white, fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white12, fontSize: 14),
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.05),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.terminalBlue),
            ),
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      ],
    );
  }
}
