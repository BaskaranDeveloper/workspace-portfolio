import 'package:flutter/material.dart';
import 'package:workspace/app/theme/app_colors.dart';

class ExperienceView extends StatelessWidget {
  const ExperienceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Professional Journey',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: -1,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'A timeline of my professional growth and technical contributions.',
              style: TextStyle(
                color: AppColors.textPrimary.withValues(alpha: 0.6),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 64),
            _buildTimelineItem(
              title:
                  'Senior Software Engineer | Flutter & Full-Stack Developer',
              company: 'Trirope Technologies Pvt. Ltd.',
              duration: 'August 2022 – Present',
              location: 'Villupuram, Tamil Nadu (On-site)',
              isCurrent: true,
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
            _buildTimelineItem(
              title: 'B.E. Computer Science Engineering',
              company: 'Anna University',
              duration: '2017 – 2021',
              location: 'Tamil Nadu, India',
              isCurrent: false,
              points: [
                'Foundational training in data structures, algorithms, and software engineering principles.',
                'Specialized in mobile application development and system security.',
                'Completed various technical certifications including Ethical Hacking.',
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineItem({
    required String title,
    required String company,
    required String duration,
    required String location,
    required List<String> points,
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
                              alpha: 0.3,
                            ),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ]
                      : null,
                ),
              ),
              Expanded(
                child: Container(width: 2, color: AppColors.widgetBorder),
              ),
            ],
          ),
          const SizedBox(width: 32),
          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 48),
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
