import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityPlusManager {
  ConnectivityPlusManager._();

  static final ConnectivityPlusManager _instance = ConnectivityPlusManager._();
  static ConnectivityPlusManager get shared => _instance;

  final Connectivity _connectivity = Connectivity();

  // Check if the device is connected
  Future<bool> get isConnected async {
    final List<ConnectivityResult> status = await _connectivity.checkConnectivity();
    return _isConnectedWithStatus(status as ConnectivityResult);
  }

  // Helper method to check connectivity status
  bool _isConnectedWithStatus(ConnectivityResult status) {
    switch (status) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.ethernet:
      case ConnectivityResult.vpn: // Added VPN support
      case ConnectivityResult.other: // Added support for other connection types
        return true;
      case ConnectivityResult.none:
      case ConnectivityResult.bluetooth: // Bluetooth is not considered a network connection
      default:
        return false;
    }
  }

  // Stream to listen for connectivity changes
  Stream<List<ConnectivityResult>> get onConnectivityChanged {
    return _connectivity.onConnectivityChanged;
  }
}