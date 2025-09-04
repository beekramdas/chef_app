import 'package:chef_app/homepage.dart';
import 'package:chef_app/pages/addProduct/addFood.dart';
import 'package:chef_app/pages/food/myFoodList.dart';
import 'package:chef_app/pages/myProfile/myProfile.dart';
import 'package:chef_app/pages/notifications/notificationPage.dart';
import 'package:flutter/material.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final List myScreens = [
    HomePage(),
    MyFoodList(),
    AddFood(),
    NotificationPage(),
    Myprofile(),
  ];
  int selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: myScreens[selectedPage],
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                offset: Offset(0, -4),
                color: Colors.black.withValues(alpha: 0.05),
              ),
            ],
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              onTap: (index) {
                setState(() {
                  selectedPage = index;
                });
              },
              enableFeedback: true,
              useLegacyColorScheme: false,
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              currentIndex: selectedPage,
              backgroundColor: Colors.transparent,
              selectedItemColor: Color(0XFBFF7622),
              unselectedItemColor: Color(0XFBAFAFAF),
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.grid_view_outlined, size: 24),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu, size: 24),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    height: 57,
                    width: 57,
                    decoration: BoxDecoration(
                      color: Color(0XFBFFF1F2),
                      shape: BoxShape.circle,
                      border: Border.all(color: Color(0XFBFF7622)),
                    ),
                    child: Icon(Icons.add, size: 24, color: Color(0XFBFF7622)),
                  ),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.notifications_none_outlined, size: 24),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline_sharp, size: 24),
                  label: "",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
