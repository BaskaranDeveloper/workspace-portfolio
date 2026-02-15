import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:workspace/system/domain/entities/system_app.dart';

class MobileDock extends StatelessWidget {
  final List<SystemApp> dockApps;

  const MobileDock({super.key, required this.dockApps});

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return Container(
      margin: EdgeInsets.only(
        bottom: bottomPadding + 16,
      ), // Safe area + padding
      height: 90, // iOS dock height approx
      width: double.infinity,
      alignment: Alignment.bottomCenter,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            width: 340, // Fixed width for 4 icons
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.2),
                width: 0.5,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: dockApps
                  .map((app) => _buildDockItem(context, app))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDockItem(BuildContext context, SystemApp app) {
    return GestureDetector(
      onTap: () => context.push('/mobile/apps/${app.id}'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 50, // Slightly smaller than home screen icons
            height: 50,
            decoration: BoxDecoration(
              color: app.themeColor,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(app.icon, color: Colors.white, size: 28),
          ),
        ],
      ),
    );
  }
}
