import 'package:flutter/material.dart';

class MyFoodList extends StatefulWidget {
  const MyFoodList({super.key});

  @override
  State<MyFoodList> createState() => _MyFoodListState();
}

class _MyFoodListState extends State<MyFoodList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("MY Food List Page")));
  }
}
