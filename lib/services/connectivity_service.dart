import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:handling_network_connectivity/app/app.locator.dart';
import 'package:handling_network_connectivity/utils/enums.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

const String _WifiNetworkConnectionProblems =
    "The WiFi you are connected to has no internet access. Please change your WiFi or use cellular data.";

const String _CellularNetworkConnectionProblems =
    "Your cellular connection is weak. Please connect to WiFi.";

const String _WithoutNetwork =
    "Your device has no connectivity. Please ensure you are connected to WiFi or have mobile data.";

const String _WithoutInternet =
    "Your device has no internet connection. Please check your network settings.";

class ConnectionStatusSingleton {
  final _snackbarService = locator<SnackbarService>();

  bool hasConnection = false;

  // ConnectivityResult? currentConnectivityResult;

  StreamController<bool> connectionChangeController =
      StreamController.broadcast();

  Stream<bool> get connectionChange => connectionChangeController.stream;

  final Connectivity _connectivity = Connectivity();

  ConnectionStatusSingleton() {
    // _connectivity.onConnectivityChanged.listen(_connectionChange);
    checkInternetConnection();
  }

  // void _connectionChange(ConnectivityResult result) async {
  //   final connectionStatus = await checkInternetConnection();
  //   currentConnectivityResult = result;
  //   debugPrint('connectionStatus: $connectionStatus');
  //   await actOnResult(connectionStatus, result);
  // }

  // Future<void> actOnResult(
  //     bool connectionStatus, ConnectivityResult connectivityResult) async {
  //   final lastConnectionStatus = connectionStatus;
  //   if (connectionStatus != lastConnectionStatus) {
  //     final message =
  //         '${connectivityResult.name} network active!\n Connection status: $connectionStatus ';
  //     _snackbarService.showCustomSnackBar(
  //       message: message,
  //       variant: connectionStatus == true
  //           ? SnackbarType.positive
  //           : SnackbarType.negative,
  //     );
  //   }
  // }

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

  /// Get the message to show when a Timeout Exception occur
  // String _getTimeoutExceptionMessage(ConnectivityResult? status) {
  //   switch (status) {
  //     case ConnectivityResult.wifi:
  //       return _WifiNetworkConnectionProblems;
  //     case ConnectivityResult.mobile:
  //       return _CellularNetworkConnectionProblems;
  //     case ConnectivityResult.none:
  //       return _WithoutNetwork;
  //     default:
  //       return _WithoutInternet;
  //   }
  // }

  /// Handle Timeout Exception
  ///
  /// Show a snackbar to the user when the internet connection is not working
  /// as expected.
  // Future handleTimeoutException([TimeoutException? exception]) async {
  //   debugPrint('exception:$exception ');
  //   _snackbarService.showCustomSnackBar(
  //     variant: SnackbarType.negative,
  //     title: exception?.message,
  //     message: exception!.message!,
  //     mainButtonTitle: 'OPEN NETWORK SETTINGS',
  //     duration: const Duration(seconds: 5),
  //   );
  // }

  /// Handle Socket Exception
  ///
  /// Show a snackbar to the user when there no internet connection, aka
  /// Airplane mode.
  // Future handleSocketException([SocketException? exception]) async {
  //   debugPrint('exception:$exception');
  //   _snackbarService.showCustomSnackBar(
  //     variant: SnackbarType.negative,
  //     title: exception?.message,
  //     message: exception!.message,
  //     mainButtonTitle: 'OPEN NETWORK SETTINGS',
  //     duration: const Duration(seconds: 5),
  //   );
  // }

  //A clean up method to close our StreamController
  //   Because this is meant to exist through the entire application life cycle this isn't
  //   really an issue
  // void dispose() {
  //   connectionChangeController.close();
  // }
}
