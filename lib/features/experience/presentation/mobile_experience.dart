import 'package:flutter/material.dart';
import 'package:workspace/shared_ui/theme/app_colors.dart';

class MobileExperience extends StatelessWidget {
  const MobileExperience({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        title: const Text('Experience'),
        backgroundColor: AppColors.backgroundPrimary,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Professional Journey',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'A timeline of my professional growth.',
              style: TextStyle(
                color: AppColors.textPrimary.withValues(alpha: 0.6),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 32),
            _buildTimelineItem(
              title: 'Senior Software Engineer\nFlutter & Full-Stack',
              company: 'Trirope Technologies',
              duration: 'August 2022 – Present',
              location: 'Chennai, Tamil Nadu',
              isCurrent: true,
              skills: ['Flutter', 'Node.js', 'NestJS', 'FastAPI', 'AWS'],
              points: [
                'Lead 10+ cross-platform apps.',
                'Architected scalable systems.',
                'Built secure backend services.',
                'Mentored junior developers.',
              ],
            ),
            const SizedBox(height: 32),
            _buildTimelineItem(
              title: 'B.E. Computer Science',
              company: 'Anna University',
              duration: '2017 – 2021',
              location: 'Tamil Nadu, India',
              isCurrent: false,
              skills: ['C++', 'Java', 'Algorithms'],
              points: [
                'Specialized in mobile dev.',
                'Completed ethical hacking cert.',
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
    required List<String> skills,
    required bool isCurrent,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline Line
        Column(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: isCurrent ? AppColors.terminalBlue : Colors.transparent,
                border: Border.all(color: AppColors.terminalBlue, width: 2),
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 2,
              height: 300, // Fixed height or constrained by parent?
              // To make it dynamic in a Row, we typically use IntrinsicHeight or Stack.
              // For simplicity in mobile view, we can let the line extend.
              // Here I'll just use a Container with a long height or strictly follow content.
              // A better way for simple lists is just a left border on the content container.
              color: AppColors.terminalBlue.withValues(alpha: 0.3),
            ),
          ],
        ),
        const SizedBox(width: 16),

        // Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                duration,
                style: const TextStyle(
                  color: AppColors.terminalBlue,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                company,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                location,
                style: TextStyle(
                  color: AppColors.textPrimary.withValues(alpha: 0.5),
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: skills
                    .map(
                      (s) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.terminalBlue.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          s,
                          style: const TextStyle(
                            color: AppColors.terminalBlue,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 12),
              ...points.map(
                (p) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '• ',
                        style: TextStyle(color: AppColors.terminalBlue),
                      ),
                      Expanded(
                        child: Text(
                          p,
                          style: TextStyle(
                            color: AppColors.textPrimary.withValues(alpha: 0.7),
                            fontSize: 14,
                            height: 1.4,
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
      ],
    );
  }
}
