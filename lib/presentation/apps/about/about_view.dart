import 'package:flutter/material.dart';
import 'package:workspace/app/theme/app_colors.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            _buildHeader(),
            const SizedBox(height: 32),

            // Contact Info Section
            _buildContactInfo(),
            const SizedBox(height: 48),

            // Professional Summary
            _buildSectionTitle('PROFESSIONAL SUMMARY'),
            const SizedBox(height: 16),
            const Text(
              'Highly motivated Software Engineer with 3+ years of experience in designing, developing, and delivering enterprise-grade cross-platform applications for Android, iOS, Windows, macOS, and Web. Specialized in Flutter and full-stack development with strong expertise in building scalable, secure, and maintainable systems. Proven ability to manage complete product lifecycles in Agile environments and collaborate effectively with cross-functional teams.',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 48),

            // Experience Section
            _buildSectionTitle('PROFESSIONAL EXPERIENCE'),
            const SizedBox(height: 24),
            _buildExperienceItem(
              role: 'Software Engineer | Flutter & Full-Stack Developer',
              company: 'Trirope Technologies Pvt. Ltd.',
              duration: 'August 2022 – Present',
              points: [
                'Designed, developed, and deployed high-performance cross-platform applications using Flutter.',
                'Delivered 10+ production-ready applications from concept to deployment.',
                'Built modular, scalable, and maintainable system architecture.',
                'Developed secure backend services using Node.js, NestJS, Express, and FastAPI.',
                'Integrated authentication, payments, notifications, and analytics.',
                'Worked in Agile/Scrum teams using Jira.',
                'Managed version control using Git, Bitbucket, and SourceTree.',
                'Conducted code reviews and improved software quality.',
                'Resolved production issues and optimized application performance.',
                'Collaborated with QA, DevOps, product managers, and clients.',
              ],
            ),
            const SizedBox(height: 48),

            // Key Projects Section
            _buildSectionTitle('KEY PROJECTS'),
            const SizedBox(height: 24),
            _buildProjectGrid(),
            const SizedBox(height: 48),

            // Technical Skills Section
            _buildSectionTitle('TECHNICAL SKILLS'),
            const SizedBox(height: 24),
            _buildSkillSection('Programming', [
              'Dart (Strong)',
              'JavaScript',
              'TypeScript',
              'Python',
              'Java (Core)',
              'C',
            ]),
            _buildSkillSection('Mobile & Frontend', [
              'Flutter',
              'React.js',
              'Next.js',
              'HTML',
              'CSS',
            ]),
            _buildSkillSection('Backend & APIs', [
              'Node.js',
              'Express.js',
              'NestJS',
              'FastAPI',
              'REST APIs',
              'JWT',
            ]),
            _buildSkillSection('Databases', [
              'Firebase',
              'MySQL',
              'PostgreSQL',
            ]),
            _buildSkillSection('Platforms', [
              'Android',
              'iOS',
              'Windows',
              'macOS',
              'Web',
            ]),
            _buildSkillSection('Tools', [
              'Git',
              'GitHub',
              'Bitbucket',
              'Jira',
              'SourceTree',
              'Figma',
              'Photoshop',
              'Blender',
              'DaVinci Resolve',
            ]),
            const SizedBox(height: 48),

            // Education & Certifications
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle('EDUCATION'),
                      const SizedBox(height: 16),
                      const Text(
                        'B.E. Computer Science Engineering',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Anna University | 2017 – 2021',
                        style: TextStyle(
                          color: AppColors.terminalBlue,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 32),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle('CERTIFICATIONS'),
                      const SizedBox(height: 16),
                      _buildBulletPoint('Ethical Hacking Certification – 2022'),
                      _buildBulletPoint('Flutter Development Certification'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 48),

            // Strengths Section
            _buildSectionTitle('PROFESSIONAL STRENGTHS'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                'Strong Problem-Solving Skills',
                'Enterprise Application Development',
                'Agile Practices',
                'Client Communication',
                'Ownership & Accountability',
                'Continuous Learning',
              ].map((s) => _buildSkillChip(s)).toList(),
            ),
            const SizedBox(height: 64),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'BASKARAN M',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 42,
            fontWeight: FontWeight.bold,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Senior Software Engineer | Flutter & Full-Stack Developer',
          style: TextStyle(
            color: AppColors.terminalBlue,
            fontSize: 20,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildContactInfo() {
    return Wrap(
      spacing: 24,
      runSpacing: 12,
      children: [
        _buildContactItem(
          Icons.location_on_outlined,
          'Villupuram, Tamil Nadu, India',
        ),
        _buildContactItem(Icons.phone_outlined, '8778831267'),
        _buildContactItem(
          Icons.email_outlined,
          'baskarandeveloper1423@gmail.com',
        ),
        _buildContactItem(Icons.link_outlined, 'linkedin.com/in/baskaran-m'),
      ],
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: AppColors.terminalDim, size: 18),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            color: AppColors.textPrimary.withValues(alpha: 0.8),
            fontSize: 14,
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
            fontSize: 13,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
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
            fontSize: 18,
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
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              '|  $duration',
              style: TextStyle(
                color: AppColors.textPrimary.withValues(alpha: 0.5),
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...points.map(
          (p) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
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
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: AppColors.terminalBlue,
              shape: BoxShape.circle,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: AppColors.textPrimary.withValues(alpha: 0.9),
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProjectGrid() {
    final projects = [
      {
        'title': 'Enterprise Lottery Platform',
        'desc':
            'Scalable multi-game platform with secure payments and admin dashboards.',
        'tags': ['PSG Lotto', 'Pinas Lotto'],
      },
      {
        'title': 'Healthcare Management System',
        'desc':
            'Hospital application for appointments, patient records, and notifications.',
        'tags': ['Prashanth IVF', 'White Label'],
      },
      {
        'title': 'Media & News Platform',
        'desc':
            'Real-time news application with WebView and performance optimization.',
        'tags': ['Virakesari App'],
      },
      {
        'title': 'Matrimony Platform',
        'desc':
            'Implemented profile management, matchmaking, chat, and subscriptions.',
        'tags': ['Kaveri Matrimony'],
      },
      {
        'title': 'POS & Inventory System',
        'desc': 'Designed billing, inventory tracking, and reporting modules.',
        'tags': ['IMS'],
      },
      {
        'title': 'Astrology Application',
        'desc': 'Enhanced application performance and improved scalability.',
        'tags': ['PKG Astro'],
      },
    ];

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: projects.map((p) => _buildProjectCard(p)).toList(),
    );
  }

  Widget _buildProjectCard(Map<String, dynamic> project) {
    return Container(
      width: 340,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.widgetBackground,
        border: Border.all(color: AppColors.widgetBorder),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            project['title'],
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            project['desc'],
            style: TextStyle(
              color: AppColors.textPrimary.withValues(alpha: 0.7),
              fontSize: 13,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: (project['tags'] as List<String>)
                .map(
                  (t) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.terminalBlue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      t,
                      style: const TextStyle(
                        color: AppColors.terminalBlue,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillSection(String category, List<String> skills) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            category,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.backgroundTertiary,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: AppColors.widgetBorder.withValues(alpha: 0.5),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(color: AppColors.textPrimary, fontSize: 12),
      ),
    );
  }
}
