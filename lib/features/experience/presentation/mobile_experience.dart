import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:workspace/shared_ui/theme/app_colors.dart';
import 'package:workspace/shared_ui/widgets/liquid_glass.dart';
import 'package:workspace/features/experience/presentation/experience_view.dart';

class MobileExperience extends StatelessWidget {
  const MobileExperience({super.key});

  @override
  Widget build(BuildContext context) {
    // Sharing the same data structure as the main view
    final List<ExperienceModel> experienceData = [
    ExperienceModel(
      role: 'Software Engineer | Flutter Developer',
      grade: 'EXECUTIVE',
      company: 'Trirope Technologies Pvt. Ltd.',
      duration: 'AUG 2022 — PRESENT',
      location: 'Tamil Nadu • India',
      isCurrent: true,
      accentColor: AppColors.terminalBlue,
      achievements: [
        'Developed and maintained 10+ production-grade Flutter applications.',
        'Integrated Firebase services, REST APIs, and real-time features.',
        'Implemented biometric auth, push notifications, and low-latency sockets.',
        'Optimized application performance and applied clean architecture.',
        'Utilized AI-assisted engineering workflows for productivity.',
      ],
      techStack: ['Flutter', 'Firebase', 'Dart', 'REST API', 'Git', 'AI Workflows'],
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
        'Specialized in mobile application development.',
        'Research in Ethical Hacking and Network Security.',
        'Maintained CGPA of 7.69.',
      ],
      techStack: ['Dart', 'Java', 'C++', 'SQL', 'Algorithms'],
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
        'Focused on Mathematics and Computer Science.',
        'Strong foundation in software fundamentals.',
        'Graduated with 67.33% (808/1200) score.',
      ],
      techStack: ['Physics', 'Mathematics', 'C Programming'],
    ),
  ];

    return Scaffold(
      backgroundColor: Colors.black, // Dark background for mobile depth
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.black,
            expandedHeight: 120,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'EXPERIENCE',
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
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return _MobileExperienceEntry(
                    model: experienceData[index],
                    isLast: index == experienceData.length - 1,
                  );
                },
                childCount: experienceData.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MobileExperienceEntry extends StatelessWidget {
  final ExperienceModel model;
  final bool isLast;

  const _MobileExperienceEntry({required this.model, this.isLast = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: model.accentColor,
                boxShadow: [
                  BoxShadow(
                    color: model.accentColor.withValues(alpha: 0.3),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Text(
              model.duration,
              style: TextStyle(
                color: model.accentColor,
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
        IntrinsicHeight(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Container(
                  width: 1,
                  color: model.accentColor.withValues(alpha: 0.1),
                ),
              ),
              const SizedBox(width: 22),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: LiquidGlass(
                    intensity: 0.7,
                    borderRadius: 16,
                    padding: const EdgeInsets.all(24),
                    accentColor: model.accentColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.grade,
                          style: TextStyle(
                            color: model.accentColor,
                            fontSize: 8,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          model.role,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          model.company,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.6),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ...model.achievements.map((a) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 6),
                                child: Icon(LucideIcons.checkCircle2, size: 10, color: AppColors.terminalBlue),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  a,
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.6),
                                    fontSize: 12,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
