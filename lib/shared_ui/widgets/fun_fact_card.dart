import 'dart:math';
import 'package:flutter/material.dart';
import 'package:workspace/shared_ui/theme/app_colors.dart';
import 'package:workspace/shared_ui/widgets/glass_container.dart';

class FunFactCard extends StatefulWidget {
  const FunFactCard({super.key});

  @override
  State<FunFactCard> createState() => _FunFactCardState();
}

class _FunFactCardState extends State<FunFactCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late int _currentIndex;

  final List<String> _facts = [
    "The first computer bug was an actual moth found in the Harvard Mark II computer in 1947.",
    "Flutter was originally called 'Sky' and could only run on Android.",
    "The first high-level programming language was Plankalkül, created by Konrad Zuse in 1943.",
    "Dart was unveiled by Google at the GOTO conference in Aarhus, Denmark, October 10-12, 2011.",
    "The first domain name ever registered was Symbolics.com on March 15, 1985.",
    "There are over 700 separate programming languages.",
    "The first computer mouse was made of wood.",
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = Random().nextInt(_facts.length);
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _nextFact() {
    _controller.reverse().then((_) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % _facts.length;
      });
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.1),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut)),
        child: GlassContainer(
          width: double.infinity,
          color: AppColors.terminalBlue.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb_outline_rounded,
                        color: AppColors.terminalBlue,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Did You Know?',
                        style: TextStyle(
                          color: AppColors.terminalBlue,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: _nextFact,
                    icon: const Icon(Icons.refresh_rounded),
                    color: AppColors.terminalBlue.withValues(alpha: 0.7),
                    tooltip: 'Next Fact',
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                _facts[_currentIndex],
                style: TextStyle(
                  color: AppColors.textPrimary.withValues(alpha: 0.9),
                  fontSize: 16,
                  height: 1.5,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
