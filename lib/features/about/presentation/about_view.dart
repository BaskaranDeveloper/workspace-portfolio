import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:workspace/shared_ui/widgets/liquid_glass.dart';

class AboutView extends StatefulWidget {
  const AboutView({super.key});

  @override
  State<AboutView> createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> with SingleTickerProviderStateMixin {
  late AnimationController _entranceController;

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          const Positioned.fill(child: RepaintBoundary(child: _FloatingOrbs())),
          Positioned.fill(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final h = constraints.maxHeight;
                final w = constraints.maxWidth;
                final scale = (h / 900).clamp(0.7, 1.2);
                final isCompact = w < 1000;
                
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: w * 0.05,
                    vertical: h * 0.05,
                  ),
                  child: Column(
                    children: [
                      // TOP EDITORIAL HERO
                      Expanded(
                        flex: 3,
                        child: AnimatedBuilder(
                          animation: _entranceController,
                          builder: (context, child) {
                            final anim = CurvedAnimation(parent: _entranceController, curve: const Interval(0.0, 0.4, curve: Curves.easeOutCubic)).value;
                            return Opacity(
                              opacity: anim,
                              child: Transform.translate(
                                offset: Offset(0, 30 * (1 - anim)),
                                child: _buildEditorialHero(h, w, scale),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 32),
                      
                      // MAIN HUD DASHBOARD
                      Expanded(
                        flex: 7,
                        child: isCompact 
                          ? _buildCompactScrollSections() 
                          : _buildHUDDashboard(h, w, scale),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditorialHero(double h, double w, double scale) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            _buildOrb(220 * scale, 220 * scale, Colors.blueAccent.withValues(alpha: 0.1), 0),
            Container(
              width: 110 * scale,
              height: 110 * scale,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.blueAccent.withValues(alpha: 0.2), width: 1),
              ),
              child: ClipOval(
                child: Image.network(
                  'https://api.dicebear.com/7.x/bottts/png?seed=Baskaran&backgroundColor=060606',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Floating Meta Tag
            Positioned(
              right: -20,
              top: 20,
              child: _buildMetaLabel('[UID: BASK-0314]', Colors.blueAccent),
            ),
          ],
        ),
        SizedBox(height: 24 * scale),
        Text(
          'BASKARAN M',
          style: TextStyle(
            fontSize: 72 * scale,
            fontWeight: FontWeight.w900,
            letterSpacing: -4,
            height: 0.8,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1
              ..color = Colors.white.withValues(alpha: 0.1),
          ),
        ),
        Transform.translate(
          offset: const Offset(0, -20),
          child: Text(
            'BASKARAN M',
            style: TextStyle(
              fontSize: 72 * scale,
              fontWeight: FontWeight.w900,
              letterSpacing: -4,
              height: 0.8,
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
        ),
        Text(
          'FULL-STACK ARCHITECT • FLUTTER SPEC-01',
          style: TextStyle(
            fontSize: 10 * scale,
            fontWeight: FontWeight.bold,
            letterSpacing: 6 * scale,
            color: Colors.blueAccent.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildHUDDashboard(double h, double w, double scale) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 01: EXPERIENCE BOARD
        Expanded(
          flex: 4,
          child: _StaggeredReveal(
            controller: _entranceController,
            interval: const Interval(0.3, 0.7, curve: Curves.easeOut),
            child: _HUDTile(
              index: '01',
              title: 'OPERATIONAL LOGS',
              icon: LucideIcons.terminal,
              holographic: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHUDTimelineItem('2022-NOW', 'SR. SOFTWARE ENGINEER', 'TRIROPE TECHNOLOGIES', 'Scale: 10k+ / Uptime: 99.9%'),
                  const SizedBox(height: 24),
                  _buildHUDTimelineItem('2021-22', 'JUNIOR DEVELOPER', 'STARTUP ECO-SYSTEM', 'Core: Dart/Node.js Integration'),
                  const Spacer(),
                  _buildMetaLabel('[SECURITY: LEVEL-04]', Colors.white24),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 24),
        
        // 02: CORE STACK (Center Column)
        Expanded(
          flex: 5,
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: _StaggeredReveal(
                  controller: _entranceController,
                  interval: const Interval(0.4, 0.8, curve: Curves.easeOut),
                  child: _HUDTile(
                    index: '02',
                    title: 'SYSTEM CAPABILITIES',
                    icon: LucideIcons.cpu,
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        'FLUTTER_3.x', 'NODE_JS', 'NEST_JS', 'DART', 'TYPE_SCRIPT', 
                        'REDIS', 'POSTGRE_SQL', 'DOCKER', 'AWS_CLD'
                      ].map((s) => _buildHUDChip(s)).toList(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                flex: 6,
                child: _StaggeredReveal(
                  controller: _entranceController,
                  interval: const Interval(0.5, 0.9, curve: Curves.easeOut),
                  child: _HUDTile(
                    index: '03',
                    title: 'ACTIVE DEPLOYMENTS',
                    icon: LucideIcons.activity,
                    holographic: true,
                    child: Column(
                      children: [
                        _buildDeploymentRow('PSG_LOTTO', 'ARCHITECT', 'ACTIVE'),
                        _buildDeploymentRow('VIRAKESARI', 'SR_DEV', 'STABLE'),
                        _buildDeploymentRow('IMS_POS', 'LEAD', 'DEPLO'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 24),
        
        // 03: ACADEMIC & COMMS
        Expanded(
          flex: 3,
          child: _StaggeredReveal(
            controller: _entranceController,
            interval: const Interval(0.6, 1.0, curve: Curves.easeOut),
            child: _HUDTile(
              index: '04',
              title: 'BIOMETRIC DATA',
              icon: LucideIcons.fingerprint,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('B.E. COMPUTER SCIENCE', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, letterSpacing: 1)),
                  const Text('Anna Univ. DSIT-17-21', style: TextStyle(color: Colors.blueAccent, fontSize: 11, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  _buildMetaLabel('CGPA: 7.69', Colors.greenAccent),
                  const Spacer(),
                  const Divider(color: Colors.white10),
                  const SizedBox(height: 16),
                  _buildHUDContact(LucideIcons.mail, 'baskarandeveloper1423@gmail.com'),
                  const SizedBox(height: 12),
                  _buildHUDContact(LucideIcons.mapPin, 'TAMIL NADU, IND'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCompactScrollSections() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _HUDTile(index: '01', title: 'LOGS', icon: LucideIcons.terminal, height: 350, child: Container()),
          const SizedBox(height: 16),
          _HUDTile(index: '02', title: 'SYSTEM', icon: LucideIcons.cpu, height: 250, child: Container()),
        ],
      ),
    );
  }

  Widget _buildHUDTimelineItem(String date, String role, String company, String stats) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.blueAccent, shape: BoxShape.circle)),
            const SizedBox(width: 10),
            Text(date, style: const TextStyle(fontSize: 10, color: Colors.white38, fontWeight: FontWeight.bold, letterSpacing: 1)),
          ],
        ),
        const SizedBox(height: 8),
        Text(role, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, letterSpacing: -0.5)),
        Text(company, style: TextStyle(fontSize: 12, color: Colors.blueAccent.withValues(alpha: 0.8), fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(stats, style: const TextStyle(fontSize: 10, color: Colors.white24, letterSpacing: 0.5)),
      ],
    );
  }

  Widget _buildHUDChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Text(label, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.white54, letterSpacing: 1)),
    );
  }

  Widget _buildDeploymentRow(String name, String role, String status) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(width: 2, height: 20, color: Colors.blueAccent.withValues(alpha: 0.3)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1)),
                Text(role, style: const TextStyle(fontSize: 9, color: Colors.white24)),
              ],
            ),
          ),
          _buildMetaLabel(status, status == 'ACTIVE' ? Colors.greenAccent : Colors.blueAccent),
        ],
      ),
    );
  }

  Widget _buildHUDContact(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 12, color: Colors.blueAccent.withValues(alpha: 0.5)),
        const SizedBox(width: 12),
        Expanded(child: Text(label.toUpperCase(), style: const TextStyle(fontSize: 9, color: Colors.white38, fontWeight: FontWeight.bold, letterSpacing: 1))),
      ],
    );
  }

  Widget _buildMetaLabel(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        border: Border.all(color: color.withValues(alpha: 0.2)),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Text(text, style: TextStyle(fontSize: 8, fontWeight: FontWeight.w900, color: color, letterSpacing: 1)),
    );
  }

