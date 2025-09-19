import 'package:chef_app/indexPage.dart';
import 'package:chef_app/pages/food/allFoodTab.dart' show AllFoodTab;
import 'package:chef_app/pages/food/breakfastTab.dart';
import 'package:chef_app/pages/food/dinnerTab.dart';
import 'package:chef_app/pages/food/lunchTab.dart';
import 'package:flutter/material.dart';

class MyFoodList extends StatefulWidget {
  const MyFoodList({super.key});

  @override
  State<MyFoodList> createState() => _MyFoodListState();
}

class _MyFoodListState extends State<MyFoodList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: double.maxFinite,
        backgroundColor: Colors.white,
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
                "My Food List",
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
        length: 4,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TabBar(
                splashFactory: NoSplash.splashFactory,
                overlayColor: WidgetStateProperty.all(Colors.transparent),
                labelPadding: EdgeInsets.symmetric(horizontal: 22),
                indicatorWeight: 2.5,
                tabAlignment: TabAlignment.start,
                indicatorColor: Color(0XFBFB6D3A),
                indicatorPadding: EdgeInsets.only(top: 15),
                enableFeedback: true,
                dividerColor: Colors.transparent,
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.tab,
                unselectedLabelColor: Color(0XFB32343E),
                labelColor: Color(0XFBFB6D3A),
                labelStyle: TextStyle(fontSize: 14),
                tabs: [
                  Tab(child: Text("All")),
                  Tab(child: Text("Breakfast")),
                  Tab(child: Text("Lunch")),
                  Tab(child: Text("Dinner")),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    AllFoodTab(),
                    BreakfastTab(),
                    LunchTab(),
                    DinnerTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
