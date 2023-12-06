import 'dart:async';
import 'dart:isolate';
import 'dart:ui';
import 'package:awesome_notification_tutorial/pages/product_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_notification_tutorial/main.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationUtils {
  NotificationUtils._();

  factory NotificationUtils() => _instance;
  static final NotificationUtils _instance = NotificationUtils._();
  final AwesomeNotifications awesomeNotifications = AwesomeNotifications();
  static ReceivePort? receivePort;

  /// while creating channel do not mistake for creating channel key or not confusing with channel key create same channel key and use for notification
  /// one more thing prevent with null value or like null string because it will be giving error like native java null pointer exception so be care full
  /// while passing a data or creating a notification..

  Future<void> configuration() async {
    print("configuration check with this");
    await awesomeNotifications.initialize(
        null,
        [
          NotificationChannel(
            channelKey: 'basic_channel',
            channelName: 'Basic Notifications',
            defaultColor: Colors.teal,
            importance: NotificationImportance.High,
            channelShowBadge: true,
            channelDescription: 'Basic Instant Notification',
            channelGroupKey: 'basic_channel_group',
          ),
        ],
        debug: true);
  }

  void checkingPermissionNotification(BuildContext context) {
    AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) {
        if (!isAllowed) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Allow Notifications'),
              content:
                  const Text('Our app would like to send you notifications'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Don\'t Allow',
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                ),
                TextButton(
                  onPressed: () => AwesomeNotifications()
                      .requestPermissionToSendNotifications()
                      .then((value) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }),
                  child: const Text(
                    'Allow',
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Future<void> createLocalInstantNotification() async {
    await awesomeNotifications.createNotification(
      content: NotificationContent(
          id: -1,
          channelKey: 'basic_channel',
          title: 'Buy Favorite Product',
          body: "Hurry Up To Grab This Product Loot With Just 80% Off",
          bigPicture:
              'https://rukminim2.flixcart.com/image/612/612/xif0q/sweatshirt/p/i/p/m-839-3-ftx-original-imagvbmpzzreycyg.jpeg?q=70',
          largeIcon: 'https://rukminim2.flixcart.com/image/612/612/xif0q/sweatshirt/p/i/p/m-839-3-ftx-original-imagvbmpzzreycyg.jpeg?q=70',
          notificationLayout: NotificationLayout.BigPicture,
          payload: {'notificationId': '1234567890'}),
    );
  }

  Future<void> jsonDataNotification(Map<String, Object> jsonData) async {
    await awesomeNotifications.createNotificationFromJsonData(jsonData);
  }

  Future<void> createScheduleNotification() async {
    try {
      await awesomeNotifications.createNotification(
        schedule: NotificationCalendar(
          day: DateTime.now().day,
          month: DateTime.now().month,
          year: DateTime.now().year,
          hour: DateTime.now().hour,
          minute: DateTime.now().minute + 1,
        ),
        content: NotificationContent(
          id: -1,
          channelKey: 'basic_channel',
          title: 'Start Sale In Just Two Min Ago',
          body: "Hurry Sale Is Now Live Grab The Loot",
          bigPicture:
              'https://rukminim2.flixcart.com/image/612/612/xif0q/sweatshirt/p/i/p/m-839-3-ftx-original-imagvbmpzzreycyg.jpeg?q=70',
          notificationLayout: NotificationLayout.BigPicture,
        ),
      );
    } catch (e) {}
  }

  Future<void> createCustomNotificationWithActionButtons() async {
    await awesomeNotifications.createNotification(
        content: NotificationContent(
            id: -1,
            channelKey: 'basic_channel',
            title: 'Buy Favorite Product',
            body: "Hurry Up To Grab This Product Loot With Just 80% Off",
            bigPicture:
                'https://rukminim2.flixcart.com/image/612/612/xif0q/sweatshirt/p/i/p/m-839-3-ftx-original-imagvbmpzzreycyg.jpeg?q=70',
            largeIcon: 'https://rukminim2.flixcart.com/image/612/612/xif0q/sweatshirt/p/i/p/m-839-3-ftx-original-imagvbmpzzreycyg.jpeg?q=70',
            notificationLayout: NotificationLayout.BigPicture,
            payload: {'notificationId': '1234567890'}),
        actionButtons: [
          NotificationActionButton(key: 'buyNow', label: 'Buy Now'),
          NotificationActionButton(key: 'addToCart', label: 'Add To Cart'),
        ]);
  }

  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    if (receivedAction.actionType == ActionType.SilentAction ||
        receivedAction.actionType == ActionType.SilentBackgroundAction) {
      // For background actions, you must hold the execution until the end
      print(
          'Message sent via notification input: "${receivedAction.buttonKeyInput}"');
      await executeLongTaskInBackground();
    } else {
      // this process is only necessary when you need to redirect the user
      // to a new page or use a valid context, since parallel isolates do not
      // have valid context, so you need redirect the execution to main isolate
      if (receivePort == null) {
        print(
            'onActionReceivedMethod was called inside a parallel dart isolate.');
        SendPort? sendPort =
            IsolateNameServer.lookupPortByName('notification_action_port');

        if (sendPort != null) {
          print('Redirecting the execution to main isolate process.');
          sendPort.send(receivedAction);
          return;
        }
      }
      print("check data with receivedAction 3$receivedAction");

      return onActionReceivedImplementationMethod(receivedAction);
    }
  }

  static Future<void> onActionReceivedImplementationMethod(
      ReceivedAction receivedAction) async {
    print("check data with receivedAction${MyApp.navigatorKey.currentState}");
    print("check data with receivedAction${MyApp.navigatorKey.currentContext}");
    if (receivedAction.buttonKeyInput == "buyNow") {
    } else if (receivedAction.buttonKeyInput == "addToCart") {
    } else {
      MyApp.navigatorKey.currentState?.push(MaterialPageRoute(
          builder: (context) => ProductDetailPage(
              receivedAction.bigPicture ?? "",
              "Hoodies for unisex",
              receivedAction.body ?? "")));
    }
  }

  static Future<void> executeLongTaskInBackground() async {
    print("starting long task");
    await Future.delayed(const Duration(seconds: 4));
    final url = Uri.parse("http://google.com");
    final re = await http.get(url);
    print(re.body);
    print("long task done");
  }

  Future<void> startListeningNotificationEvents() async {
    print("check data with start listing");
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: onActionReceivedMethod,
        onNotificationCreatedMethod: onNotificationCreatedMethod,
        onNotificationDisplayedMethod: onNotificationDisplayedMethod,
        onDismissActionReceivedMethod: onDismissActionReceivedMethod);
  }

  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    print("onNotificationCreatedMethod");

    // Your code goes here
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
    print("onNotificationDisplayedMethod");
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Your code goes here
    print("onDismissActionReceivedMethod");
  }
}
