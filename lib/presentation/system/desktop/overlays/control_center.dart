import 'package:flutter/material.dart';

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
  bool _airdropEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9), // Glassmorphism base
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(color: Colors.white.withOpacity(0.5), width: 0.5),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Connectivity Grid
          Row(
            children: [
              // Left Block (Wifi, BT, Airdrop)
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      _buildToggleRow(
                        Icons.wifi,
                        'Wi-Fi',
                        _wifiEnabled,
                        (v) => setState(() => _wifiEnabled = v),
                        Colors.blue,
                      ),
                      const SizedBox(height: 12),
                      _buildToggleRow(
                        Icons.bluetooth,
                        'Bluetooth',
                        _bluetoothEnabled,
                        (v) => setState(() => _bluetoothEnabled = v),
                        Colors.blue,
                      ),
                      const SizedBox(height: 12),
                      _buildToggleRow(
                        Icons.airplanemode_active,
                        'AirDrop',
                        _airdropEnabled,
                        (v) => setState(() => _airdropEnabled = v),
                        Colors.blue,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Right Block (Do Not Disturb, etc - Placeholder)
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    _buildSquareToggle(
                      Icons.dark_mode,
                      'Dark Mode',
                      true,
                      () {},
                    ),
                    const SizedBox(height: 12),
                    _buildSquareToggle(
                      Icons.keyboard,
                      'Keyboard',
                      false,
                      () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Sliders
          _buildSliderBlock(
            Icons.wb_sunny,
            'Display',
            _brightness,
            (v) => setState(() => _brightness = v),
          ),
          const SizedBox(height: 12),
          _buildSliderBlock(
            Icons.volume_up,
            'Sound',
            _volume,
            (v) => setState(() => _volume = v),
          ),
          const SizedBox(height: 16),
          // Media Player (Placeholder)
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.music_note, color: Colors.grey),
                ),
                const SizedBox(width: 12),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Not Playing',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      'Music',
                      style: TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                  ],
                ),
                const Spacer(),
                const Icon(Icons.play_arrow, size: 28),
                const SizedBox(width: 8),
                const Icon(Icons.skip_next, size: 24),
              ],
            ),
          ),
        ],
      ),
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
              color: value ? activeColor : Colors.grey[400],
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 16),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              Text(
                value ? 'On' : 'Off',
                style: const TextStyle(color: Colors.grey, fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSquareToggle(
    IconData icon,
    String label,
    bool value,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: value
              ? Colors.white.withOpacity(0.8)
              : Colors.black.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: value ? Colors.blue : Colors.black87, size: 20),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: value ? Colors.blue : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSliderBlock(
    IconData icon,
    String label,
    double value,
    Function(double) onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(icon, size: 16, color: Colors.grey),
              Expanded(
                child: SliderTheme(
                  data: SliderThemeData(
                    trackHeight: 20,
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 10,
                    ),
                    overlayShape: SliderComponentShape.noOverlay,
                    activeTrackColor: Colors.white,
                    inactiveTrackColor: Colors.grey[400],
                    thumbColor: Colors.white,
                  ),
                  child: Slider(value: value, onChanged: onChanged),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
