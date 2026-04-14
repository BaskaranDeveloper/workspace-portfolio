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
  late AnimationController _entranceController;

  final List<ExperienceModel> _experienceData = [
    ExperienceModel(
      role: 'Senior Software Engineer',
      grade: 'EXECUTIVE',
      company: 'Trirope Technologies Pvt. Ltd.',
      duration: 'AUG 2022 — PRESENT',
      location: 'Chennai • India',
      isCurrent: true,
      accentColor: AppColors.terminalBlue,
      achievements: [
        'Led end-to-end development of 10+ enterprise Flutter applications, reducing delivery cycles.',
        'Developed robust backend services using Node.js and NestJS for high-scale app features.',
        'Implemented secure payment gateways, biometric auth, and low-latency socket synchronization.',
        'Mentored junior developers fostering adoption of Clean Architecture and technical best practices.',
        'Optimized performance achieving 99.9% crash-free rates and fluid 60FPS across wide device fleet.',
      ],
      techStack: ['Flutter', 'Node.js', 'NestJS', 'Redis', 'Socket.io', 'AWS'],
    ),
    ExperienceModel(
      role: 'B.E. Computer Science Engineering',
      grade: 'ACADEMIC',
      company: 'Dhanalakshmi Srinivasan Institute of Technology',
      duration: '2017 — 2021',
      location: 'Tamil Nadu • India',
      isCurrent: false,
      accentColor: Colors.purpleAccent,
      achievements: [
        'Specialized in mobile application development and system architecture.',
        'Completed major research project in Ethical Hacking and Network Security.',
        'Maintained a solid academic record with a CGPA of 7.69.',
      ],
      techStack: ['Dart', 'Java', 'C++', 'SQL', 'Algorithms', 'Android'],
    ),
    ExperienceModel(
      role: 'Higher Secondary Education',
      grade: 'FOUNDATION',
      company: 'State Board of Tamil Nadu',
      duration: '2015 — 2017',
      location: 'Tamil Nadu • India',
      isCurrent: false,
      accentColor: Colors.amberAccent,
      achievements: [
        'Focused on Mathematics, Physics, and Computer Science core subjects.',
        'Achieved a strong foundation in logical reasoning and software fundamentals.',
        'Graduated with 67.33% (808/1200) overall score.',
      ],
      techStack: ['Physics', 'Mathematics', 'C Programming', 'Logic'],
    ),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_experienceData.length, (index) {
                        return Expanded(
                          child: _StaggeredReveal(
                            controller: _entranceController,
                            index: index,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: _ExperienceCard(model: _experienceData[index]),
                            ),
                          ),
                        );
                      }),
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
        Text(
          'CHRONICLE_V1.0',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.2),
            fontSize: 10,
            fontWeight: FontWeight.w900,
            letterSpacing: 4,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Professional Odyssey',
          style: TextStyle(
            color: Colors.white,
            fontSize: 48,
            fontWeight: FontWeight.w900,
            letterSpacing: -3,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: 60,
          height: 3,
          decoration: BoxDecoration(
            color: AppColors.terminalBlue,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }
}

class _ExperienceEntry extends StatelessWidget {
  final ExperienceModel model;
  final bool isLast;

  const _ExperienceEntry({required this.model, this.isLast = false});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTimeline(),
          const SizedBox(width: 48),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: _ExperienceCard(model: model),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline() {
    return Column(
      children: [
        _TimelineNode(isCurrent: model.isCurrent, accentColor: model.accentColor),
        if (!isLast)
          Expanded(
            child: Container(
              width: 1,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    model.accentColor.withValues(alpha: 0.3),
                    Colors.white.withValues(alpha: 0.05),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  final ExperienceModel model;

  const _ExperienceCard({required this.model});

  @override
  Widget build(BuildContext context) {
    return LiquidGlass(
      intensity: 0.9,
      blurSigma: 30,
      borderRadius: 24,
      holographic: true,
      showGrain: true,
      accentColor: model.accentColor,
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _RoleTag(label: model.grade, color: model.accentColor),
          const SizedBox(height: 20),
          Text(
            model.role,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.5,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            model.company,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.6),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            model.duration,
            style: TextStyle(
              color: model.accentColor,
              fontSize: 10,
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 24),
          const Divider(color: Colors.white10),
          const SizedBox(height: 24),
          ...model.achievements.take(3).map((a) => _AchievementItem(text: a)),
          const Spacer(),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: model.techStack.take(4).map((t) => _TechTag(label: t)).toList(),
          ),
        ],
      ),
    );
  }
}

class _TimelineNode extends StatefulWidget {
  final bool isCurrent;
  final Color accentColor;

  const _TimelineNode({required this.isCurrent, required this.accentColor});

  @override
  State<_TimelineNode> createState() => _TimelineNodeState();
}

class _TimelineNodeState extends State<_TimelineNode>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isCurrent) {
      return Container(
        width: 16,
        height: 16,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
              color: widget.accentColor.withValues(alpha: 0.4), width: 2),
        ),
      );
    }

    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        return Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.accentColor,
            boxShadow: [
              BoxShadow(
                color: widget.accentColor.withValues(alpha: 0.5 * (1 - _pulseController.value)),
                blurRadius: 10 + (20 * _pulseController.value),
                spreadRadius: 2 + (5 * _pulseController.value),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _AchievementItem extends StatelessWidget {
  final String text;

  const _AchievementItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 8),
            child: Icon(LucideIcons.checkCircle2,
                size: 14, color: AppColors.terminalBlue),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 15,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RoleTag extends StatelessWidget {
  final String label;
  final Color color;

  const _RoleTag({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 9,
          fontWeight: FontWeight.w900,
          letterSpacing: 2,
        ),
      ),
    );
  }
}

class _TechTag extends StatelessWidget {
  final String label;

  const _TechTag({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white.withValues(alpha: 0.4),
          fontSize: 10,
          fontWeight: FontWeight.w700,
        ),
      ),
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

class ExperienceModel {
  final String role;
  final String grade;
  final String company;
  final String duration;
  final String location;
  final bool isCurrent;
  final Color accentColor;
  final List<String> achievements;
  final List<String> techStack;

  ExperienceModel({
    required this.role,
    required this.grade,
    required this.company,
    required this.duration,
    required this.location,
    required this.isCurrent,
    required this.accentColor,
    required this.achievements,
    required this.techStack,
  });
}
