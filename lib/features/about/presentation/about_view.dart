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
      duration: const Duration(milliseconds: 1000),
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
          // Subdued Background Orbs
          const Positioned.fill(child: RepaintBoundary(child: _FloatingOrbs())),
          
          Positioned.fill(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 40),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: Column(
                    children: [
                      _buildModernHero(),
                      const SizedBox(height: 80),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          bool isMobile = constraints.maxWidth < 950;
                          return isMobile 
                            ? Column(children: _buildSections(isMobile))
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(flex: 3, child: Column(children: _buildPrimarySections())),
                                  const SizedBox(width: 60),
                                  Expanded(flex: 2, child: Column(children: _buildSideSections())),
                                ],
                              );
                        },
                      ),
                      const SizedBox(height: 100),
                      _buildModernFooter(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- MODERN HERO SECTION ---
  Widget _buildModernHero() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            _buildOrb(220, 220, Colors.blueAccent.withValues(alpha: 0.1), 0),
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withValues(alpha: 0.1), width: 3),
                image: const DecorationImage(
                  image: NetworkImage('https://api.dicebear.com/7.x/bottts/png?seed=Baskaran&backgroundColor=060606'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        const Text(
          'BASKARAN M',
          style: TextStyle(fontSize: 64, fontWeight: FontWeight.w900, letterSpacing: -3, height: 1.0),
        ),
        const SizedBox(height: 12),
        Text(
          'SENIOR SOFTWARE ENGINEER • FLUTTER & FULL-STACK SPECIALIST',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 4, color: Colors.blueAccent.withValues(alpha: 0.8)),
        ),
        const SizedBox(height: 48),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 750),
          child: Text(
            'highly motivated Software Engineer with 3+ years of experience in designing, developing, and delivering enterprise-grade cross-platform applications. I specialize in building scalable, secure, and maintainable systems that bridge the gap between complex engineering and elegant user experiences.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.white.withValues(alpha: 0.5), height: 1.6, fontWeight: FontWeight.w300),
          ),
        ),
      ],
    );
  }

  // --- CONTENT SECTIONS ---
  List<Widget> _buildSections(bool isMobile) {
    return [
      ..._buildPrimarySections(),
      const SizedBox(height: 40),
      ..._buildSideSections(),
    ];
  }

  List<Widget> _buildPrimarySections() {
    return [
      _buildExperienceSection(),
      const SizedBox(height: 60),
      _buildFeaturedProjectsSection(),
    ];
  }

  Widget _buildExperienceSection() {
    return _NeatGlassCard(
      title: 'PROFESSIONAL EXPERIENCE',
      icon: LucideIcons.briefcase,
      child: Column(
        children: [
          _buildTimelineItem(
            'AUG 2022 - PRESENT',
            'Software Engineer | Flutter & Full-Stack',
            'Trirope Technologies Pvt. Ltd.',
            [
              'Spearheaded development of 10+ enterprise-grade Flutter apps, reducing time-to-market by 30%.',
              'Architected and deployed scalable backend microservices using Node.js/NestJS for 10k+ concurrent users.',
              'Integrated high-security payment gateways, biometrics, and real-time socket-based features.',
              'Mentored a team of 4 junior developers, enforcing clean architecture and code review standards.',
              'Optimized app performance to maintain a 99.9% crash-free rate and high frame rates.',
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedProjectsSection() {
    return _NeatGlassCard(
      title: 'FEATURED PROJECTS',
      icon: LucideIcons.rocket,
      child: Column(
        children: [
          _buildProjectDetail('Enterprise Lottery Platform', 'PSG Lotto, Pinas Lotto, 2D/3D - Scalable multi-game platform with secure payments.'),
          _buildProjectDetail('Healthcare Management', 'Prashanth IVF (White Label) - Hospital application for records, appointments, and notifications.'),
          _buildProjectDetail('Media & News Platform', 'Virakesari App - Real-time news application with high-performance WebView integration.'),
          _buildProjectDetail('Matrimony Platform', 'Kaveri Matrimony - Profile management, matchmaking, real-time chat, and subscriptions.'),
          _buildProjectDetail('POS & Inventory', 'IMS - Designing billing, inventory tracking, and reporting modules for retail.'),
        ],
      ),
    );
  }

  Widget _buildProjectDetail(String title, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.blueAccent.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
            child: const Icon(LucideIcons.checkCircle2, size: 14, color: Colors.blueAccent),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(desc, style: TextStyle(fontSize: 13, color: Colors.white.withValues(alpha: 0.4), height: 1.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildSideSections() {
    return [
      _buildSkillSection(),
      const SizedBox(height: 60),
      _buildEducationSection(),
    ];
  }

  Widget _buildSkillSection() {
    return _NeatGlassCard(
      title: 'TECHNICAL SKILLS',
      icon: LucideIcons.layers,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSkillGroup('PROGRAMMING', ['Dart (Strong)', 'JavaScript', 'TypeScript', 'Python', 'Java', 'C']),
          const SizedBox(height: 24),
          _buildSkillGroup('MOBILE & FRONTEND', ['Flutter', 'React.js', 'Next.js', 'HTML5/CSS3']),
          const SizedBox(height: 24),
          _buildSkillGroup('BACKEND & APIS', ['Node.js', 'NestJS', 'Express.js', 'FastAPI', 'REST APIs', 'JWT']),
          const SizedBox(height: 24),
          _buildSkillGroup('DATABASES', ['Firebase', 'MySQL', 'PostgreSQL']),
          const SizedBox(height: 24),
          _buildSkillGroup('PLATFORMS & TOOLS', ['Android', 'iOS', 'Web', 'Git', 'Figma', 'Blender']),
        ],
      ),
    );
  }

  Widget _buildSkillGroup(String category, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(category, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 2, color: Colors.white.withValues(alpha: 0.3))),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: items.map((i) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
              color: Colors.white.withValues(alpha: 0.03),
            ),
            child: Text(i, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildEducationSection() {
    return _NeatGlassCard(
      title: 'EDUCATION',
      icon: LucideIcons.graduationCap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('B.E. Computer Science Engineering', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text('Dhanalakshmi Srinivasan Institute of Technology', style: TextStyle(fontSize: 13, color: Colors.blueAccent.withValues(alpha: 0.7), fontStyle: FontStyle.italic)),
          Text('Anna University • 2017 – 2021', style: const TextStyle(fontSize: 13, color: Colors.white38)),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: Colors.greenAccent.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(6), border: Border.all(color: Colors.greenAccent.withValues(alpha: 0.2))),
            child: const Text('CGPA: 7.69', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.greenAccent)),
          ),
          const SizedBox(height: 24),
          const Text('Higher Secondary Education', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          Text('State Board • 2015 – 2017', style: const TextStyle(fontSize: 13, color: Colors.white38)),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(String date, String role, String company, List<String> points, {bool isLast = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(width: 10, height: 10, decoration: const BoxDecoration(color: Colors.blueAccent, shape: BoxShape.circle)),
            if (!isLast) Container(width: 1, height: 280, color: Colors.white.withValues(alpha: 0.1)),
          ],
        ),
        const SizedBox(width: 24),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(date, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white38, letterSpacing: 1.5)),
              const SizedBox(height: 4),
              Text(role, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(company, style: TextStyle(fontSize: 14, color: Colors.blueAccent.withValues(alpha: 0.8), fontWeight: FontWeight.w500)),
              const SizedBox(height: 20),
              ...points.map((p) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: const EdgeInsets.only(top: 6), child: Container(width: 4, height: 4, decoration: const BoxDecoration(color: Colors.blueAccent, shape: BoxShape.circle))),
                    const SizedBox(width: 14),
                    Expanded(child: Text(p, style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 13, height: 1.6))),
                  ],
                ),
              )),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildModernFooter() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialLink(LucideIcons.github, 'GITHUB'),
            const SizedBox(width: 40),
            _buildSocialLink(LucideIcons.linkedin, 'LINKEDIN'),
            const SizedBox(width: 40),
            _buildSocialLink(LucideIcons.mail, 'EMAIL'),
          ],
        ),
        const SizedBox(height: 40),
        Text('Villupuram, Tamil Nadu, India', style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.2), letterSpacing: 2)),
      ],
    );
  }

  Widget _buildSocialLink(IconData icon, String label) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Row(
        children: [
          Icon(icon, size: 14, color: Colors.white.withValues(alpha: 0.3)),
          const SizedBox(width: 8),
          Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 2, color: Colors.white.withValues(alpha: 0.3))),
        ],
      ),
    );
  }

  Widget _buildOrb(double w, double h, Color color, double offsetFactor) {
    return Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color.withValues(alpha: 0.15), color.withValues(alpha: 0.03), Colors.transparent],
          stops: const [0.0, 0.4, 1.0],
        ),
      ),
    );
  }
}

class _NeatGlassCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;

  const _NeatGlassCard({required this.title, required this.icon, required this.child});

  @override
  Widget build(BuildContext context) {
    return LiquidGlass(
      intensity: 0.65,
      showGrain: true,
      padding: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 16, color: Colors.blueAccent),
                const SizedBox(width: 14),
                Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 3, color: Colors.white38)),
              ],
            ),
            const SizedBox(height: 40),
            child,
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
            _buildOrb(500, 500, Colors.purpleAccent.withValues(alpha: 0.04), 0.5),
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
              colors: [color.withValues(alpha: 0.12), color.withValues(alpha: 0.03), Colors.transparent],
              stops: const [0.0, 0.4, 1.0],
            ),
          ),
        ),
      ),
    );
  }
}
