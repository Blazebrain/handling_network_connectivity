import 'package:handling_network_connectivity/services/api_service.dart';
import 'package:handling_network_connectivity/services/connectivity_service.dart';
import 'package:handling_network_connectivity/services/superhero_service.dart';
import 'package:handling_network_connectivity/ui/views/home/home_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    AdaptiveRoute(page: HomeView, initial: true),
  ],
  dependencies: [
    Singleton(classType: SnackbarService),
    Singleton(classType: ConnectivityService),
    LazySingleton(classType: ApiService),
    LazySingleton(classType: SuperheroService),
  ],
  logger: StackedLogger(),
)
class AppSetup {}
