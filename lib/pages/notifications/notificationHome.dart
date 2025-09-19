import 'package:chef_app/indexPage.dart';
import 'package:chef_app/pages/notifications/messagesView.dart';
import 'package:chef_app/pages/notifications/notificationView.dart';
import 'package:flutter/material.dart';

class NotificationHome extends StatefulWidget {
  const NotificationHome({super.key});

  @override
  State<NotificationHome> createState() => _NotificationHomeState();
}

class _NotificationHomeState extends State<NotificationHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: double.maxFinite,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Row(
            spacing: 15,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => IndexPage()),
                  );
                },
                child: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    color: Color(0XFBECF0F4),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.arrow_back_ios_new, size: 17),
                ),
              ),
              Text(
                "Notifications",
                style: TextStyle(
                  fontSize: 17,
                  color: Color(0XFB32343E),
                  height: 1.29,
                ),
              ),
            ],
          ),
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          spacing: 18,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            TabBar(
              splashFactory: NoSplash.splashFactory,
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              enableFeedback: true,
              unselectedLabelColor: Color(0XFBA5A7B9),
              labelColor: Color(0XFBFF7622),
              indicatorColor: Color(0XFBFF7622),
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: EdgeInsets.symmetric(horizontal: 17),
              indicatorWeight: 2,
              dividerColor: Color(0XFBCED7DF),
              labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              unselectedLabelStyle: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
              tabs: [
                Tab(child: Text("Notifications")),
                Tab(child: Text("Messages (3)")),
              ],
            ),
            Expanded(
              child: TabBarView(children: [NotificationView(), MessagesView()]),
            ),
          ],
        ),
      ),
    );
  }
}
