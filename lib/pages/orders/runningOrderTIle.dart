import 'package:flutter/material.dart';

class RunningOrderTile extends StatefulWidget {
  final String foodTag;
  final String foodName;
  final String orderId;
  final int price;

  RunningOrderTile({
    super.key,
    required this.foodTag,
    required this.foodName,
    required this.orderId,
    required this.price,
  });

  @override
  State<RunningOrderTile> createState() => _RunningOrderTileState();
}

class _RunningOrderTileState extends State<RunningOrderTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [
          Container(
            height: 102,
            width: 102,
            decoration: BoxDecoration(
              color: Color(0XFB98A8B8),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          Column(
            children: [
              Text(
                "#${widget.foodTag}",
                style: TextStyle(color: Color(0XFBED7A63), fontSize: 14),
              ),
              Text(
                widget.foodName,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0XFB32343E),
                ),
              ),
              Text(
                "ID: ${widget.orderId}",
                style: TextStyle(color: Color(0XFB9C9BA6), fontSize: 14),
              ),
              Row(
                children: [
                  Text(
                    "\$${widget.price}",
                    style: TextStyle(fontSize: 18, color: Color(0XFB32343E)),
                  ),
                  SizedBox(width: 10),
                  Container(
                    height: 36,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      color: Color(0XFbFF7622),
                    ),
                    child: Text(
                      "Done",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 5),
                  Container(
                    height: 36,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      border: Border.all(color: Color(0XFBFF3326), width: 1),
                    ),
                    child: Text(
                      "Cancel",
                      style: TextStyle(fontSize: 14, color: Color(0XFBFF3326)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
