import 'package:flutter/material.dart';
import 'package:workspace/shared_ui/widgets/liquid_glass.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ControlCenter extends StatefulWidget {
  const ControlCenter({super.key});

  @override
  State<ControlCenter> createState() => _ControlCenterState();
}

class _ControlCenterState extends State<ControlCenter> {
  double _brightness = 0.7;
  double _volume = 0.5;
  bool _wifiEnabled = true;
  bool _bluetoothEnabled = true;

  @override
  Widget build(BuildContext context) {
    return LiquidGlass(
      borderRadius: 24,
      width: 320,
      padding: const EdgeInsets.all(16),
      shadows: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.3),
          blurRadius: 40,
          offset: const Offset(0, 20),
        ),
      ],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Connectivity Grid (Liquid blocks)
          Row(
            children: [
              Expanded(
                child: _buildSquircleBlock(
                  child: Column(
                    children: [
                      _buildToggleRow(
                        LucideIcons.wifi,
                        'Wi-Fi',
                        _wifiEnabled,
                        (v) => setState(() => _wifiEnabled = v),
                        Colors.blueAccent,
                      ),
                      const SizedBox(height: 12),
                      _buildToggleRow(
                        LucideIcons.bluetooth,
                        'Bluetooth',
                        _bluetoothEnabled,
                        (v) => setState(() => _bluetoothEnabled = v),
                        Colors.indigoAccent,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  children: [
                    _buildSquircleBlock(
                      child: Row(
                        children: [
                          Icon(LucideIcons.airplay, color: Colors.white, size: 16),
                          const SizedBox(width: 8),
                          const Text(
                            'AirDrop',
                            style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildSquircleBlock(
                      child: Row(
                        children: [
                          Icon(LucideIcons.layers, color: Colors.white, size: 16),
                          const SizedBox(width: 8),
                          const Text(
                            'Stage',
                            style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Sliders Area
          _buildSquircleBlock(
            child: Column(
              children: [
                _buildSliderRow(LucideIcons.sun, 'Display', _brightness, (v) => setState(() => _brightness = v)),
                const SizedBox(height: 16),
                _buildSliderRow(LucideIcons.volume2, 'Sound', _volume, (v) => setState(() => _volume = v)),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Media Control Area
          _buildSquircleBlock(
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(LucideIcons.music, color: Colors.white54),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Not Playing',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13),
                      ),
                      Text(
                        'Spotify',
                        style: TextStyle(color: Colors.white54, fontSize: 11),
                      ),
                    ],
                  ),
                ),
                const Icon(LucideIcons.play, color: Colors.white, size: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSquircleBlock({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: ShapeDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      child: child,
    );
  }

  Widget _buildToggleRow(
    IconData icon,
    String label,
    bool value,
    Function(bool) onChanged,
    Color activeColor,
  ) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: value ? activeColor : Colors.white.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 14),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
                Text(
                  value ? 'On' : 'Off',
                  style: const TextStyle(color: Colors.white54, fontSize: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliderRow(
    IconData icon,
    String label,
    double value,
    Function(double) onChanged,
  ) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.white70),
        const SizedBox(width: 12),
        Expanded(
          child: SliderTheme(
            data: SliderThemeData(
              trackHeight: 18,
              thumbShape: SliderComponentShape.noThumb,
              overlayShape: SliderComponentShape.noOverlay,
              activeTrackColor: Colors.white.withValues(alpha: 0.3),
              inactiveTrackColor: Colors.white.withValues(alpha: 0.05),
              trackShape: const RoundedRectSliderTrackShape(),
            ),
            child: Slider(value: value, onChanged: onChanged),
          ),
        ),
      ],
    );
  }
}
