import 'package:flutter/material.dart';
import 'package:handling_network_connectivity/app/app.router.dart';
import 'package:handling_network_connectivity/ui/shared/snackbars/setup_snackbar_ui.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app/app.locator.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await setupSnackBarUI();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Connectivity',
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
    );
  }
}
