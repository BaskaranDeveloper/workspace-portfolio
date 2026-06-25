import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:workspace/shared_ui/theme/app_colors.dart';
import 'package:workspace/shared_ui/widgets/liquid_glass.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactView extends StatefulWidget {
  const ContactView({super.key});

  @override
  State<ContactView> createState() => _ContactViewState();
}

class _ContactViewState extends State<ContactView>
    with SingleTickerProviderStateMixin {
  late AnimationController _entranceController;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..forward();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 40),
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 128,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Left Panel: Social Hub
                        Expanded(
                          flex: 4,
                          child: _buildSocialHub(),
                        ),
                        const SizedBox(width: 48),
                        // Right Panel: Message Terminal
                        Expanded(
                          flex: 6,
                          child: _buildMessageTerminal(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        const Text(
          'COMMS_ESTABLISHED_V9.4',
          style: TextStyle(
            color: Colors.white24,
            fontSize: 10,
            fontWeight: FontWeight.w900,
            letterSpacing: 4,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Command Center',
          style: TextStyle(
            color: Colors.white,
            fontSize: 56,
            fontWeight: FontWeight.w900,
            letterSpacing: -3,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 80,
          height: 4,
          decoration: BoxDecoration(
            color: AppColors.terminalBlue,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialHub() {
    return Column(
      children: [
        _StaggeredReveal(
          controller: _entranceController,
          index: 0,
          child: _SocialNode(
            icon: LucideIcons.mail,
            title: 'SECURE_CHANNEL',
            value: 'baskarandeveloper1423@gmail.com',
            accentColor: Colors.blueAccent,
            onTap: () => _launchUrl('mailto:baskarandeveloper1423@gmail.com'),
          ),
        ),
        const SizedBox(height: 24),
        _StaggeredReveal(
          controller: _entranceController,
          index: 1,
          child: _SocialNode(
            icon: FontAwesomeIcons.linkedin,
            title: 'PROFESSIONAL_LINK',
            value: 'linkedin.com/in/baskaran-m',
            accentColor: const Color(0xFF0077B5),
            onTap: () => _launchUrl('https://linkedin.com/in/baskaran-m'),
          ),
        ),
        const SizedBox(height: 24),
        _StaggeredReveal(
          controller: _entranceController,
          index: 2,
          child: _SocialNode(
            icon: FontAwesomeIcons.github,
            title: 'REPOSITORY_ACCESS',
            value: 'github.com/BaskaranDeveloper',
            accentColor: Colors.purpleAccent,
            onTap: () => _launchUrl('https://github.com/BaskaranDeveloper'),
          ),
        ),
        const SizedBox(height: 24),
        _StaggeredReveal(
          controller: _entranceController,
          index: 3,
          child: _SocialNode(
            icon: LucideIcons.phone,
            title: 'DIRECT_ENCRYPTED',
            value: '+91 8778831267',
            accentColor: Colors.greenAccent,
            onTap: () => _launchUrl('tel:+918778831267'),
          ),
        ),
      ],
    );
  }

  Widget _buildMessageTerminal() {
    return _StaggeredReveal(
      controller: _entranceController,
      index: 1,
      child: LiquidGlass(
        intensity: 0.9,
        holographic: true,
        showGrain: true,
        padding: const EdgeInsets.all(48),
        accentColor: AppColors.terminalBlue,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(LucideIcons.terminal, color: AppColors.terminalBlue, size: 16),
                const SizedBox(width: 12),
                Text(
                  'INCOMING_TRANSMISSION_PROTOCOL',
                  style: TextStyle(
                    color: AppColors.terminalBlue.withValues(alpha: 0.6),
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            _TerminalTextField(
              label: 'IDENTIFIER',
              hint: 'Your Name',
              controller: _nameController,
            ),
            const SizedBox(height: 24),
            _TerminalTextField(
              label: 'RETURN_COORDINATES',
              hint: 'your.email@access.net',
              controller: _emailController,
            ),
            const SizedBox(height: 24),
            _TerminalTextField(
              label: 'TRANSMISSION_DATA',
              hint: 'Type your message...',
              controller: _messageController,
              maxLines: 4,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: _HUDButton(
                label: 'INITIATE TRANSMISSION',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Transmission Sent Successfully.')),
                  );
                  _nameController.clear();
                  _emailController.clear();
                  _messageController.clear();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SocialNode extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color accentColor;
  final VoidCallback onTap;

  const _SocialNode({
    required this.icon,
    required this.title,
    required this.value,
    required this.accentColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return LiquidGlass(
      intensity: 0.7,
      borderRadius: 16,
      padding: const EdgeInsets.all(24),
      accentColor: accentColor,
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: accentColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
                border: Border.all(color: accentColor.withValues(alpha: 0.2)),
              ),
              child: Icon(icon, color: accentColor, size: 20),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: accentColor.withValues(alpha: 0.6),
                      fontSize: 9,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Icon(LucideIcons.arrowUpRight,
                size: 14, color: Colors.white.withValues(alpha: 0.2)),
          ],
        ),
      ),
    );
  }
}

class _TerminalTextField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final int maxLines;

  const _TerminalTextField({
    required this.label,
    required this.hint,
    required this.controller,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white38,
            fontSize: 9,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(color: Colors.white, fontSize: 16),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white12),
            filled: true,
            fillColor: Colors.black.withValues(alpha: 0.3),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.white10),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.terminalBlue),
            ),
            contentPadding: const EdgeInsets.all(20),
          ),
        ),
      ],
    );
  }
}

class _HUDButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;

  const _HUDButton({required this.label, required this.onPressed});

  @override
  State<_HUDButton> createState() => _HUDButtonState();
}

class _HUDButtonState extends State<_HUDButton> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        return ElevatedButton(
          onPressed: widget.onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.terminalBlue.withValues(
                alpha: 0.7 + (0.3 * _pulseController.value)),
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.zero,
            elevation: 10 * _pulseController.value,
            shadowColor: AppColors.terminalBlue,
          ),
          child: Text(
            widget.label,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
              fontSize: 14,
            ),
          ),
        );
      },
    );
  }
}

class _StaggeredReveal extends StatelessWidget {
  final AnimationController controller;
  final int index;
  final Widget child;

  const _StaggeredReveal({
    required this.controller,
    required this.index,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final start = index * 0.1;
    final end = (start + 0.6).clamp(0.0, 1.0);
    
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: controller,
        curve: Interval(start, end, curve: Curves.easeIn),
      ),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.1),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: controller,
          curve: Interval(start, end, curve: Curves.easeOutCubic),
        )),
        child: child,
      ),
    );
  }
}
