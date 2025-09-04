import 'package:chef_app/pages/orders/runningOrderTIle.dart';
import 'package:flutter/material.dart';

class RunningOrders extends StatefulWidget {
  const RunningOrders({super.key});

  @override
  State<RunningOrders> createState() => _RunningOrdersState();
}

class _RunningOrdersState extends State<RunningOrders> {
  final List orderItems = [
    ["Breakfast", "Chicken Thai Biriyani", "12", 60],
    ["Breakfast", "Chicken Thai Biriyani", "12", 60],
    ["Breakfast", "Chicken Thai Biriyani", "12", 60],
    ["Breakfast", "Chicken Thai Biriyani", "12", 60],
    ["Breakfast", "Chicken Thai Biriyani", "12", 60],
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "20 Running Orders",
              style: TextStyle(
                color: Color(0XFB181C2E),
                fontSize: 17,
                height: 1.3,
              ),
            ),
            SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              primary: true,
              scrollDirection: Axis.vertical,
              itemCount: orderItems.length,
              itemBuilder: (context, index) {
                return RunningOrderTile(
                  foodTag: orderItems[index][0],
                  foodName: orderItems[index][1],
                  orderId: orderItems[index][2],
                  price: orderItems[index][3],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
