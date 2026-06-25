import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:workspace/shared_ui/theme/app_colors.dart';
import 'package:workspace/shared_ui/widgets/liquid_glass.dart';
import 'package:workspace/features/education/presentation/education_view.dart';

class MobileEducation extends StatelessWidget {
  const MobileEducation({super.key});

  @override
  Widget build(BuildContext context) {
    final List<EducationModel> educationData = [
      EducationModel(
        degree: 'B.E. Computer Science Engineering',
        institution: 'Dhanalakshmi Srinivasan Institute',
        period: '2017 — 2021',
        location: 'Tamil Nadu • India',
        grade: '7.69 CGPA',
        accentColor: AppColors.terminalBlue,
        highlights: [
          'Software Engineering focus.',
          'Mobile & System architecture.',
          'Cybersecurity research.',
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
          'Advanced Mathematics & CS.',
          'Logical reasoning skills.',
          'Top tier performance in core.',
        ],
        isGraduate: false,
      ),
    ];

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
                'EDUCATION',
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
                  return _MobileEducationEntry(
                    model: educationData[index],
                    isLast: index == educationData.length - 1,
                  );
                },
                childCount: educationData.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MobileEducationEntry extends StatelessWidget {
  final EducationModel model;
  final bool isLast;

  const _MobileEducationEntry({required this.model, this.isLast = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
                border: Border.all(color: model.accentColor, width: 2),
              ),
              child: Center(
                child: Icon(LucideIcons.graduationCap, size: 6, color: model.accentColor),
              ),
            ),
            const SizedBox(width: 16),
            Text(
              model.period,
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
                padding: const EdgeInsets.only(left: 6),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              model.isGraduate ? 'ENGINEERING' : 'FOUNDATION',
                              style: TextStyle(
                                color: model.accentColor,
                                fontSize: 8,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 2,
                              ),
                            ),
                            Text(
                              model.grade,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          model.degree,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          model.institution,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.6),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ...model.highlights.map((h) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 6),
                                child: Icon(LucideIcons.sparkles, size: 10, color: AppColors.terminalBlue),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  h,
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
