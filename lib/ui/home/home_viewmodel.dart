import 'package:handling_network_connectivity/app/app.locator.dart';
import 'package:handling_network_connectivity/models/character_model.dart';
import 'package:handling_network_connectivity/services/connectivity_service.dart';
import 'package:handling_network_connectivity/services/dashboard_service.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends StreamViewModel {
  final _dashboardService = locator<DashboardService>();
  final _connectivityService = locator<ConnectionStatusSingleton>();
  List<CharacterModel>? charactersList = [];
  bool? connectionValue;
  Future<void> getCharacters() async {
    charactersList =
        await runBusyFuture(_dashboardService.getCharactersDetails());
  }

  @override
  Stream get stream => _connectivityService.connectionChange;
}
