import 'package:awesome_notification_tutorial/notificationUtils/notification_utils.dart';
import 'package:flutter/material.dart';

import 'pages/home_view.dart';
import 'route_generator/app_routes_generator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationUtils().configuration();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Awesome Notification',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      // home: const HomeView(),
      initialRoute: '/',
      navigatorKey: navigatorKey,
      onGenerateRoute: RouteGenerator.generatorRoute,
    );
  }
}
