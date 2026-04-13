import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:workspace/shared_ui/widgets/liquid_glass.dart';

class ProjectsView extends StatefulWidget {
  const ProjectsView({super.key});

  @override
  State<ProjectsView> createState() => _ProjectsViewState();
}

class _ProjectsViewState extends State<ProjectsView>
    with SingleTickerProviderStateMixin {
  int _activeProjectIndex = 0;
  late AnimationController _entranceController;

  final List<Map<String, dynamic>> _allProjects = [
    {
      'id': '01',
      'title': 'PSG LOTTO PLATFORM',
      'role': 'LEAD ARCHITECT',
      'desc':
          'Enterprise-grade multi-game lottery platform handling 10k+ concurrent users with real-time draw systems and digital wallets. This platform manages complex multi-game logic with extreme precision.',
      'tech': ['Flutter', 'Node.js', 'Redis', 'Socket.io', 'NestJS'],
      'icon': LucideIcons.clover,
      'metrics': 'CONCURRENT_10K+ • UPTIME_99.9%',
      'color': Colors.purpleAccent,
      'features': [
        'Scalable Multi-game Engine',
        'Secure Digital Wallets',
        'Real-time Draw Sockets',
        'Admin Analytics Dashboard',
      ],
      'impact': 'Reduced Time-to-Market by 30%',
    },
    {
      'id': '02',
      'title': 'VIRAKESARI MEDIA',
      'role': 'SR. DEVELOPER',
      'desc':
          'High-performance news ecosystem with real-time CMS integration. Focused on high-speed content delivery and seamless WebView integration for thousands of daily active readers.',
      'tech': ['Flutter Webview', 'REST API', 'FCM', 'SQLite'],
      'icon': LucideIcons.newspaper,
      'metrics': 'DAILY_ACTIVES_50K+ • STABILITY_99.9%',
      'color': Colors.deepPurpleAccent,
      'features': [
        'Real-time News Feed',
        'Optimized WebView Layer',
        'Rich Push Notifications',
        'Offline Caching Architecture',
      ],
      'impact': '99.9% Crash-Free Rate Achieved',
    },
    {
      'id': '03',
      'title': 'PRASHANTH IVF',
      'role': 'FULL-STACK',
      'desc':
          'Enterprise Healthcare ERP (White Label) for hospital patient records, appointment management, and secure cross-clinic data synchronization.',
      'tech': ['Next.js', 'NestJS', 'PostgreSQL', 'Flutter'],
      'icon': LucideIcons.activity,
      'metrics': 'HIPAA_READY • EHR_CORE',
      'color': Colors.indigoAccent,
      'features': [
        'Patient Record Management',
        'Appointment Scheduling',
        'Automated Notifications',
        'Clinic Data Sync',
      ],
      'impact': 'Enterprise Ready Deployment',
    },
    {
      'id': '04',
      'title': 'IMS / POS SYSTEM',
      'role': 'MODULE LEAD',
      'desc':
          'Robust Inventory Management and Point of Sale system featuring thermal printing support, multi-store tracking, and offline-first synchronization.',
      'tech': ['Flutter Desktop', 'ObjectBox', 'Dart', 'Printer Integration'],
      'icon': LucideIcons.shoppingCart,
      'metrics': 'RETAIL_OS • OFFLINE_SYNC',
      'color': Colors.purple,
      'features': [
        'Advanced Billing Module',
        'Inventory Tracking',
        'Multi-Store Reports',
        'Thermal Print Drivers',
      ],
      'impact': 'Cross-Platform Core Ready',
    },
    {
      'id': '05',
      'title': 'KAVERI MATRIMONY',
      'role': 'SR. FLUTTER DEV',
      'desc':
          'High-fidelity profile management and matchmaking platform for the regional market, featuring complex search filters and real-time chat.',
      'tech': ['Flutter', 'Firebase', 'Node.js', 'Cloud Messaging'],
      'icon': LucideIcons.users,
      'metrics': 'MATCH_FLOW • SECURE_CHAT',
      'color': Colors.pinkAccent,
      'features': [
        'Advanced Matchmaking Logic',
        'Profile Trust Verification',
        'Real-time Chat Systems',
        'Subscription Framework',
      ],
      'impact': 'Market Ready Release',
    },
    {
      'id': '06',
      'title': 'PKG ASTRO',
      'role': 'PERFORMANCE LEAD',
      'desc':
          'Astrological utility platform optimized for high scalability. Refined the UI and backend logic to provide millisecond-accurate data processing.',
      'tech': ['Flutter', 'FastAPI', 'Redis', 'Advanced UI'],
      'icon': LucideIcons.sparkles,
      'metrics': 'LATENCY_SUB_50MS • ULTRA_SCALE',
      'color': Colors.amberAccent,
      'features': [
        'High-Speed Calculations',
        'Smooth Motion UI',
        'Dynamic Report Engine',
        'Scalable Microservices',
      ],
      'impact': 'Achieved 2x Performance Boost',
    },
    {
      'id': '07',
      'title': 'PINAS LOTTO',
      'role': 'ARCHITECTURE',
      'desc':
          'International lottery implementation specializing in 2D/3D and 6-Digit game formats for the Philippine market.',
      'tech': ['Flutter', 'Node.js', 'Encryption', 'Sockets'],
      'icon': LucideIcons.dice5,
      'metrics': 'MARKET_GROWTH • SECURE_DRAW',
      'color': Colors.orangeAccent,
      'features': [
        'Regional Game Variant Logic',
        'High-Security Draw Engine',
        'Multi-Language Support',
        'Regional Payment Hooks',
      ],
      'impact': 'Successful Global Deployment',
    },
  ];

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
                final isCompact = w < 1100;

                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: w * 0.05,
                    vertical: h * 0.05,
                  ),
                  child: Column(
                    children: [
                      _buildSectorHeader(_activeProjectIndex + 1, scale),
                      const SizedBox(height: 32),

                      Expanded(
                        child: isCompact
                            ? _buildCompactProjectConsole(h, w, scale)
                            : Row(
                                children: [
                                  Expanded(
                                    flex: 7,
                                    child: _StaggeredReveal(
                                      controller: _entranceController,
                                      interval: const Interval(
                                        0.0,
                                        0.6,
                                        curve: Curves.easeOutCubic,
                                      ),
                                      child: _ParallaxProjectConsole(
                                        h: h,
                                        w: w,
                                        project:
                                            _allProjects[_activeProjectIndex],
                                        scale: scale,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 32),
                                  Expanded(
                                    flex: 3,
                                    child: _StaggeredReveal(
                                      controller: _entranceController,
                                      interval: const Interval(
                                        0.4,
                                        1.0,
                                        curve: Curves.easeOut,
                                      ),
                                      child: _buildProjectExplorer(h, w, scale),
                                    ),
                                  ),
                                ],
                              ),
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

  Widget _buildSectorHeader(int current, double scale) {
    return Row(
      children: [
        _buildMetaLabel('SECTOR: PROJECTS', Colors.purpleAccent),
        const Spacer(),
        _buildMetaLabel('DEPLOYMENT: ACTIVE_INSTANCES', Colors.white24),
        const SizedBox(width: 16),
        _buildMetaLabel(
          'INDEX: 0$current/0${_allProjects.length}',
          Colors.white24,
        ),
      ],
    );
  }

  Widget _buildProjectExplorer(double h, double w, double scale) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'REPOSITORY_NAV',
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w900,
            letterSpacing: 4,
            color: Colors.white24,
          ),
        ),
        const SizedBox(height: 24),
        const Divider(color: Colors.white10),
        const SizedBox(height: 24),
        Expanded(
          child: ListView.separated(
            itemCount: _allProjects.length,
            separatorBuilder: (_, __) => SizedBox(height: 12 * scale),
            itemBuilder: (context, index) {
              final isSelected = _activeProjectIndex == index;
              final p = _allProjects[index];
              return InkWell(
                onTap: () => setState(() => _activeProjectIndex = index),
                borderRadius: BorderRadius.circular(16),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: EdgeInsets.all(20 * scale),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.white.withValues(alpha: 0.05)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected
                          ? (p['color'] as Color).withValues(alpha: 0.3)
                          : Colors.white.withValues(alpha: 0.03),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        p['id'],
                        style: TextStyle(
                          fontSize: 10 * scale,
                          fontWeight: FontWeight.w900,
                          color: isSelected ? p['color'] : Colors.white12,
                        ),
                      ),
                      SizedBox(width: 20 * scale),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              p['title'],
                              style: TextStyle(
                                fontSize: 12 * scale,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1,
                                color: isSelected
                                    ? Colors.white
                                    : Colors.white38,
                              ),
                            ),
                            Text(
                              p['role'],
                              style: TextStyle(
                                fontSize: 8 * scale,
                                color: Colors.white24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCompactProjectConsole(double h, double w, double scale) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: _ParallaxProjectConsole(
            h: h,
            w: w,
            project: _allProjects[_activeProjectIndex],
            scale: scale,
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          height: 80 * scale,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _allProjects.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final isSelected = _activeProjectIndex == index;
              return GestureDetector(
                onTap: () => setState(() => _activeProjectIndex = index),
                child: Container(
                  width: 160 * scale,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? _allProjects[index]['color']
                          : Colors.white12,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      _allProjects[index]['id'],
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: isSelected ? Colors.white : Colors.white24,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMetaLabel(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        border: Border.all(color: color.withValues(alpha: 0.2)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w900,
          color: color,
          letterSpacing: 2,
        ),
      ),
    );
  }
}

class _ParallaxProjectConsole extends StatefulWidget {
  final double h;
  final double w;
  final Map<String, dynamic> project;
  final double scale;

  const _ParallaxProjectConsole({
    required this.h,
    required this.w,
    required this.project,
    required this.scale,
  });

  @override
  State<_ParallaxProjectConsole> createState() =>
      _ParallaxProjectConsoleState();
}

class _ParallaxProjectConsoleState extends State<_ParallaxProjectConsole> {
  double _rotateX = 0;
  double _rotateY = 0;

  void _onHover(PointerEvent e) {
    final rb = context.findRenderObject() as RenderBox;
    final pos = rb.globalToLocal(e.position);
    setState(() {
      _rotateY = (pos.dx / widget.w - 0.5) * 0.1;
      _rotateX = (pos.dy / widget.h - 0.5) * -0.1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.scale;
    final p = widget.project;
    final Color accentColor = p['color'];

    return MouseRegion(
      onHover: _onHover,
      onExit: (_) => setState(() {
        _rotateX = 0;
        _rotateY = 0;
      }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateX(_rotateX)
          ..rotateY(_rotateY),
        child: LiquidGlass(
          intensity: 0.9,
          showGrain: true,
          holographic: true,
          accentColor: accentColor,
          padding: EdgeInsets.zero,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Stack(
              children: [
                Positioned(
                  right: -100 + (_rotateY * 400),
                  top: -50 - (_rotateX * 400),
                  child: Text(
                    p['id'],
                    style: TextStyle(
                      fontSize: 500 * s,
                      fontWeight: FontWeight.w900,
                      color: Colors.white.withValues(alpha: 0.03),
                    ),
                  ),
                ),

                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 60 * s,
                    vertical: 40 * s,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(16 * s),
                            decoration: BoxDecoration(
                              color: accentColor.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              p['icon'],
                              color: accentColor,
                              size: 32 * s,
                            ),
                          ),
                          SizedBox(width: 24 * s),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'TECHNICAL_IMPACT',
                                style: TextStyle(
                                  fontSize: 10 * s,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white24,
                                  letterSpacing: 2,
                                ),
                              ),
                              Text(
                                p['impact'],
                                style: TextStyle(
                                  fontSize: 16 * s,
                                  color: accentColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 40 * s),
                      Text(
                        p['title'],
                        style: TextStyle(
                          fontSize: 56 * s,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -2,
                          height: 1.0,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        p['metrics'],
                        style: TextStyle(
                          fontSize: 10 * s,
                          color: Colors.white38,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                      SizedBox(height: 24 * s),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 700),
                        child: Text(
                          p['desc'],
                          style: TextStyle(
                            fontSize: 16 * s,
                            color: Colors.white.withValues(alpha: 0.6),
                            height: 1.6,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      SizedBox(height: 48 * s),

                      // FEATURES SECTION
                      Text(
                        'SYSTEM_CORE_FEATURES',
                        style: TextStyle(
                          fontSize: 11 * s,
                          fontWeight: FontWeight.w900,
                          color: accentColor.withValues(alpha: 0.5),
                          letterSpacing: 3,
                        ),
                      ),
                      const SizedBox(height: 24),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 5,
                              crossAxisSpacing: 24,
                              mainAxisSpacing: 24,
                            ),
                        itemCount: (p['features'] as List).length,
                        itemBuilder: (context, i) {
                          return Row(
                            children: [
                              Icon(
                                LucideIcons.checkCircle2,
                                size: 14 * s,
                                color: accentColor,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  p['features'][i],
                                  style: TextStyle(
                                    fontSize: 13 * s,
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),

                      SizedBox(height: 48 * s),

                      // TECHNOLOGY STACK
                      Text(
                        'TECHNOLOGY_STACK',
                        style: TextStyle(
                          fontSize: 11 * s,
                          fontWeight: FontWeight.w900,
                          color: accentColor.withValues(alpha: 0.5),
                          letterSpacing: 3,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: (p['tech'] as List<String>)
                            .map((t) => _buildHUDTag(t, accentColor, s))
                            .toList(),
                      ),
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

  Widget _buildHUDTag(String label, Color color, double s) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16 * s, vertical: 8 * s),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withValues(alpha: 0.1)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12 * s,
          fontWeight: FontWeight.w900,
          color: Colors.white70,
          letterSpacing: 1,
        ),
      ),
    );
  }
}

class _StaggeredReveal extends StatelessWidget {
  final AnimationController controller;
  final Interval interval;
  final Widget child;

  const _StaggeredReveal({
    required this.controller,
    required this.interval,
    required this.child,
  });

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

class _FloatingOrbs extends StatefulWidget {
  const _FloatingOrbs();

  @override
  State<_FloatingOrbs> createState() => _FloatingOrbsState();
}

class _FloatingOrbsState extends State<_FloatingOrbs>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
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
            _buildOrb(600, 600, Colors.purpleAccent.withValues(alpha: 0.04), 0),
            _buildOrb(
              500,
              500,
              Colors.deepPurpleAccent.withValues(alpha: 0.04),
              0.5,
            ),
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
                Colors.purpleAccent.withValues(alpha: 0.12),
                Colors.deepPurpleAccent.withValues(alpha: 0.03),
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
