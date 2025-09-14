import 'package:flutter/material.dart';

class FoodDetails extends StatefulWidget {
  const FoodDetails({super.key});

  @override
  State<FoodDetails> createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetails> {
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
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  color: Color(0XFBECF0F4),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.arrow_back_ios_new, size: 17),
              ),
              Text(
                "Food Details",
                style: TextStyle(
                  fontSize: 17,
                  color: Color(0XFB32343E),
                  height: 1.29,
                ),
              ),
            ],
          ),
        ),
        actions: [
          Text(
            "Edit",
            style: TextStyle(
              fontSize: 14,
              color: Color(0XFBFB6D3A),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 15),
        ],
      ),
    );
  }
}
