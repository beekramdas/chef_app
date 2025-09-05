import 'package:flutter/material.dart';

class BreakfastTab extends StatefulWidget {
  const BreakfastTab({super.key});

  @override
  State<BreakfastTab> createState() => _BreakfastTabState();
}

class _BreakfastTabState extends State<BreakfastTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Breakfast tab")));
  }
}
