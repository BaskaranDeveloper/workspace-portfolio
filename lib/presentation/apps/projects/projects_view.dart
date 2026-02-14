import 'package:flutter/material.dart';
import 'package:workspace/app/theme/app_colors.dart';

class ProjectsView extends StatefulWidget {
  const ProjectsView({super.key});

  @override
  State<ProjectsView> createState() => _ProjectsViewState();
}

class _ProjectsViewState extends State<ProjectsView> {
  final List<Map<String, dynamic>> _allProjects = [
    {
      'title': 'Enterprise Lottery Platform',
      'category': 'Full-Stack',
      'desc':
          'A high-scale multi-game lottery platform (PSG Lotto, Pinas Lotto, 2D/3D, 6-Digit). Features secure payment integration, real-time results, and comprehensive admin dashboards.',
      'tech': ['Flutter', 'Node.js', 'NestJS', 'PostgreSQL', 'Redis'],
      'role': 'Lead Developer',
    },
    {
      'title': 'Healthcare Management System',
      'category': 'Mobile',
      'desc':
          'White-label hospital application built for Prashanth IVF. Includes appointment scheduling, electronic patient records, real-time notifications, and medicine tracking.',
      'tech': ['Flutter', 'Firebase', 'Node.js', 'REST API'],
      'role': 'Software Engineer',
    },
    {
      'title': 'Virakesari Media App',
      'category': 'Mobile',
      'desc':
          'Real-time news application for a leading media house. Features WebView integration, performance optimization for low-end devices, and push notification system.',
      'tech': ['Flutter', 'WebView', 'PHP', 'MySQL', 'Firebase'],
      'role': 'Flutter Developer',
    },
    {
      'title': 'Kaveri Matrimony',
      'category': 'Mobile',
      'desc':
          'A feature-rich matchmaking platform with profile management, advanced search algorithms, real-time chat, and subscription-based access.',
      'tech': ['Flutter', 'Node.js', 'Express', 'MySQL', 'Socket.io'],
      'role': 'Full-Stack Developer',
    },
    {
      'title': 'POS & Inventory System',
      'category': 'Web/Desktop',
      'desc':
          'Enterprise IMS for small and medium businesses. Manages billing, inventory tracking, sales reporting, and thermal printer integration.',
      'tech': ['Flutter', 'Node.js', 'SQLite', 'FastAPI'],
      'role': 'System Architect',
    },
    {
      'title': 'PKG Astro',
      'category': 'Mobile',
      'desc':
          'Astrology consultation platform. Enhanced application performance and implemented scalable backend services for daily horoscope delivery.',
      'tech': ['Flutter', 'Firebase', 'Python', 'FastAPI'],
      'role': 'Performance Optimizer',
    },
  ];

  late List<Map<String, dynamic>> _filteredProjects;
  String _selectedCategory = 'All';
  final List<String> _categories = [
    'All',
    'Mobile',
    'Full-Stack',
    'Web/Desktop',
  ];

  @override
  void initState() {
    super.initState();
    _filteredProjects = _allProjects;
  }

  void _filterProjects(String category) {
    setState(() {
      _selectedCategory = category;
      if (category == 'All') {
        _filteredProjects = _allProjects;
      } else {
        _filteredProjects = _allProjects
            .where((p) => p['category'] == category)
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filter Bar
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.widgetBorder)),
            ),
            child: Row(
              children: _categories.map((c) => _buildFilterChip(c)).toList(),
            ),
          ),

          // Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(32),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 450,
                mainAxisSpacing: 24,
                crossAxisSpacing: 24,
                mainAxisExtent: 280,
              ),
              itemCount: _filteredProjects.length,
              itemBuilder: (context, index) {
                return _buildProjectCard(_filteredProjects[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String category) {
    final isSelected = _selectedCategory == category;
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: InkWell(
        onTap: () => _filterProjects(category),
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.terminalBlue
                : AppColors.backgroundSecondary,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected
                  ? AppColors.terminalBlue
                  : AppColors.widgetBorder,
            ),
          ),
          child: Text(
            category,
            style: TextStyle(
              color: isSelected ? Colors.white : AppColors.textPrimary,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProjectCard(Map<String, dynamic> project) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.widgetBackground,
        border: Border.all(color: AppColors.widgetBorder),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: AppColors.backgroundTertiary.withValues(alpha: 0.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.terminalBlue.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    project['category'],
                    style: const TextStyle(
                      color: AppColors.terminalBlue,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  project['role'],
                  style: TextStyle(
                    color: AppColors.textPrimary.withValues(alpha: 0.5),
                    fontSize: 11,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project['title'],
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    project['desc'],
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.textPrimary.withValues(alpha: 0.7),
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  const Spacer(),
                  // Tech Tags
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: (project['tech'] as List<String>).take(4).map((
                      t,
                    ) {
                      return Text(
                        '#$t',
                        style: const TextStyle(
                          color: AppColors.terminalBlue,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    }).toList(),
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
