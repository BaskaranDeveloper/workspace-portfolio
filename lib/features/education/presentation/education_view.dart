import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:workspace/shared_ui/theme/app_colors.dart';
import 'package:workspace/shared_ui/widgets/liquid_glass.dart';

class EducationView extends StatefulWidget {
  const EducationView({super.key});

  @override
  State<EducationView> createState() => _EducationViewState();
}

class _EducationViewState extends State<EducationView>
    with SingleTickerProviderStateMixin {
  late AnimationController _entranceController;

  final List<EducationModel> _educationData = [
    EducationModel(
      degree: 'B.E. Computer Science Engineering',
      institution: 'Dhanalakshmi Srinivasan Institute of Technology',
      period: '2017 — 2021',
      location: 'Tamil Nadu • India',
      grade: '7.69 CGPA',
      accentColor: AppColors.terminalBlue,
      highlights: [
        'Specialized in Software Engineering and Mobile Architectures.',
        'Core focus on Data Structures, Algorithms, and System Design.',
        'Research involvement in Ethical Hacking and Cybersecurity.',
      ],
      isGraduate: true,
    ),
    EducationModel(
      degree: 'Higher Secondary Education',
      institution: 'State Board of Tamil Nadu',
      period: '2015 — 2017',
      location: 'Tamil Nadu • India',
      grade: '67.33% (808/1200)',
      accentColor: Colors.purpleAccent,
      highlights: [
        'Advanced Mathematics, Physics, and Computer Science.',
        'Developed foundational logical and analytical reasoning skills.',
        'Top tier performance in Computer Science core modules.',
      ],
      isGraduate: false,
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
                      children: List.generate(_educationData.length, (index) {
                        return Expanded(
                          child: _StaggeredReveal(
                            controller: _entranceController,
                            index: index,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                              child: _EducationCard(model: _educationData[index]),
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
          'ACADEMIC_RECORDS_V2',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.2),
            fontSize: 10,
            fontWeight: FontWeight.w900,
            letterSpacing: 4,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Academic Foundation',
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

class _EducationEntry extends StatelessWidget {
  final EducationModel model;
  final bool isLast;

  const _EducationEntry({required this.model, this.isLast = false});

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
              child: _EducationCard(model: model),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline() {
    return Column(
      children: [
        _TimelineNode(accentColor: model.accentColor),
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

class _EducationCard extends StatelessWidget {
  final EducationModel model;

  const _EducationCard({required this.model});

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
        mainAxisSize: MainAxisSize.min,
        children: [
          _AcademicTag(
            label: model.isGraduate ? 'ENGINEERING' : 'FOUNDATION',
            color: model.accentColor,
          ),
          const SizedBox(height: 24),
          Text(
            model.degree,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.5,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            model.institution,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.6),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                model.period,
                style: TextStyle(
                  color: model.accentColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
              _GradeBadge(grade: model.grade, color: model.accentColor),
            ],
          ),
          const SizedBox(height: 32),
          const Divider(color: Colors.white10),
          const SizedBox(height: 32),
          ...model.highlights.map((h) => _HighlightItem(text: h)),
        ],
      ),
    );
  }
}

class _TimelineNode extends StatelessWidget {
  final Color accentColor;

  const _TimelineNode({required this.accentColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
        border: Border.all(color: accentColor, width: 2),
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: 0.3),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: Icon(
          LucideIcons.graduationCap,
          size: 10,
          color: accentColor,
        ),
      ),
    );
  }
}

class _HighlightItem extends StatelessWidget {
  final String text;

  const _HighlightItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 8),
            child: Icon(LucideIcons.sparkles,
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

class _AcademicTag extends StatelessWidget {
  final String label;
  final Color color;

  const _AcademicTag({required this.label, required this.color});

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

class _GradeBadge extends StatelessWidget {
  final String grade;
  final Color color;

  const _GradeBadge({required this.grade, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(LucideIcons.award, size: 12, color: color),
          const SizedBox(width: 8),
          Text(
            grade,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
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
    final start = index * 0.15;
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

class EducationModel {
  final String degree;
  final String institution;
  final String period;
  final String location;
  final String grade;
  final Color accentColor;
  final List<String> highlights;
  final bool isGraduate;

  EducationModel({
    required this.degree,
    required this.institution,
    required this.period,
    required this.location,
    required this.grade,
    required this.accentColor,
    required this.highlights,
    required this.isGraduate,
  });
}
