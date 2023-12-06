import 'package:awesome_notification_tutorial/notificationUtils/notification_utils.dart';
import 'package:awesome_notification_tutorial/pages/product_detail_view.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  NotificationUtils notificationUtils = NotificationUtils();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20.0, left: 20.0),
              child: Text(
                'Awesome Notification',
                style: TextStyle(
                    color: Colors.orange,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
              child: notificationType(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    notificationUtils.checkingPermissionNotification(context);
    notificationUtils.startListeningNotificationEvents();
    super.initState();
  }

  Widget notificationType() {
    return SizedBox(
      child: GridView.extent(
        primary: false,
        shrinkWrap: true,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        maxCrossAxisExtent: 200.0,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              notificationUtils.createLocalInstantNotification();
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 0),
                      blurRadius: 1,
                      color: Color.fromRGBO(0, 0, 0, 0.10),
                    )
                  ],
                  border: Border.all(color: Colors.orange, width: 0.5)),
              child: const Center(
                child: Text('Instant Notification',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              notificationUtils.createScheduleNotification();
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 0),
                      blurRadius: 1,
                      color: Color.fromRGBO(0, 0, 0, 0.10),
                    )
                  ],
                  border: Border.all(color: Colors.orange, width: 0.5)),
              child: const Center(
                child: Text('Schedule Notification',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              notificationUtils.jsonDataNotification({
                "content": {
                  "id": -1,
                  "channelKey": "basic_channel",
                  "title": "Buy Favorite Product",
                  "body":
                      "Hurry Up To Grab This Product Loot With Just 80% Off",
                  "notificationLayout": NotificationLayout.BigPicture,
                  "largeIcon":
                      "https://images.moviefit.me/p/m/41735-neil-armstrong.webp",
                  "bigPicture":
                      "https://rukminim2.flixcart.com/image/612/612/xif0q/sweatshirt/p/i/p/m-839-3-ftx-original-imagvbmpzzreycyg.jpeg?q=70",
                  "showWhen": true,
                  "autoCancel": true,
                  "privacy": NotificationPrivacy.Private,
                  "payload": {'notificationId': '1234567890'}
                },
              });
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 0),
                      blurRadius: 1,
                      color: Color.fromRGBO(0, 0, 0, 0.10),
                    )
                  ],
                  border: Border.all(color: Colors.orange, width: 0.5)),
              child: const Center(
                child: Text('From Json Notification',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              notificationUtils.createCustomNotificationWithActionButtons();
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 0),
                      blurRadius: 1,
                      color: Color.fromRGBO(0, 0, 0, 0.10),
                    )
                  ],
                  border: Border.all(color: Colors.orange, width: 0.5)),
              child: const Center(
                child: Text('With Custom Buttons',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
