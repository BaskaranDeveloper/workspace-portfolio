import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../entities/system_app.dart';
import '../domain/app_registry.dart';
import 'package:workspace/features/about/presentation/about_view.dart';
import 'package:workspace/features/about/presentation/mobile_about.dart';

import 'package:workspace/features/contact/presentation/contact_view.dart';
import 'package:workspace/features/contact/presentation/mobile_contact.dart';

import 'package:workspace/features/education/presentation/education_view.dart';
import 'package:workspace/features/education/presentation/mobile_education.dart';

import 'package:workspace/features/experience/presentation/experience_view.dart';
import 'package:workspace/features/experience/presentation/mobile_experience.dart';

import 'package:workspace/features/projects/presentation/projects_view.dart';
import 'package:workspace/features/projects/presentation/mobile_projects.dart';

import 'package:workspace/features/resume/presentation/resume_view.dart';
import 'package:workspace/features/resume/presentation/mobile_resume.dart';

import 'package:workspace/features/settings/presentation/settings_view.dart';
import 'package:workspace/features/terminal/presentation/terminal_view.dart';

import 'package:workspace/features/terminal/presentation/mobile_terminal.dart';
import 'package:workspace/features/music/presentation/music_view.dart';

class InMemoryRegistry implements AppRegistry {
  final List<SystemApp> _apps = [
    SystemApp(
      id: 'about',
      title: 'About',
      iconPath: 'asset/icons/finder.png',
      icon: LucideIcons.user,
      themeColor: Colors.blue,
      desktopBuilder: (context) => const AboutView(),
      mobileBuilder: (context) => const MobileAboutView(),
    ),
    SystemApp(
      id: 'terminal',
      title: 'Terminal',
      iconPath: 'asset/icons/terminal.png',
      icon: LucideIcons.terminal,
      themeColor: Colors.black,
      desktopBuilder: (context) => const TerminalView(),
      mobileBuilder: (context) => const MobileTerminal(),
    ),
    SystemApp(
      id: 'projects',
      title: 'Projects',
      iconPath: 'asset/icons/project.png',
      icon: LucideIcons.folder,
      themeColor: Colors.purple,
      desktopBuilder: (context) => const ProjectsView(),
      mobileBuilder: (context) => const MobileProjects(),
    ),
    SystemApp(
      id: 'experience',
      title: 'Experience',
      iconPath: 'asset/icons/skill.png',
      icon: LucideIcons.briefcase,
      themeColor: Colors.grey,
      desktopBuilder: (context) => const ExperienceView(),
      mobileBuilder: (context) => const MobileExperience(),
    ),
    SystemApp(
      id: 'education',
      title: 'Education',
      iconPath: 'asset/icons/education.png',
      icon: LucideIcons.book,
      themeColor: Colors.green,
      desktopBuilder: (context) => const EducationView(),
      mobileBuilder: (context) => const MobileEducation(),
    ),
    SystemApp(
      id: 'contact',
      title: 'Contact',
      iconPath: 'asset/icons/contact.png',
      icon: LucideIcons.send,
      themeColor: Colors.red,
      desktopBuilder: (context) => const ContactView(),
      mobileBuilder: (context) => const MobileContact(),
    ),
    SystemApp(
      id: 'resume',
      title: 'Resume',
      iconPath: 'asset/icons/notes.png', // Using notes icon as fallback for resume doc
      icon: LucideIcons.fileText,
      themeColor: Colors.orange,
      desktopBuilder: (context) => const ResumeView(),
      mobileBuilder: (context) => const MobileResume(),
    ),
    SystemApp(
      id: 'notes',
      title: 'Notes',
      iconPath: 'asset/icons/notes.png',
      icon: LucideIcons.fileEdit,
      themeColor: Colors.yellow.shade700,
      showInDock: false,
      desktopBuilder: (context) => const Center(child: Text("Notes Coming Soon")),
      mobileBuilder: (context) => const Center(child: Text("Notes Coming Soon")),
    ),
    SystemApp(
      id: 'calculator',
      title: 'Calculator',
      icon: LucideIcons.calculator,
      themeColor: Colors.orange,
      showInDock: false,
      desktopBuilder: (context) => const Center(child: Text("Calculator Coming Soon")),
      mobileBuilder: (context) => const Center(child: Text("Calculator Coming Soon")),
    ),
    SystemApp(
      id: 'photos',
      title: 'Photos',
      icon: LucideIcons.image,
      themeColor: Colors.deepPurple,
      showInDock: false,
      desktopBuilder: (context) => const Center(child: Text("Photos Coming Soon")),
      mobileBuilder: (context) => const Center(child: Text("Photos Coming Soon")),
    ),
    SystemApp(
      id: 'calendar',
      title: 'Calendar',
      icon: LucideIcons.calendar,
      themeColor: Colors.red,
      showInDock: false,
      desktopBuilder: (context) => const Center(child: Text("Calendar Coming Soon")),
      mobileBuilder: (context) => const Center(child: Text("Calendar Coming Soon")),
    ),
    SystemApp(
      id: 'maps',
      title: 'Maps',
      icon: LucideIcons.map,
      themeColor: Colors.green,
      showInDock: false,
      desktopBuilder: (context) => const Center(child: Text("Maps Coming Soon")),
      mobileBuilder: (context) => const Center(child: Text("Maps Coming Soon")),
    ),
    SystemApp(
      id: 'music',
      title: 'Music',
      icon: LucideIcons.music,
      themeColor: Colors.pink,
      showInDock: true,
      desktopBuilder: (context) => const MusicView(),
      mobileBuilder: (context) => const MusicView(), // Can use same for now or adapt later
    ),
    SystemApp(
      id: 'safari',
      title: 'Safari',
      icon: LucideIcons.compass,
      themeColor: Colors.blue,
      showInDock: false,
      desktopBuilder: (context) => const Center(child: Text("Safari Coming Soon")),
      mobileBuilder: (context) => const Center(child: Text("Safari Coming Soon")),
    ),
    SystemApp(
      id: 'settings',
      title: 'Settings',
      icon: LucideIcons.settings,
      themeColor: Colors.grey,
      showInDock: false,
      desktopBuilder: (context) => const SettingsView(),
      mobileBuilder: (context) => const SettingsView(),
    ),
    SystemApp(
      id: 'launchpad',
      title: 'Applications',
      icon: LucideIcons.layoutGrid,
      themeColor: Colors.grey.shade800,
      desktopBuilder: (context) => const SizedBox.shrink(),
      mobileBuilder: (context) => const SizedBox.shrink(),
    ),
  ];

  @override
  List<SystemApp> get apps => List.unmodifiable(_apps);

  @override
  SystemApp? getApp(String id) {
    try {
      return _apps.firstWhere((app) => app.id == id);
    } catch (_) {
      return null;
    }
  }
}
