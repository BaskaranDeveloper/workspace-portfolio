import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class BatteryIndicator extends StatefulWidget {
  const BatteryIndicator({super.key});

  @override
  State<BatteryIndicator> createState() => _BatteryIndicatorState();
}

class _BatteryIndicatorState extends State<BatteryIndicator> {
  final Battery _battery = Battery();
  int _batteryLevel = 100;
  BatteryState _batteryState = BatteryState.full;

  @override
  void initState() {
    super.initState();
    _getBatteryState();
    _battery.onBatteryStateChanged.listen((BatteryState state) {
      if (mounted) {
        setState(() {
          _batteryState = state;
        });
      }
    });

    _getBatteryLevel();
  }

  Future<void> _getBatteryState() async {
    try {
      final state = await _battery.batteryState;
      if (mounted) {
        setState(() {
          _batteryState = state;
        });
      }
    } catch (e) {
      debugPrint('Error getting battery state: $e');
    }
  }

  Future<void> _getBatteryLevel() async {
    try {
      final level = await _battery.batteryLevel;
      if (mounted) {
        setState(() {
          _batteryLevel = level;
        });
      }
    } catch (e) {
      debugPrint('Error getting battery level: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color color = Colors.white;

    switch (_batteryState) {
      case BatteryState.charging:
        icon = LucideIcons.batteryCharging;
        color = Colors.greenAccent;
        break;
      case BatteryState.full:
        icon = LucideIcons.batteryFull;
        break;
      case BatteryState.discharging:
      case BatteryState.unknown:
        if (_batteryLevel >= 80) {
          icon = LucideIcons.batteryFull;
        } else if (_batteryLevel >= 40) {
          icon = LucideIcons.batteryMedium;
        } else if (_batteryLevel >= 20) {
          icon = LucideIcons.batteryLow;
          color = Colors.orangeAccent;
        } else {
          icon = LucideIcons.battery;
          color = Colors.redAccent;
        }
        break;
      case BatteryState.connectedNotCharging:
        icon = LucideIcons.batteryFull;
        break;
    }

    return Tooltip(
      message:
          'Battery: $_batteryLevel%${_batteryState == BatteryState.charging ? " (Charging)" : ""}',
      child: GestureDetector(
        onTap: _getBatteryLevel, // Refresh on tap
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 16),
            const SizedBox(width: 6),
            Text(
              '$_batteryLevel%',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