  Widget _buildOrb(double w, double h, Color color, double offsetFactor) {
    return Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            Colors.blueAccent.withValues(alpha: 0.15),
            Colors.blueAccent.withValues(alpha: 0.03),
            Colors.transparent,
          ],
          stops: const [0.0, 0.4, 1.0],
        ),
      ),
    );
  }
}

class _StaggeredReveal extends StatelessWidget {
  final AnimationController controller;
  final Interval interval;
  final Widget child;

  const _StaggeredReveal({required this.controller, required this.interval, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final anim = CurvedAnimation(parent: controller, curve: interval).value;
        return Opacity(
          opacity: anim,
          child: Transform.translate(
            offset: Offset(0, 40 * (1 - anim)),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}

class _HUDTile extends StatelessWidget {
  final String index;
  final String title;
  final IconData icon;
  final Widget child;
  final double? height;
  final bool holographic;

  const _HUDTile({required this.index, required this.title, required this.icon, required this.child, this.height, this.holographic = false});

  @override
  Widget build(BuildContext context) {
    return LiquidGlass(
      intensity: 0.8,
      showGrain: true,
      holographic: holographic,
      accentColor: Colors.blueAccent,
      padding: EdgeInsets.zero,
      child: Container(
        height: height,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withValues(alpha: 0.05), width: 0.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(icon, size: 14, color: Colors.blueAccent),
                    const SizedBox(width: 12),
                    Text(title, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 3, color: Colors.white54)),
                  ],
                ),
                Text(index, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Colors.white.withValues(alpha: 0.1), letterSpacing: 1)),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(color: Colors.white10),
            const SizedBox(height: 24),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}

class _FloatingOrbs extends StatefulWidget {
  const _FloatingOrbs();

  @override
  State<_FloatingOrbs> createState() => _FloatingOrbsState();
}

class _FloatingOrbsState extends State<_FloatingOrbs> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 20))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          children: [
            _buildOrb(600, 600, Colors.blueAccent.withValues(alpha: 0.04), 0),
            _buildOrb(500, 500, Colors.lightBlueAccent.withValues(alpha: 0.04), 0.5),
          ],
        );
      },
    );
  }

  Widget _buildOrb(double w, double h, Color color, double offsetFactor) {
    final value = (_controller.value + offsetFactor) % 1.0;
    return Transform.translate(
      offset: Offset(
        400 * math.sin(value * 2 * math.pi),
        200 * math.cos(value * 2 * math.pi),
      ),
      child: Center(
        child: Container(
          width: w,
          height: h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                Colors.blueAccent.withValues(alpha: 0.12),
                Colors.blueAccent.withValues(alpha: 0.03),
                Colors.transparent,
              ],
              stops: const [0.0, 0.4, 1.0],
            ),
          ),
        ),
      ),
    );
  }
}
