import 'package:flutter/material.dart';

class LunchTab extends StatefulWidget {
  const LunchTab({super.key});

  @override
  State<LunchTab> createState() => _LunchTabState();
}

class _LunchTabState extends State<LunchTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("LunchTab")));
  }
}
