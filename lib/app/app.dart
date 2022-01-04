import 'package:handling_network_connectivity/services/api_service.dart';
import 'package:handling_network_connectivity/services/connectivity_service.dart';
import 'package:handling_network_connectivity/services/dashboard_service.dart';
import 'package:handling_network_connectivity/ui/home/home_view.dart';
import 'package:stacked/stacked_annotations.dart';

@StackedApp(
  routes: [
    AdaptiveRoute(page: HomeView, initial: true),
  ],
  dependencies: [
    Singleton(classType: ConnectionStatusSingleton),
    LazySingleton(classType: ApiService),
    LazySingleton(classType: DashboardService),
  ],
)
class AppSetup {}
