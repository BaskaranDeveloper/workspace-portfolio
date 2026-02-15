import 'package:flutter/material.dart';
import 'package:workspace/shared_ui/theme/app_colors.dart';

class MobileEducation extends StatelessWidget {
  const MobileEducation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        title: const Text('Education'),
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
              'Education',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Academic background and qualifications.',
              style: TextStyle(
                color: AppColors.textPrimary.withValues(alpha: 0.6),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 32),
            _buildTimelineItem(
              degree: 'B.E. Computer Science Engineering',
              institution: 'Dhanalakshmi Srinivasan Institute of Technology',
              year: '2017 – 2021',
              location: 'Tamil Nadu, India',
              grade: '7.69 CGPA',
            ),
            const SizedBox(height: 32),
            _buildTimelineItem(
              degree: 'Higher Secondary Education',
              institution: 'State Board',
              year: '2015 – 2017',
              location: 'Tamil Nadu, India',
              grade: '67.33%',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineItem({
    required String degree,
    required String institution,
    required String year,
    required String location,
    required String grade,
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
                color: AppColors.terminalBlue,
                border: Border.all(color: AppColors.terminalBlue, width: 2),
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 2,
              height: 150,
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
                year,
                style: const TextStyle(
                  color: AppColors.terminalBlue,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                degree,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                institution,
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
              Text(
                'Grade: $grade',
                style: TextStyle(
                  color: AppColors.textPrimary.withValues(alpha: 0.9),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
