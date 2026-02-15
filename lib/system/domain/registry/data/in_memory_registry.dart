import 'package:flutter/material.dart';
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
      icon: Icons.person,
      themeColor: Colors.blue,
      desktopBuilder: (context) => const AboutView(),
      mobileBuilder: (context) => const MobileAboutView(),
    ),
    SystemApp(
      id: 'terminal',
      title: 'Terminal',
      icon: Icons.terminal,
      themeColor: Colors.black,
      desktopBuilder: (context) => const TerminalView(),
      mobileBuilder: (context) => const MobileTerminal(),
    ),
    SystemApp(
      id: 'projects',
      title: 'Projects',
      icon: Icons.folder,
      themeColor: Colors.purple,
      desktopBuilder: (context) => const ProjectsView(),
      mobileBuilder: (context) => const MobileProjects(),
    ),
    SystemApp(
      id: 'experience',
      title: 'Experience',
      icon: Icons.work,
      themeColor: Colors.grey,
      desktopBuilder: (context) => const ExperienceView(),
      mobileBuilder: (context) => const MobileExperience(),
    ),
    SystemApp(
      id: 'education',
      title: 'Education',
      icon: Icons.school,
      themeColor: Colors.green,
      desktopBuilder: (context) => const EducationView(),
      mobileBuilder: (context) => const MobileEducation(),
    ),
    SystemApp(
      id: 'contact',
      title: 'Contact',
      icon: Icons.mail,
      themeColor: Colors.red,
      desktopBuilder: (context) => const ContactView(),
      mobileBuilder: (context) => const MobileContact(),
    ),
    SystemApp(
      id: 'resume',
      title: 'Resume',
      icon: Icons.assignment,
      themeColor: Colors.orange,
      desktopBuilder: (context) => const ResumeView(),
      mobileBuilder: (context) => const MobileResume(),
    ),
    SystemApp(
      id: 'settings',
      title: 'Settings',
      icon: Icons.settings,
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
