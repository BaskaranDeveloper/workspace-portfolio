import 'package:flutter/material.dart';
import 'package:workspace/app/theme/app_colors.dart';

class ProjectsView extends StatefulWidget {
  const ProjectsView({super.key});

  @override
  State<ProjectsView> createState() => _ProjectsViewState();
}

class _ProjectsViewState extends State<ProjectsView>
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 0, // Hide default toolbar
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.centerLeft,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              indicatorColor: AppColors.terminalBlue,
              labelColor: AppColors.terminalBlue,
              unselectedLabelColor: AppColors.textPrimary.withValues(
                alpha: 0.5,
              ),
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              tabs: const [
                Tab(text: 'Professional Work'),
                Tab(text: 'Personal Lab / Learning'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildProjectGrid(_workProjects),
          _buildProjectGrid(_labProjects),
        ],
      ),
    );
  }

  Widget _buildProjectGrid(List<Map<String, dynamic>> projects) {
    return GridView.builder(
      padding: const EdgeInsets.all(32),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 450,
        mainAxisSpacing: 24,
        crossAxisSpacing: 24,
        mainAxisExtent: 260,
      ),
      itemCount: projects.length,
      itemBuilder: (context, index) {
        return _buildProjectCard(projects[index]);
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
            color: accentColor.withValues(alpha: 0.1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    isWork ? 'OFFICE' : 'LAB',
                    style: TextStyle(
                      color: accentColor,
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
                      fontSize: 18,
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
                        style: TextStyle(
                          color: accentColor,
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
