import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class NetworkIndicator extends StatefulWidget {
  const NetworkIndicator({super.key});

  @override
  State<NetworkIndicator> createState() => _NetworkIndicatorState();
}

class _NetworkIndicatorState extends State<NetworkIndicator> {
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _updateConnectionStatus,
    );
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> _initConnectivity() async {
    late List<ConnectivityResult> result;
    try {
      result = await _connectivity.checkConnectivity();
    } catch (e) {
      debugPrint('Couldn\'t check connectivity status: $e');
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  void _updateConnectionStatus(List<ConnectivityResult> result) {
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    IconData icon;
    String statusText;

    if (_connectionStatus.contains(ConnectivityResult.mobile)) {
      icon = LucideIcons.signal;
      statusText = 'Mobile Data';
    } else if (_connectionStatus.contains(ConnectivityResult.wifi)) {
      icon = LucideIcons.wifi;
      statusText = 'Wi-Fi';
    } else if (_connectionStatus.contains(ConnectivityResult.ethernet)) {
      icon = LucideIcons.globe;
      statusText = 'Ethernet';
    } else if (_connectionStatus.contains(ConnectivityResult.vpn)) {
      icon = LucideIcons.shieldCheck;
      statusText = 'VPN Connected';
    } else if (_connectionStatus.contains(ConnectivityResult.none)) {
      icon = LucideIcons.wifiOff;
      statusText = 'No Connection';
    } else {
      icon = LucideIcons.wifiOff;
      statusText = 'Unknown';
    }

    return Tooltip(
      message: statusText,
      child: GestureDetector(
        onTap: () {
          // Open Wi-Fi settings or toggle
        },
        child: Icon(icon, color: Colors.white, size: 16),
      ),
    );
  }
}
