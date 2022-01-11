import 'dart:async';
import 'dart:io';

class ConnectivityService {
  bool hasConnection = false;

  StreamController<bool> connectionChangeController =
      StreamController.broadcast();
  Stream<bool> get connectionChange => connectionChangeController.stream;

  ConnectivityService() {
    checkInternetConnection();
  }

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
}
