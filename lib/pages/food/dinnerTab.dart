import 'package:flutter/material.dart';

class DinnerTab extends StatefulWidget {
  const DinnerTab({super.key});

  @override
  State<DinnerTab> createState() => _DinnerTabState();
}

class _DinnerTabState extends State<DinnerTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("DinnerTab")));
  }
}
