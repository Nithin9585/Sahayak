import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';

class OfflineIndicator extends StatefulWidget {
  const OfflineIndicator({super.key});

  @override
  State<OfflineIndicator> createState() => _OfflineIndicatorState();
}

class _OfflineIndicatorState extends State<OfflineIndicator> {
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  bool _isOnline = true;
  bool _supportsConnectivity = true;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
    _setupConnectivityListener();
  }

  void _setupConnectivityListener() {
    try {
      _connectivitySubscription = Connectivity()
          .onConnectivityChanged
          .listen((List<ConnectivityResult> result) {
        setState(() {
          _isOnline = result.isNotEmpty && result.first != ConnectivityResult.none;
        });
      });
    } catch (e) {
      // Connectivity not supported on this platform (e.g., web in dev mode)
      setState(() {
        _supportsConnectivity = false;
        _isOnline = true; // Assume online
      });
    }
  }

  Future<void> _checkConnectivity() async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      setState(() {
        _isOnline = connectivityResult.isNotEmpty &&
            connectivityResult.first != ConnectivityResult.none;
      });
    } catch (e) {
      // Ignore connectivity check errors on unsupported platforms
      setState(() {
        _supportsConnectivity = false;
        _isOnline = true;
      });
    }
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isOnline || !_supportsConnectivity) {
      return const SizedBox.shrink(); // Hide when online or not supported
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: Colors.orange.shade700,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.cloud_off, color: Colors.white, size: 16),
          SizedBox(width: 8),
          Text(
            'Offline Mode - Data will sync when connected',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
