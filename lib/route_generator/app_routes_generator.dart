
import 'package:awesome_notification_tutorial/pages/home_view.dart';
import 'package:awesome_notification_tutorial/pages/product_detail_view.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generatorRoute(RouteSettings settings) {
    ReceivedAction? receivedAction;
    if (settings.arguments != null && settings.arguments is ReceivedAction) {
      receivedAction = settings.arguments as ReceivedAction;
    }
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const HomeView());
      case '/productDetailPage':
        return MaterialPageRoute(
            builder: (context) => ProductDetailPage(
                receivedAction?.bigPicture ?? "",
                receivedAction?.body ?? "",
                ""));
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return const Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'No Page Found 404',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange),
            ),
            Center(
              child: Text(
                'Sorry No Page Found As Of Now',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
            )
          ],
        ),
      );
    });
  }
}
