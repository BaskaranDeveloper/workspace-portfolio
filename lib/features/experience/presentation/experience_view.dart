import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:workspace/shared_ui/theme/app_colors.dart';
import 'package:workspace/shared_ui/widgets/liquid_glass.dart';

class ExperienceView extends StatefulWidget {
  const ExperienceView({super.key});

  @override
  State<ExperienceView> createState() => _ExperienceViewState();
}

class _ExperienceViewState extends State<ExperienceView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 80),
            
            // THE NATIVE TIMELINE
            _buildModernTimelineEntry(
              role: 'Senior Software Engineer',
              specialization: 'Flutter & Full-Stack Architect',
              company: 'Trirope Technologies Pvt. Ltd.',
              duration: 'AUG 2022 — PRESENT',
              location: 'Chennai • India',
              isCurrent: true,
              pillars: [
                _ExpPillar(
                  icon: LucideIcons.layers,
                  title: 'Core Architecture',
                  details: [
                    'Developed robust NestJS services to support high-scale application features.',
                    'Integrated secure payment gateways and biometric authentication.',
                    'Developed real-time socket-based synchronization for finance-focused applications.',
                  ],
                  metrics: ['TEN_APPLICATIONS_DEPLOYED', 'MICROSERVICES_EXP'],
                ),
                _ExpPillar(
                  icon: LucideIcons.gauge,
                  title: 'Performance & Scaling',
                  details: [
                    'Achieved 99.9% crash-free rate across low-end Android fleet.',
                    'Optimized image processing and caching for high-speed media.',
                    'Reduced time-to-market by 30% through reusable HUD components.',
                  ],
                  metrics: ['OPTIMIZED_LATENCY', 'ZERO_CRITICAL_BUGS'],
                ),
                _ExpPillar(
                  icon: LucideIcons.users,
                  title: 'Leadership & Impact',
                  details: [
                    'Mentored junior developers in Clean Architecture and technical best practices.',
                    'Led client technical strategy for enterprise digital transformation.',
                    'Standardized CI/CD pipelines for 10+ production environments.',
                  ],
                  metrics: ['TEAM_LEAD_ROLE', 'AGILE_STRATEGY'],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAnimatedItem(
          0,
          Text(
            'PROFESSIONAL_CHRONICLE',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.3),
              fontSize: 10,
              fontWeight: FontWeight.w900,
              letterSpacing: 4,
            ),
          ),
        ),
        const SizedBox(height: 12),
        _buildAnimatedItem(
          1,
          const Text(
            'Executive Journey',
            style: TextStyle(
              color: Colors.white,
              fontSize: 48,
              fontWeight: FontWeight.w900,
              letterSpacing: -2,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildModernTimelineEntry({
    required String role,
    required String specialization,
    required String company,
    required String duration,
    required String location,
    required bool isCurrent,
    required List<_ExpPillar> pillars,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // NATIVE PULSE INDICATOR
          _buildPulseIndicator(isCurrent),
          const SizedBox(width: 48),
          
          Expanded(
            child: _buildAnimatedItem(
              2,
              LiquidGlass(
                intensity: 0.9,
                blurSigma: 40,
                borderRadius: 32,
                padding: const EdgeInsets.all(48),
                accentColor: AppColors.terminalBlue,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              specialization.toUpperCase(),
                              style: const TextStyle(
                                color: AppColors.terminalBlue,
                                fontSize: 11,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 2,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              role,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.w900,
                                letterSpacing: -1,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              company,
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.6),
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        _buildStatusBadge(duration),
                      ],
                    ),
                    const SizedBox(height: 48),
                    const Divider(color: Colors.white10),
                    const SizedBox(height: 48),
                    
                    // PILLAR DASHBOARD
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: pillars.map((p) => Expanded(child: _buildPillar(p))).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPulseIndicator(bool isCurrent) {
    return Column(
      children: [
        if (isCurrent)
          _ExperiencePulseNode()
        else
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white24, width: 2),
            ),
          ),
        Expanded(
          child: Container(
            width: 1,
            margin: const EdgeInsets.symmetric(vertical: 12),
            color: Colors.white.withValues(alpha: 0.1),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge(String duration) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: Colors.white10),
          ),
          child: Text(
            duration,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 10,
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const Icon(LucideIcons.mapPin, size: 12, color: Colors.white24),
            const SizedBox(width: 8),
            Text(
              'CHENNAI • REMOTE_SYNC',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.3),
                fontSize: 9,
                fontWeight: FontWeight.w900,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPillar(_ExpPillar pillar) {
    return Padding(
      padding: const EdgeInsets.only(right: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.terminalBlue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(pillar.icon, color: AppColors.terminalBlue, size: 20),
          ),
          const SizedBox(height: 24),
          Text(
            pillar.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 16),
          ...pillar.details.map((point) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Icon(LucideIcons.chevronRight, size: 10, color: AppColors.terminalBlue),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    point,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 13,
                      height: 1.5,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          )),
          const SizedBox(height: 24),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: pillar.metrics.map((m) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.03),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                m,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.2),
                  fontSize: 7,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                ),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedItem(int index, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(0, 0.05), end: Offset.zero)
          .animate(
            CurvedAnimation(
              parent: _controller,
              curve: Interval(
                index * 0.1,
                0.8 + (index * 0.1),
                curve: Curves.easeOutCubic,
              ),
            ),
          ),
      child: FadeTransition(
        opacity: Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(
              index * 0.1,
              0.8 + (index * 0.1),
              curve: Curves.easeOut,
            ),
          ),
        ),
        child: child,
      ),
    );
  }
}

class _ExpPillar {
  final IconData icon;
  final String title;
  final List<String> details;
  final List<String> metrics;
  _ExpPillar({required this.icon, required this.title, required this.details, required this.metrics});
}

class _ExperiencePulseNode extends StatefulWidget {
  @override
  State<_ExperiencePulseNode> createState() => _ExperiencePulseNodeState();
}

class _ExperiencePulseNodeState extends State<_ExperiencePulseNode> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat();
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
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 14 + (20 * _pulseController.value),
              height: 14 + (20 * _pulseController.value),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.terminalBlue.withValues(alpha: 0.5 * (1 - _pulseController.value)), width: 1.5),
              ),
            ),
            Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.terminalBlue,
                boxShadow: [
                  BoxShadow(color: AppColors.terminalBlue, blurRadius: 10, spreadRadius: 2),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
