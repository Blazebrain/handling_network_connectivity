import 'dart:io';
import 'package:handling_network_connectivity/app/app.locator.dart';
import 'package:handling_network_connectivity/app/app.logger.dart';
import 'package:handling_network_connectivity/models/character_model.dart';
import 'package:handling_network_connectivity/models/superhero_response_model.dart';
import 'package:handling_network_connectivity/services/connectivity_service.dart';
import 'package:handling_network_connectivity/services/superhero_service.dart';
import 'package:handling_network_connectivity/utils/enums.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends StreamViewModel {
  final _connectivityService = locator<ConnectivityService>();
  final _snackbarService = locator<SnackbarService>();
  final _superheroService = locator<SuperheroService>();
  final log = getLogger('HomeViewModel');

  SuperheroResponseModel? detail;
  bool connectionStatus = false;
  bool hasCalled = false;
  bool hasShownSnackbar = false;

  Future<void> getCharacters() async {
    if (connectionStatus == true) {
      try {
        detail = await runBusyFuture(
          _superheroService.getCharactersDetails(),
          throwException: true,
        );
        hasCalled = true;
        notifyListeners();
      } on SocketException catch (e) {
        hasCalled = true;
        notifyListeners();
        _snackbarService.showCustomSnackBar(
          variant: SnackbarType.negative,
          message: e.toString(),
        );
      } on Exception catch (e) {
        hasCalled = true;
        notifyListeners();
        _snackbarService.showCustomSnackBar(
          variant: SnackbarType.negative,
          message: e.toString(),
        );
      }
    } else {
      log.e('Internet Connectivity Error');
      if (hasShownSnackbar == false) {
        _snackbarService.showCustomSnackBar(
          variant: SnackbarType.negative,
          message: 'Error: Internet Connection is weak or disconnected',
          duration: const Duration(seconds: 5),
        );
        hasShownSnackbar = true;
        notifyListeners();
      }
    }
  }

  Stream<bool> checkConnectivity() async* {
    yield await _connectivityService.checkInternetConnection();
  }

  @override
  Stream get stream => checkConnectivity();

  bool get status {
    stream.listen((event) {
      connectionStatus = event;
      notifyListeners();
      if (hasCalled == false) getCharacters();
    });

    return connectionStatus;
  }
}
