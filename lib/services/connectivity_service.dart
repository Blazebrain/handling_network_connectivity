import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:handling_network_connectivity/utiliities/enums.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ConnectivityService with ReactiveServiceMixin {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  strea() {
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _connectionStatus = result;
    notifyListeners();
  }

  void dispose() {
    _connectivitySubscription.cancel();
  }
}

class ConnectionStatusSingleton {
  final snackbarService = SnackbarService();

  //This tracks the current connection status
  bool hasConnection = false;

  //This is how we'll allow subscribing to connection changes
  StreamController connectionChangeController = StreamController.broadcast();

  Stream get connectionChange => connectionChangeController.stream;

  //flutter_connectivity
  final Connectivity _connectivity = Connectivity();

  //Hook into flutter_connectivity's Stream to listen for changes
  //And check the connection status out of the gate
  void initialize() {
    _connectivity.onConnectivityChanged.listen(_connectionChange);
    checkInternetConnection();
  }

  //flutter_connectivity's listener
  void _connectionChange(ConnectivityResult result) async {
    final connectionStatus = await checkInternetConnection();
    await actOnResult(connectionStatus, result);
  }

  Future<void> actOnResult(
      bool connectionStatus, ConnectivityResult connectivityResult) async {
    if (connectionStatus == true) {
      final message = '${connectivityResult.name} network active!';
      snackbarService.showCustomSnackBar(
        message: message,
        variant: SnackbarType.positive,
      );
    } else {
      final message = '${connectivityResult.name} network inactive!';
      snackbarService.showCustomSnackBar(
        message: message,
        variant: SnackbarType.negative,
      );
    }
  }

  //The test to actually see if there is a connection
  Future<bool> checkInternetConnection() async {
    bool previousConnection = hasConnection;

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        hasConnection = true;
      } else {
        hasConnection = false;
      }
    } on SocketException catch (_) {
      hasConnection = false;
    }
    if (previousConnection != hasConnection) {
      connectionChangeController.add(hasConnection);
    }

    return hasConnection;
  }

  //A clean up method to close our StreamController
  //   Because this is meant to exist through the entire application life cycle this isn't
  //   really an issue
  void dispose() {
    connectionChangeController.close();
  }
}
