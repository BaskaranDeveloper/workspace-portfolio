import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';

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

    // Check level periodically if stream doesn't update it directly
    // (BatteryPlus stream is for state, level is separate)
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
        icon = Icons.battery_charging_full;
        color = Colors.greenAccent;
        break;
      case BatteryState.full:
        icon = Icons.battery_full;
        break;
      case BatteryState.discharging:
      case BatteryState.unknown:
        if (_batteryLevel >= 90) {
          icon = Icons.battery_full;
        } else if (_batteryLevel >= 60) {
          icon = Icons.battery_6_bar;
        } else if (_batteryLevel >= 40) {
          icon = Icons.battery_4_bar;
        } else if (_batteryLevel >= 20) {
          icon = Icons.battery_3_bar;
          color = Colors.orangeAccent;
        } else {
          icon = Icons.battery_alert;
          color = Colors.redAccent;
        }
        break;
      case BatteryState.connectedNotCharging:
        icon = Icons.battery_full;
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
            Icon(icon, color: color, size: 18),
            const SizedBox(width: 4),
            Text(
              '$_batteryLevel%',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
