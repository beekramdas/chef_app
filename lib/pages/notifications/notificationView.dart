import 'package:chef_app/pages/notifications/notificationTile.dart';
import 'package:flutter/material.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  final notificationItems = [
    ["Tanbir Ahmed", "Placed a new order", "20 min ago"],
    ["Salim smith", "left a 5 star review", "30 min ago"],
    ["Royal Bengol", "agreed to cancel", "40 min ago"],
    ["Pabel Vuiya", "Placed a new order", "20 min ago"],
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 24),
        physics: AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: notificationItems.length,
        itemBuilder: (context, index) {
          return NotificationTile(
            customerName: notificationItems[index][0],
            activity: notificationItems[index][1],
            activityTime: notificationItems[index][2],
          );
        },
      ),
    );
  }
}
