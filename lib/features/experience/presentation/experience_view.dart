import 'package:flutter/material.dart';
import 'package:workspace/shared_ui/theme/app_colors.dart';
import 'package:workspace/shared_ui/widgets/glass_container.dart';

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
      duration: const Duration(milliseconds: 1000),
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
        padding: const EdgeInsets.all(48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAnimatedItem(
              0,
              const Text(
                'Professional Journey',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1,
                ),
              ),
            ),
            const SizedBox(height: 12),
            _buildAnimatedItem(
              1,
              Text(
                'A timeline of my professional growth and technical contributions.',
                style: TextStyle(
                  color: AppColors.textPrimary.withValues(alpha: 0.6),
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 64),
            _buildAnimatedItem(
              2,
              _buildTimelineItem(
                title:
                    'Senior Software Engineer | Flutter & Full-Stack Developer',
                company: 'Trirope Technologies Pvt. Ltd.',
                duration: 'August 2022 – Present',
                location: 'Villupuram, Tamil Nadu (On-site)',
                isCurrent: true,
                skills: [
                  'Flutter',
                  'Dart',
                  'Node.js',
                  'NestJS',
                  'FastAPI',
                  'Firebase',
                  'AWS',
                ],
                points: [
                  'Lead the design and development of 10+ high-performance cross-platform applications using Flutter.',
                  'Architected scalable and maintainable system architectures across mobile and web platforms.',
                  'Developed secure and robust backend services using Node.js, NestJS, and FastAPI.',
                  'Built and integrated complex features: secure payments, real-time notifications, and advanced analytics.',
                  'Driving Agile/Scrum processes and managing version control with Git and Bitbucket.',
                  'Mentoring junior developers through code reviews and technical guidance.',
                  'Optimizing production performance and resolving critical issues for enterprise clients.',
                ],
              ),
            ),
            const SizedBox(height: 32),
            _buildAnimatedItem(
              3,
              _buildTimelineItem(
                title: 'B.E. Computer Science Engineering',
                company: 'Anna University',
                duration: '2017 – 2021',
                location: 'Tamil Nadu, India',
                isCurrent: false,
                skills: [
                  'Data Structures',
                  'Algorithms',
                  'C++',
                  'Java',
                  'Cyber Security',
                ],
                points: [
                  'Foundational training in data structures, algorithms, and software engineering principles.',
                  'Specialized in mobile application development and system security.',
                  'Completed various technical certifications including Ethical Hacking.',
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedItem(int index, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero)
          .animate(
            CurvedAnimation(
              parent: _controller,
              curve: Interval(
                index * 0.1,
                0.6 + (index * 0.1),
                curve: Curves.easeOutQuint,
              ),
            ),
          ),
      child: FadeTransition(
        opacity: Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(
              index * 0.1,
              0.6 + (index * 0.1),
              curve: Curves.easeOut,
            ),
          ),
        ),
        child: child,
      ),
    );
  }

  Widget _buildTimelineItem({
    required String title,
    required String company,
    required String duration,
    required String location,
    required List<String> points,
    required List<String> skills,
    required bool isCurrent,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline Indicator
          Column(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: isCurrent
                      ? AppColors.terminalBlue
                      : Colors.transparent,
                  border: Border.all(color: AppColors.terminalBlue, width: 2),
                  shape: BoxShape.circle,
                  boxShadow: isCurrent
                      ? [
                          BoxShadow(
                            color: AppColors.terminalBlue.withValues(
                              alpha: 0.5,
                            ),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ]
                      : null,
                ),
              ),
              Expanded(
                child: Container(
                  width: 2,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.terminalBlue.withValues(alpha: 0.5),
                        AppColors.terminalBlue.withValues(alpha: 0.0),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 32),
          // Content
          Expanded(
            child: GlassContainer(
              color: Colors.white,
              opacity: 0.05,
              blur: 10,
              borderRadius: BorderRadius.circular(20),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        duration,
                        style: const TextStyle(
                          color: AppColors.terminalBlue,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (isCurrent) ...[
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.terminalBlue.withValues(
                              alpha: 0.1,
                            ),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: AppColors.terminalBlue.withValues(
                                alpha: 0.3,
                              ),
                            ),
                          ),
                          child: const Text(
                            'PRESENT',
                            style: TextStyle(
                              color: AppColors.terminalBlue,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        company,
                        style: TextStyle(
                          color: AppColors.textPrimary.withValues(alpha: 0.8),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '•  $location',
                        style: TextStyle(
                          color: AppColors.textPrimary.withValues(alpha: 0.5),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: skills
                        .map(
                          (skill) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.terminalBlue.withValues(
                                alpha: 0.1,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: AppColors.terminalBlue.withValues(
                                  alpha: 0.2,
                                ),
                              ),
                            ),
                            child: Text(
                              skill,
                              style: const TextStyle(
                                color: AppColors.terminalBlue,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 24),
                  ...points.map(
                    (p) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: AppColors.terminalBlue.withValues(
                                  alpha: 0.5,
                                ),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              p,
                              style: TextStyle(
                                color: AppColors.textPrimary.withValues(
                                  alpha: 0.7,
                                ),
                                fontSize: 15,
                                height: 1.6,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
