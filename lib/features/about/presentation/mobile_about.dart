import 'package:flutter/material.dart';
import 'package:workspace/shared_ui/theme/app_colors.dart';

class MobileAboutView extends StatelessWidget {
  const MobileAboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        title: const Text('About'),
        backgroundColor: AppColors.backgroundPrimary,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            _buildHeader(),
            const SizedBox(height: 24),

            // Contact Info Section
            _buildContactInfo(),
            const SizedBox(height: 32),

            // Professional Summary
            _buildSectionTitle('PROFESSIONAL SUMMARY'),
            const SizedBox(height: 12),
            const Text(
              'Tech Lead with 4 years of experience designing, developing, and delivering production-grade cross-platform applications using Flutter and Firebase.\n\nExperienced in building scalable applications for Android, iOS, Web, Windows, and macOS, with expertise in clean architecture, state management, REST API integration, Firebase ecosystem, authentication, payment gateway integration, push notifications, WebSocket communication, and mobile performance optimization.\n\nRecently promoted to Tech Lead, contributing to technical leadership, architecture discussions, code reviews, developer mentoring, sprint planning, and successful delivery of enterprise applications.\n\nPassionate about AI-augmented software engineering, leveraging modern AI tools including Claude Code, ChatGPT, Gemini, Cursor, Codex, Antigravity, Stitch, and Firebase Studio to accelerate development, improve software quality, automate repetitive tasks, and enhance engineering productivity.',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 15,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 32),

            // Experience Section
            _buildSectionTitle('PROFESSIONAL EXPERIENCE'),
            const SizedBox(height: 16),
            _buildExperienceItem(
              role: 'Tech Lead',
              company: 'Trirope Technologies Pvt. Ltd.',
              duration: 'May 2026 – Present',
              points: [
                'Lead the design and development of enterprise-grade Flutter applications.',
                'Drive technical discussions, architecture reviews, and engineering best practices.',
                'Review code and mentor developers to maintain high engineering standards.',
              ],
            ),
            const SizedBox(height: 16),
            _buildExperienceItem(
              role: 'Software Engineer | Flutter Developer',
              company: 'Trirope Technologies Pvt. Ltd.',
              duration: 'August 2022 – May 2026',
              points: [
                'Developed and maintained 10+ production-grade Flutter applications.',
                'Built scalable cross-platform applications using Flutter and Firebase.',
                'Integrated REST APIs, Firebase Authentication, Cloud Firestore, Cloud Messaging, payment gateways, biometric authentication, and WebSocket communication.',
              ],
            ),
            const SizedBox(height: 32),

            // Skills Section
            _buildSectionTitle('TECHNICAL SKILLS'),
            const SizedBox(height: 16),
            _buildSkillSection('Languages', [
              'Dart',
              'JavaScript',
              'TypeScript',
              'Python',
              'Java (Core)',
              'C',
            ]),
            _buildSkillSection('Mobile & Web', [
              'Flutter',
              'React.js',
              'Next.js',
              'HTML5',
              'CSS3',
            ]),
            _buildSkillSection('Firebase & DB', ['Firebase Auth', 'Firestore', 'FCM', 'PostgreSQL', 'MySQL']),
            _buildSkillSection('Backend & Tools', ['REST API', 'JWT', 'Git', 'AI Workflows']),

            const SizedBox(height: 32),

            // Education
            _buildSectionTitle('EDUCATION'),
            const SizedBox(height: 12),
            const Text(
              'B.E. Computer Science Engineering',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Dhanalakshmi Srinivasan Institute of Technology | 2017 – 2021',
              style: TextStyle(color: AppColors.terminalBlue, fontSize: 13),
            ),

            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CircleAvatar(
          radius: 50,
          backgroundColor: AppColors.terminalBlue,
          child: Icon(Icons.person, size: 50, color: Colors.white),
        ),
        const SizedBox(height: 16),
        const Text(
          'BASKARAN M',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 28,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Tech Lead | Flutter & Firebase Engineer',
          style: TextStyle(
            color: AppColors.terminalBlue,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildContactInfo() {
    return Column(
      children: [
        _buildContactItem(
          Icons.email_outlined,
          'baskarandeveloper1423@gmail.com',
        ),
        const SizedBox(height: 8),
        _buildContactItem(Icons.link_outlined, 'linkedin.com/in/baskaran-m'),
      ],
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: AppColors.terminalDim, size: 16),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            color: AppColors.textPrimary.withValues(alpha: 0.8),
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.terminalDim,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 40,
          height: 2,
          color: AppColors.terminalBlue.withValues(alpha: 0.5),
        ),
      ],
    );
  }

  Widget _buildExperienceItem({
    required String role,
    required String company,
    required String duration,
    required List<String> points,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          role,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Text(
              company,
              style: const TextStyle(
                color: AppColors.terminalBlue,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Text(
          duration,
          style: TextStyle(
            color: AppColors.textPrimary.withValues(alpha: 0.5),
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 12),
        ...points.map(
          (p) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: _buildBulletPoint(p),
          ),
        ),
      ],
    );
  }

  Widget _buildBulletPoint(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Container(
            width: 5,
            height: 5,
            decoration: const BoxDecoration(
              color: AppColors.terminalBlue,
              shape: BoxShape.circle,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: AppColors.textPrimary.withValues(alpha: 0.9),
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSkillSection(String category, List<String> skills) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            category,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: skills.map((s) => _buildSkillChip(s)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.backgroundTertiary,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: AppColors.widgetBorder.withValues(alpha: 0.5),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(color: AppColors.textPrimary, fontSize: 11),
      ),
    );
  }
}
