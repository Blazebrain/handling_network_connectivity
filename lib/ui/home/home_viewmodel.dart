import 'package:handling_network_connectivity/app/app.locator.dart';
import 'package:handling_network_connectivity/models/character_model.dart';
import 'package:handling_network_connectivity/services/connectivity_service.dart';
import 'package:handling_network_connectivity/services/dashboard_service.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends StreamViewModel {
  final _dashboardService = locator<DashboardService>();
  final _connectivityService = locator<ConnectionStatusSingleton>();

  List<CharacterModel>? charactersList = [];
  bool connectionStatus = false;
  bool hasCalled = false;
  bool locked = false;

  Future<void> getCharacters() async {
    if (connectionStatus == true) {
      charactersList = await runBusyFuture(
        _dashboardService.getCharactersDetails(),
        throwException: true,
      ).onError((error, stackTrace) {
        connectionStatus == false;
        notifyListeners();
      });
      locked = true;
      hasCalled = true;
      notifyListeners();
    } else {
      print('Internet Connectivity Error');
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
      if (connectionStatus == true && hasCalled == false) getCharacters();
    });

    return connectionStatus;
  }
}
