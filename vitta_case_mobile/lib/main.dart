import 'package:flutter/material.dart';
import 'package:vitta_case_mobile/core/services/navigation_service.dart';
import 'package:vitta_case_mobile/core/services/routes_generator.dart';
import 'package:vitta_case_mobile/injection_container.dart';

import 'features/movies/presentation/pages/home_page/home_page.dart';

void main() async {
  await initInjection();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      title: 'Movies App',
      home: HomePage(),
      navigatorKey: NavigationService.navKey,
      onGenerateRoute: RouterGenerator.generateRoute,
    );
  }
}
