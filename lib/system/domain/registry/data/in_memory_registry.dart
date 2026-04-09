import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Colors, Icons, Text, Center;
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

class InMemoryRegistry implements AppRegistry {
  final List<SystemApp> _apps = [
    SystemApp(
      id: 'about',
      title: 'About',
      icon: CupertinoIcons.person_fill,
      iconPath: 'asset/icons/finder.png',
      themeColor: Colors.blue,
      desktopBuilder: (context) => const AboutView(),
      mobileBuilder: (context) => const MobileAboutView(),
    ),
    SystemApp(
      id: 'terminal',
      title: 'Terminal',
      icon: CupertinoIcons.command,
      iconPath: 'asset/icons/terminal.png',
      themeColor: Colors.black, // Cyber Blue
      desktopBuilder: (context) => const TerminalView(),
      mobileBuilder: (context) => const MobileTerminal(),
    ),
    SystemApp(
      id: 'projects',
      title: 'Projects',
      icon: CupertinoIcons.folder_fill,
      iconPath: 'asset/icons/folder.png',
      themeColor: Colors.purple,
      desktopBuilder: (context) => const ProjectsView(),
      mobileBuilder: (context) => const MobileProjects(),
    ),
    SystemApp(
      id: 'experience',
      title: 'Experience',
      icon: CupertinoIcons.briefcase_fill,
      iconPath: 'asset/icons/experience.png',
      themeColor: Colors.grey,
      desktopBuilder: (context) => const ExperienceView(),
      mobileBuilder: (context) => const MobileExperience(),
    ),
    SystemApp(
      id: 'education',
      title: 'Education',
      icon: CupertinoIcons.book_fill,
      iconPath: 'asset/icons/education.png',
      themeColor: Colors.green,
      desktopBuilder: (context) => const EducationView(),
      mobileBuilder: (context) => const MobileEducation(),
    ),
    SystemApp(
      id: 'contact',
      title: 'Contact',
      icon: CupertinoIcons.mail,
      iconPath: 'asset/icons/contact.png',
      themeColor: Colors.red,
      desktopBuilder: (context) => const ContactView(),
      mobileBuilder: (context) => const MobileContact(),
    ),
    SystemApp(
      id: 'resume',
      title: 'Resume',
      icon: CupertinoIcons.doc_text_fill,
      iconPath: 'asset/icons/resume.png',
      themeColor: Colors.orange,
      desktopBuilder: (context) => const ResumeView(),
      mobileBuilder: (context) => const MobileResume(),
    ),
    SystemApp(
      id: 'launchpad',
      title: 'Applications',
      icon: CupertinoIcons.square_grid_2x2,
      iconPath: 'asset/icons/launchpad.png',
      themeColor: Colors.grey.shade800,
      desktopBuilder: (context) => const SizedBox.shrink(), // Will be handled as overlay
      mobileBuilder: (context) => const SizedBox.shrink(),
    ),
    SystemApp(
      id: 'calculator',
      title: 'Calculator',
      icon: CupertinoIcons.divide,
      themeColor: Colors.orange,
      showInDock: false,
      desktopBuilder: (context) => const Center(child: Text("Calculator Coming Soon")),
      mobileBuilder: (context) => const Center(child: Text("Calculator Coming Soon")),
    ),
    SystemApp(
      id: 'notes',
      title: 'Notes',
      icon: CupertinoIcons.doc_text,
      themeColor: Colors.yellow.shade700,
      showInDock: false,
      desktopBuilder: (context) => const Center(child: Text("Notes Coming Soon")),
      mobileBuilder: (context) => const Center(child: Text("Notes Coming Soon")),
    ),
    SystemApp(
      id: 'photos',
      title: 'Photos',
      icon: CupertinoIcons.photo,
      themeColor: Colors.deepPurple, // Vibrant background
      showInDock: false,
      desktopBuilder: (context) => const Center(child: Text("Photos Coming Soon")),
      mobileBuilder: (context) => const Center(child: Text("Photos Coming Soon")),
    ),
    SystemApp(
      id: 'calendar',
      title: 'Calendar',
      icon: CupertinoIcons.calendar,
      themeColor: Colors.red, // Classic red top style
      showInDock: false,
      desktopBuilder: (context) => const Center(child: Text("Calendar Coming Soon")),
      mobileBuilder: (context) => const Center(child: Text("Calendar Coming Soon")),
    ),
    SystemApp(
      id: 'maps',
      title: 'Maps',
      icon: CupertinoIcons.location_solid,
      themeColor: Colors.green,
      showInDock: false,
      desktopBuilder: (context) => const Center(child: Text("Maps Coming Soon")),
      mobileBuilder: (context) => const Center(child: Text("Maps Coming Soon")),
    ),
    SystemApp(
      id: 'music',
      title: 'Music',
      icon: CupertinoIcons.music_note_2,
      themeColor: Colors.pink,
      showInDock: false,
      desktopBuilder: (context) => const Center(child: Text("Music Coming Soon")),
      mobileBuilder: (context) => const Center(child: Text("Music Coming Soon")),
    ),
    SystemApp(
      id: 'safari',
      title: 'Safari',
      icon: CupertinoIcons.compass,
      themeColor: Colors.blue,
      showInDock: false,
      desktopBuilder: (context) => const Center(child: Text("Safari Coming Soon")),
      mobileBuilder: (context) => const Center(child: Text("Safari Coming Soon")),
    ),
    SystemApp(
      id: 'settings',
      title: 'Settings',
      icon: CupertinoIcons.settings,
      iconPath: 'asset/icons/settings.png',
      themeColor: Colors.grey,
      desktopBuilder: (context) => const SettingsView(),
      mobileBuilder: (context) => const SettingsView(),
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
