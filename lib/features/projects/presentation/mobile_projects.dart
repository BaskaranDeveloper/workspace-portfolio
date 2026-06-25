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

  final List<Map<String, dynamic>> _projects = [
    {
      'title': 'ENTERPRISE LOTTO CORE',
      'role': 'LEAD ARCHITECT',
      'desc':
          'High-concurrency lottery engine supporting 2D, 4D, 6D, and complex combination series. Implemented real-time draw synchronization and high-stakes digital wallet management.',
      'tech': ['Flutter', 'Riverpod', 'Socket.io', 'Redis'],
      'isWork': true,
      'accentColor': Colors.purpleAccent,
    },
    {
      'title': 'VIRAKESARI NEWS SYSTEM',
      'role': 'SR. DEVELOPER',
      'desc':
          'Full-stack media delivery system with Admin Panel and Firebase backend for real-time news reporting and high-volume push notifications.',
      'tech': ['Flutter', 'Firebase', 'Node.js', 'FCM'],
      'isWork': true,
      'accentColor': Colors.deepPurpleAccent,
    },
    {
      'title': 'CLINICAL WORKFLOW ERP',
      'role': 'FULL-STACK ENGINEER',
      'desc':
          'Whitelabel hospital management system architected for HIPAA-aligned record sync and complex patient scheduling workflows.',
      'tech': ['Flutter', 'Clean Arch', 'REST', 'FCM'],
      'isWork': true,
      'accentColor': Colors.indigoAccent,
    },
    {
      'title': 'RETAIL IMS / POS CORE',
      'role': 'MODULE LEAD',
      'desc':
          'Windows-based POS system with thermal printing and multi-store inventory sync. Optimized for low-latency retail environments.',
      'tech': ['Flutter Desktop', 'ObjectBox', 'IO'],
      'isWork': true,
      'accentColor': Colors.purple,
    },
    {
      'title': 'MATRIMONY_SERVICE_IOS',
      'role': 'SR. FLUTTER DEV',
      'desc':
          'High-fidelity iOS matchmaking experience with premium UI aesthetics and complex discovery algorithms.',
      'tech': ['Flutter', 'iOS Core', 'Match Algo'],
      'isWork': true,
      'accentColor': Colors.pinkAccent,
    },
    {
      'title': 'PLG ASTRO OPTIMIZATION',
      'role': 'PERFORMANCE LEAD',
      'desc':
          'iOS-specific rendering and calculation optimization. Reduced app-level latency by 40% through profiling.',
      'tech': ['Profiling', 'Asset Opt', 'Memory'],
      'isWork': true,
      'accentColor': Colors.amberAccent,
    },
    {
      'title': 'PINAS LOTTO 2.0',
      'role': 'NETWORK ARCHITECT',
      'desc':
          'Advanced lottery revamp with high-reliability FCM handling and scalable regional game logic.',
      'tech': ['FCM', 'Socket Sync', 'Regional Engine'],
      'isWork': true,
      'accentColor': Colors.orangeAccent,
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
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.black,
            expandedHeight: 120,
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'PROJECT_REPOSITORY',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 4,
                  color: Colors.white.withValues(alpha: 0.5),
                ),
              ),
              centerTitle: true,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: _buildProjectCard(_projects[index]),
                ),
                childCount: _projects.length,
              ),
            ),
          ),
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
    final Color accentColor = project['accentColor'];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: accentColor.withValues(alpha: 0.2)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: accentColor.withValues(alpha: 0.1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'SENIOR_PORTFOLIO',
                  style: TextStyle(
                    color: accentColor,
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
                Text(
                  project['role'],
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.4),
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  project['title'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  project['desc'],
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: (project['tech'] as List<String>).map((t) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: accentColor.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: accentColor.withValues(alpha: 0.1)),
                      ),
                      child: Text(
                        t,
                        style: TextStyle(
                          color: accentColor.withValues(alpha: 0.8),
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
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
