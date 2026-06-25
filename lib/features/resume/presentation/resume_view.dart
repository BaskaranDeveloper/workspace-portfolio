import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ResumeView extends StatelessWidget {
  const ResumeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0E0E0),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _downloadResume,
        icon: const Icon(Icons.download),
        label: const Text('Download PDF'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Container(
            width: 800,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            padding: const EdgeInsets.all(72), // Generous padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Center(
                  child: Column(
                    children: [
                      SelectableText(
                        'BASKARAN M',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                          letterSpacing: 1.2,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SelectableText(
                        'Tech Lead | Flutter & Firebase Engineer',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SelectableText(
                        'Villupuram, Tamil Nadu, India | 8778831267 | baskarandeveloper1423@gmail.com',
                        style: TextStyle(fontSize: 15, color: Colors.black87),
                      ),
                      const SizedBox(height: 4),
                      SelectableText(
                        'linkedin.com/in/baskaran-m',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF0077B5), // LinkedIn Blue
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 48),

                // Professional Summary
                _buildSectionHeader('PROFESSIONAL SUMMARY'),
                const SizedBox(height: 16),
                SelectableText(
                  'Tech Lead with 4 years of experience designing, developing, and delivering production-grade cross-platform applications using Flutter and Firebase.\n\nExperienced in building scalable applications for Android, iOS, Web, Windows, and macOS, with expertise in clean architecture, state management, REST API integration, Firebase ecosystem, authentication, payment gateway integration, push notifications, WebSocket communication, and mobile performance optimization.\n\nRecently promoted to Tech Lead, contributing to technical leadership, architecture discussions, code reviews, developer mentoring, sprint planning, and successful delivery of enterprise applications.\n\nPassionate about AI-augmented software engineering, leveraging modern AI tools including Claude Code, ChatGPT, Gemini, Cursor, Codex, Antigravity, Stitch, and Firebase Studio to accelerate development, improve software quality, automate repetitive tasks, and enhance engineering productivity.',
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.6,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 32),

                // Core Skills
                _buildSectionHeader('CORE SKILLS'),
                const SizedBox(height: 16),
                SelectableText(
                  'Flutter • Firebase • Dart • REST APIs • Clean Architecture • State Management (Riverpod/Provider) • Push Notifications • Payment Gateway Integration • Real-Time Features • Performance Optimization • Git • Agile Development • Cross-Platform Development • UI Optimization • AI-Assisted Development Workflows',
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.6,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),

                // Technical Skills
                _buildSectionHeader('TECHNICAL SKILLS'),
                const SizedBox(height: 16),
                _buildSkillRow('Languages', 'Dart, JavaScript, TypeScript, Python, Java (Core), C'),
                _buildSkillRow('Mobile & Web', 'Flutter, React.js, Next.js, HTML5, CSS3'),
                _buildSkillRow('Firebase', 'Firebase Auth, Firestore, Realtime DB, FCM, Crashlytics, Storage'),
                _buildSkillRow('Backend & DB', 'REST APIs, JWT, PostgreSQL, MySQL'),
                _buildSkillRow('Tools', 'Git, GitHub, Jira, Figma, Cursor, Antigravity, Claude Code'),
                const SizedBox(height: 32),

                // Professional Experience
                _buildSectionHeader('PROFESSIONAL EXPERIENCE'),
                const SizedBox(height: 16),
                _buildJobHeader(
                  'Tech Lead',
                  'Trirope Technologies Pvt. Ltd.',
                  'May 2026 – Present',
                ),
                const SizedBox(height: 12),
                _buildBulletPoint('Lead the design and development of enterprise-grade Flutter applications.'),
                _buildBulletPoint('Drive technical discussions, architecture reviews, and engineering best practices.'),
                _buildBulletPoint('Review code and mentor developers to maintain high engineering standards.'),
                _buildBulletPoint('Improve engineering productivity using AI-assisted development workflows.'),
                const SizedBox(height: 16),
                _buildJobHeader(
                  'Software Engineer | Flutter Developer',
                  'Trirope Technologies Pvt. Ltd.',
                  'August 2022 – May 2026',
                ),
                const SizedBox(height: 12),
                _buildBulletPoint('Developed and maintained 10+ production-grade Flutter applications across Android, iOS, Web, Windows, and macOS.'),
                _buildBulletPoint('Built scalable cross-platform applications using Flutter and Firebase.'),
                _buildBulletPoint('Integrated REST APIs, Firebase Authentication, Cloud Firestore, Cloud Messaging, payment gateways, biometric authentication, and WebSocket communication.'),
                _buildBulletPoint('Optimized application performance and responsiveness across multiple platforms.'),
                const SizedBox(height: 32),

                // Key Projects
                _buildSectionHeader('KEY PROJECTS'),
                const SizedBox(height: 16),
                SelectableText(
                  'Projects developed and maintained for enterprise and consumer-focused clients using Flutter and Firebase ecosystem.',
                  style: TextStyle(fontSize: 15, color: Colors.black87),
                ),
                const SizedBox(height: 12),
                _buildProjectItem('Enterprise Lottery Platform', 'Developed scalable multi-game Flutter applications with secure authentication, payment integration, and admin features.'),
                _buildProjectItem('Healthcare Management System', 'Built healthcare applications for appointments, patient records, and notification management.'),
                _buildProjectItem('Media & News Platform', 'Developed real-time news platform with WebView integration and optimized application performance.'),
                _buildProjectItem('Matrimony Platform', 'Implemented profile management, matchmaking, subscriptions, and chat functionality.'),
                _buildProjectItem('POS & Inventory System', 'Designed billing systems, inventory tracking modules, and reporting features.'),
                const SizedBox(height: 32),

                // Education
                _buildSectionHeader('EDUCATION'),
                const SizedBox(height: 16),
                // College
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SelectableText(
                        'B.E. Computer Science Engineering',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SelectableText(
                      '2017 – 2021',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                SelectableText(
                  'Dhanalakshmi Srinivasan Institute of Technology',
                  style: TextStyle(
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                SelectableText(
                  'CGPA: 7.69',
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
                const SizedBox(height: 16),

                // School
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SelectableText(
                        'Higher Secondary Education',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SelectableText(
                      '2015 – 2017',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                SelectableText(
                  'State Board',
                  style: TextStyle(
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                SelectableText(
                  'Grade: 67.33% (808/1200)',
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
                const SizedBox(height: 32),

                // Certifications & Strengths split if space allows, or stacked
                _buildSectionHeader('CERTIFICATIONS'),
                const SizedBox(height: 12),
                _buildBulletPoint('Ethical Hacking Certification – 2022'),
                _buildBulletPoint(
                  'Flutter Development Certification',
                ),
                const SizedBox(height: 32),

                // Professional Strengths
                _buildSectionHeader('STRENGTHS'),
                const SizedBox(height: 12),
                SelectableText(
                  'Problem-Solving • Clean Architecture • Flutter Development • Firebase Integration • Performance Optimization • Agile Collaboration • Ownership & Accountability • Fast Learning',
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.6,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 32),

                // Additional Value
                _buildSectionHeader('ADDITIONAL VALUE'),
                const SizedBox(height: 12),
                _buildBulletPoint('Experience working on enterprise-scale Flutter applications.'),
                _buildBulletPoint('Strong understanding of scalable mobile UI development and reusable architecture.'),
                _buildBulletPoint('Familiar with backend concepts and API integration workflows.'),
                _buildBulletPoint('Comfortable adapting modern AI tools to improve engineering productivity and delivery speed.'),
                _buildBulletPoint('Continuously learning advanced software engineering practices and scalable application development.'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: Colors.black, // Stark black for contrast
          ),
        ),
        const SizedBox(height: 6),
        Container(height: 1.5, width: double.infinity, color: Colors.black),
      ],
    );
  }

  Widget _buildSkillRow(String category, String skills) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: SelectableText(
              '$category:',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: SelectableText(
              skills,
              style: const TextStyle(fontSize: 15, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJobHeader(String role, String company, String duration) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SelectableText(
                role,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            SelectableText(
              duration,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        SelectableText(
          company,
          style: const TextStyle(
            fontSize: 16,
            fontStyle: FontStyle.italic,
            color: Colors.black87, // Slightly lighter than pure black
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SelectableText(
            '• ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.black,
            ),
          ),
          Expanded(
            child: SelectableText(
              text,
              style: const TextStyle(fontSize: 15, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectItem(String title, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          SelectableText(
            desc,
            style: const TextStyle(fontSize: 15, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  Future<void> _downloadResume() async {
    await Printing.layoutPdf(
      onLayout: (format) async => _generatePdf(format),
      name: 'Baskaran_M_Resume.pdf',
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    final pdf = pw.Document();

    // Load fonts
    final font = await PdfGoogleFonts.openSansRegular();
    final fontBold = await PdfGoogleFonts.openSansBold();
    final fontItalic = await PdfGoogleFonts.openSansItalic();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: format,
        theme: pw.ThemeData.withFont(
          base: font,
          bold: fontBold,
          italic: fontItalic,
        ),
        build: (pw.Context context) {
          return [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Header
                pw.Center(
                  child: pw.Column(
                    children: [
                      pw.Text(
                        'BASKARAN M',
                        style: pw.TextStyle(
                          fontSize: 30,
                          fontWeight: pw.FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      pw.SizedBox(height: 6),
                      pw.Text(
                        'Tech Lead | Flutter & Firebase Engineer',
                        style: pw.TextStyle(
                          fontSize: 14,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.black,
                        ),
                      ),
                      pw.SizedBox(height: 6),
                      pw.Text(
                        'Villupuram, Tamil Nadu, India | 8778831267 | baskarandeveloper1423@gmail.com',
                        style: const pw.TextStyle(
                          fontSize: 11,
                          color: PdfColors.black,
                        ),
                      ),
                      pw.SizedBox(height: 4),
                      pw.Text(
                        'linkedin.com/in/baskaran-m',
                        style: const pw.TextStyle(
                          fontSize: 11,
                          color: PdfColors.blue800,
                          decoration: pw.TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 24),

                // Summary
                _buildPdfSectionHeader('PROFESSIONAL SUMMARY'),
                pw.SizedBox(height: 8),
                pw.Text(
                  'Tech Lead with 4 years of experience designing, developing, and delivering production-grade cross-platform applications using Flutter and Firebase.\n\nExperienced in building scalable applications for Android, iOS, Web, Windows, and macOS, with expertise in clean architecture, state management, REST API integration, Firebase ecosystem, authentication, payment gateway integration, push notifications, WebSocket communication, and mobile performance optimization.\n\nRecently promoted to Tech Lead, contributing to technical leadership, architecture discussions, code reviews, developer mentoring, sprint planning, and successful delivery of enterprise applications.',
                  style: const pw.TextStyle(fontSize: 11, lineSpacing: 1.5),
                  textAlign: pw.TextAlign.justify,
                ),
                pw.SizedBox(height: 20),

                // AI Lifecycle
                _buildPdfSectionHeader('END-TO-END AI PRODUCT LIFECYCLE'),
                pw.SizedBox(height: 8),
                _buildPdfSkillRow('Strategy', 'Claude 3.5 Sonnet, OpenAI o1, Perplexity'),
                _buildPdfSkillRow('Gen UI', 'v0.dev, Stitch (Flutter), Midjourney'),
                _buildPdfSkillRow('Agentic Dev', 'Antigravity (Orchestration), Cursor, Firebase Studio'),
                _buildPdfSkillRow('Ops/Auto', 'n8n (Workflows), Custom MCP Servers'),
                pw.SizedBox(height: 20),

                // Skills
                _buildPdfSectionHeader('TECHNICAL SKILLS'),
                pw.SizedBox(height: 8),
                _buildPdfSkillRow(
                  'Programming',
                  'Dart (Strong), JavaScript, TypeScript, Python, Java (Core), C',
                ),
                _buildPdfSkillRow(
                  'Mobile & Frontend',
                  'Flutter, React.js, Next.js, HTML, CSS',
                ),
                _buildPdfSkillRow(
                  'Backend & APIs',
                  'Node.js, Express.js, NestJS, FastAPI, REST APIs, JWT',
                ),
                _buildPdfSkillRow('Databases', 'Firebase, MySQL, PostgreSQL'),
                _buildPdfSkillRow(
                  'Platforms',
                  'Android, iOS, Windows, macOS, Web',
                ),
                _buildPdfSkillRow(
                  'Tools',
                  'Git, GitHub, Bitbucket, Jira, SourceTree, Figma, Photoshop, Blender',
                ),
                pw.SizedBox(height: 20),

                // Experience
                _buildPdfSectionHeader('PROFESSIONAL EXPERIENCE'),
                pw.SizedBox(height: 8),
                _buildPdfJobHeader(
                  'Tech Lead',
                  'Trirope Technologies Pvt. Ltd.',
                  'May 2026 – Present',
                ),
                pw.SizedBox(height: 6),
                _buildPdfBullet('Lead the design and development of enterprise-grade Flutter applications.'),
                _buildPdfBullet('Drive technical discussions, architecture reviews, and engineering best practices.'),
                _buildPdfBullet('Review code and mentor developers to maintain high engineering standards.'),
                pw.SizedBox(height: 12),
                _buildPdfJobHeader(
                  'Software Engineer | Flutter Developer',
                  'Trirope Technologies Pvt. Ltd.',
                  'August 2022 – May 2026',
                ),
                pw.SizedBox(height: 6),
                _buildPdfBullet('Developed and maintained 10+ production-grade Flutter applications across Android, iOS, Web, Windows, and macOS.'),
                _buildPdfBullet('Built scalable cross-platform applications using Flutter and Firebase.'),
                _buildPdfBullet('Integrated REST APIs, Firebase Authentication, Cloud Firestore, Cloud Messaging, payment gateways, biometric authentication, and WebSocket communication.'),
                pw.SizedBox(height: 20),

                // Key Projects
                _buildPdfSectionHeader('KEY PROJECTS'),
                pw.SizedBox(height: 8),
                _buildPdfProjectItem(
                  'Enterprise Lottery Platform (PSG Lotto, Pinas Lotto, 2D/3D, 6-Digit)',
                  'Developed scalable multi-game platform with secure payments, authentication, and admin dashboards.',
                ),
                _buildPdfProjectItem(
                  'Healthcare Management System (Prashanth IVF – White Label)',
                  'Built hospital application for appointments, patient records, and notifications.',
                ),
                _buildPdfProjectItem(
                  'Media & News Platform (Virakesari App)',
                  'Developed real-time news application with WebView integration and performance optimization.',
                ),
                _buildPdfProjectItem(
                  'Matrimony Platform (Kaveri Matrimony)',
                  'Implemented profile management, matchmaking, chat, and subscription features.',
                ),
                _buildPdfProjectItem(
                  'POS & Inventory System (IMS)',
                  'Designed billing, inventory tracking, and reporting modules.',
                ),
                _buildPdfProjectItem(
                  'Astrology Application (PKG Astro)',
                  'Enhanced application performance and improved scalability.',
                ),

                pw.SizedBox(height: 20),

                // Education
                _buildPdfSectionHeader('EDUCATION'),
                pw.SizedBox(height: 8),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Expanded(
                      child: pw.Text(
                        'B.E. Computer Science Engineering',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Text(
                      '2017 – 2021',
                      style: const pw.TextStyle(fontSize: 11),
                    ),
                  ],
                ),
                pw.Text(
                  'Dhanalakshmi Srinivasan Institute of Technology',
                  style: pw.TextStyle(
                    fontSize: 11,
                    fontStyle: pw.FontStyle.italic,
                    color: PdfColors.black,
                  ),
                ),
                pw.Text('CGPA: 7.69', style: const pw.TextStyle(fontSize: 11)),
                pw.SizedBox(height: 8),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Expanded(
                      child: pw.Text(
                        'Higher Secondary Education',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Text(
                      '2015 – 2017',
                      style: const pw.TextStyle(fontSize: 11),
                    ),
                  ],
                ),
                pw.Text(
                  'State Board',
                  style: pw.TextStyle(
                    fontSize: 11,
                    fontStyle: pw.FontStyle.italic,
                    color: PdfColors.black,
                  ),
                ),
                pw.Text(
                  'Grade: 67.33% (808/1200)',
                  style: const pw.TextStyle(fontSize: 11),
                ),

                pw.SizedBox(height: 20),

                // Certifications & Strengths
                _buildPdfSectionHeader('CERTIFICATIONS & STRENGTHS'),
                pw.SizedBox(height: 8),
                _buildPdfBullet('Ethical Hacking Certification – 2022'),
                _buildPdfBullet(
                  'Flutter Development Certification – Completed',
                ),
                pw.SizedBox(height: 4),
                pw.Text(
                  'Strengths: Strong Problem-Solving Skills, Enterprise Application Development, Agile Practices, Ownership & Accountability.',
                  style: const pw.TextStyle(fontSize: 11, lineSpacing: 1.5),
                ),
              ],
            ),
          ];
        },
      ),
    );

    return pdf.save();
  }

  pw.Widget _buildPdfProjectItem(String title, String desc) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 8),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            title,
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 11),
          ),
          pw.SizedBox(height: 2),
          pw.Text(desc, style: const pw.TextStyle(fontSize: 11)),
        ],
      ),
    );
  }

  pw.Widget _buildPdfSectionHeader(String title) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(
            fontSize: 11,
            fontWeight: pw.FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
        pw.SizedBox(height: 2),
        pw.Container(
          height: 1,
          width: double.infinity,
          color: PdfColors.grey400,
        ),
      ],
    );
  }

  pw.Widget _buildPdfSkillRow(String category, String skills) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 2),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(
            width: 80,
            child: pw.Text(
              '$category:',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10),
            ),
          ),
          pw.Expanded(
            child: pw.Text(skills, style: const pw.TextStyle(fontSize: 10)),
          ),
        ],
      ),
    );
  }

  pw.Widget _buildPdfJobHeader(String role, String company, String duration) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
              role,
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 11),
            ),
            pw.Text(duration, style: const pw.TextStyle(fontSize: 10)),
          ],
        ),
        pw.Text(
          company,
          style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
        ),
      ],
    );
  }

  pw.Widget _buildPdfBullet(String text) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 2, left: 4),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            '• ',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10),
          ),
          pw.Expanded(
            child: pw.Text(text, style: const pw.TextStyle(fontSize: 10)),
          ),
        ],
      ),
    );
  }
}
