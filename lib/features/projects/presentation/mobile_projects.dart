import 'package:flutter/material.dart';
import 'package:workspace/shared_ui/theme/app_colors.dart';

class MobileProjects extends StatefulWidget {
  const MobileProjects({super.key});

  @override
  State<MobileProjects> createState() => _MobileProjectsState();
}

class _MobileProjectsState extends State<MobileProjects>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _workProjects = [
    {
      'title': 'Enterprise Lottery Platform',
      'role': 'Lead Developer',
      'desc':
          'A high-scale multi-game lottery platform handling thousands of concurrent users. Built with Flutter for cross-platform availability.',
      'tech': ['Flutter', 'Riverpod', 'WebSocket'],
      'isWork': true,
    },
    {
      'title': 'Healthcare Management System',
      'role': 'Software Engineer',
      'desc':
          'Comprehensive hospital management app with appointment scheduling, patient records, and real-time doctor availability.',
      'tech': ['Flutter', 'Firebase', 'REST API'],
      'isWork': true,
    },
    {
      'title': 'Virakesari Media App',
      'role': 'Flutter Developer',
      'desc':
          'Official mobile application for a leading media house, featuring offline reading, push notifications, and optimized content delivery.',
      'tech': ['Flutter', 'SQLite', 'Push Notifications'],
      'isWork': true,
    },
    {
      'title': 'Kaveri Matrimony',
      'role': 'Full-Stack Developer',
      'desc':
          'Matchmaking platform with complex search algorithms and real-time chat functionality.',
      'tech': ['Flutter', 'Provider', 'Socket.io'],
      'isWork': true,
    },
    {
      'title': 'POS & Inventory System',
      'role': 'System Architect',
      'desc':
          'Desktop-first Point of Sale system with thermal printer integration and offline-first architecture.',
      'tech': ['Flutter Desktop', 'SQLite', 'Bloc'],
      'isWork': true,
    },
  ];

  final List<Map<String, dynamic>> _labProjects = [
    {
      'title': 'Node.js Backend Experiments',
      'role': 'Learning Journey',
      'desc':
          'Exploring Node.js runtime, event loop, and building scalable RESTful APIs. Focusing on understanding the core concepts of asynchronous programming.',
      'tech': ['Node.js', 'JavaScript', 'HTTP'],
      'isWork': false,
    },
    {
      'title': 'Express.js API Starter',
      'role': 'Backend Beginner',
      'desc':
          'A boilerplate API structure with Express, featuring middleware implementation, routing, and basic authentication flows.',
      'tech': ['Express.js', 'JWT', 'Middleware'],
      'isWork': false,
    },
    {
      'title': 'Next.js Dashboard',
      'role': 'Frontend + Backend',
      'desc':
          'Experimenting with Server Side Rendering (SSR) and Static Site Generation (SSG). Building a dashboard to visualize data.',
      'tech': ['Next.js', 'React', 'Tailwind'],
      'isWork': false,
    },
    {
      'title': 'Database Connector',
      'role': 'Integration',
      'desc':
          'Writing scripts to connect and perform CRUD operations on MongoDB and PostgreSQL. Understanding ORMs and raw queries.',
      'tech': ['MongoDB', 'PostgreSQL', 'Mongoose'],
      'isWork': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        title: const Text('Projects'),
        backgroundColor: AppColors.backgroundPrimary,
        elevation: 0,
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.terminalBlue,
          labelColor: AppColors.terminalBlue,
          unselectedLabelColor: AppColors.textPrimary.withValues(alpha: 0.5),
          tabs: const [
            Tab(text: 'Work'),
            Tab(text: 'Lab'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildProjectList(_workProjects),
          _buildProjectList(_labProjects),
        ],
      ),
    );
  }

  Widget _buildProjectList(List<Map<String, dynamic>> projects) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: projects.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _buildProjectCard(projects[index]),
        );
      },
    );
  }

  Widget _buildProjectCard(Map<String, dynamic> project) {
    final bool isWork = project['isWork'];
    final Color accentColor = isWork
        ? AppColors.terminalBlue
        : Colors.orangeAccent;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.widgetBackground,
        border: Border.all(color: AppColors.widgetBorder),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: accentColor.withOpacity(0.1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isWork ? 'OFFICE' : 'LAB',
                  style: TextStyle(
                    color: accentColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  project['role'],
                  style: TextStyle(
                    color: AppColors.textPrimary.withOpacity(0.6),
                    fontSize: 11,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),

          // Body
          Padding(
            padding: const EdgeInsets.all(16),
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
                    color: AppColors.textPrimary.withOpacity(0.7),
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: (project['tech'] as List<String>).map((t) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: accentColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        t,
                        style: TextStyle(
                          color: accentColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
