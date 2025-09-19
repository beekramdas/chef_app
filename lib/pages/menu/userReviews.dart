import 'package:chef_app/pages/menu/userReviewsTile.dart';
import 'package:flutter/material.dart';

class UserReviews extends StatefulWidget {
  const UserReviews({super.key});

  @override
  State<UserReviews> createState() => _UserReviewsState();
}

class _UserReviewsState extends State<UserReviews> {
  List userReviews = [
    [
      "20-12-2020",
      "Great Food And Service",
      5,
      "This Food so tasty & delicious. Breakfast so fast Delivered in my place. Chef is very friendly. I’m really like chef for Home Food Order. Thanks. ",
    ],
    [
      "20-12-2020",
      "Awesome and Nice",
      4,
      "This Food so tasty & delicious. Breakfast so fast Delivered in my place. ",
    ],
    ["21-12-2020", "Awesome Service", 3, "This food is nice and tasty."],
    ["21-12-2020", "Awesome Service", 5, "This food is nice and tasty."],
    ["21-12-2020", "Awesome Service", 2, "This food is nice and tasty."],
    ["21-12-2020", "Awesome Service", 4, "This food is nice and tasty."],
  ];

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
                  Navigator.pop(context);
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
                "Reviews",
                style: TextStyle(
                  fontSize: 17,
                  color: Color(0XFB181C2E),
                  height: 1.29,
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: userReviews.length,
        itemBuilder: (context, index) {
          return UserReviewTile(
            reviewTime: userReviews[index][0],
            reviewTitle: userReviews[index][1],
            userRating: userReviews[index][2],
            reviewDesc: userReviews[index][3],
            maxRating: 5,
          );
        },
      ),
    );
  }
}
