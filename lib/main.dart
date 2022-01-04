// import 'package:flutter/material.dart';
// import 'package:handling_network_connectivity/app/app.router.dart';
// import 'package:stacked_services/stacked_services.dart';

// import 'app/app.locator.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   setupLocator();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Connectivity',
//       onGenerateRoute: StackedRouter().onGenerateRoute,
//       navigatorKey: StackedService.navigatorKey,
//     );
//   }
// }

// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

const _text1 = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit,';
const _text2 =
    'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            color: Colors.lightBlue,
            width: 400.0,
            height: 300.0,
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: const [
                      Expanded(
                        child: Text(
                          _text1,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          _text2,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: const [
                      Expanded(
                        child: Text(
                          _text1,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          _text2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
