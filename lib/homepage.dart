import 'package:chef_app/pages/orders/runningOrders.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedValue = "Daily";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, top: 15),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          clipBehavior: Clip.none,
          child: Column(
            spacing: 15,
            children: [
              Row(
                children: [
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        "assets/menu/Menu.svg",
                        height: 16,
                        width: 12,
                      ),
                    ),
                  ),
                  SizedBox(width: 25),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "LOCATION",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Color(0XFBFC6E2A),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Halal Lab office",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0XFB676767),
                            ),
                          ),
                          Icon(Icons.arrow_drop_down, size: 35, weight: 1),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      color: Color(0XFB98A8B8),
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: Row(
                  spacing: 15,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _showBottomSheet(context);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 22,
                          vertical: 20,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 4,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "20",
                              style: TextStyle(
                                fontSize: 52.32,
                                color: Color(0XFB32343E),
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0,
                              ),
                            ),
                            Text(
                              "RUNNING ORDERS",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Color(0XFB838799),
                                letterSpacing: 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 20,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "05",
                            style: TextStyle(
                              fontSize: 52.32,
                              color: Color(0XFB32343E),
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0,
                            ),
                          ),
                          Text(
                            "ORDER REQUEST",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Color(0XFB838799),
                              letterSpacing: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Total Revenue",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0XFB32343E),
                                  letterSpacing: 0,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "\$2,241",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0XFB32343E),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 2),
                            height: 26.16,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.98),
                              border: Border.all(color: Color(0XFBC4C4C4)),
                            ),
                            child: DropdownButton<String>(
                              alignment: Alignment.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0XFb9C9BA6),
                              ),
                              value: selectedValue,
                              items: const [
                                DropdownMenuItem(
                                  value: "Daily",
                                  child: Text("Daily"),
                                ),
                                DropdownMenuItem(
                                  value: "Weekly",
                                  child: Text("Weekly"),
                                ),
                                DropdownMenuItem(
                                  value: "Monthly",
                                  child: Text("Monthly"),
                                ),
                              ],
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    selectedValue = newValue;
                                    print(selectedValue);
                                  });
                                }
                              },
                              underline:
                                  const SizedBox(), // Remove default underline
                            ),
                          ),
                          const Text(
                            "See Details",
                            style: TextStyle(
                              color: Color(0XFBFB6D3A),
                              fontSize: 14,
                              decoration: TextDecoration.underline,
                              decorationStyle: TextDecorationStyle.solid,
                              decorationColor: Color(0XFBFB6D3A),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 140,
                        child: LineChart(
                          LineChartData(
                            clipData: FlClipData.all(),
                            gridData: FlGridData(show: false),
                            titlesData: FlTitlesData(
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              topTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              rightTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  interval: 1,
                                  getTitlesWidget: (value, meta) {
                                    switch (value.toInt()) {
                                      case 10:
                                        return const Text(
                                          "10AM",
                                          style: TextStyle(
                                            fontSize: 9,
                                            color: Color(0XFB9C9BA6),
                                          ),
                                        );
                                      case 11:
                                        return const Text(
                                          "11AM",
                                          style: TextStyle(
                                            fontSize: 9,
                                            color: Color(0XFB9C9BA6),
                                          ),
                                        );
                                      case 12:
                                        return const Text(
                                          "12PM",
                                          style: TextStyle(
                                            fontSize: 9,
                                            color: Color(0XFB9C9BA6),
                                          ),
                                        );
                                      case 13:
                                        return const Text(
                                          "01PM",
                                          style: TextStyle(
                                            fontSize: 9,
                                            color: Color(0XFB9C9BA6),
                                          ),
                                        );
                                      case 14:
                                        return const Text(
                                          "02PM",
                                          style: TextStyle(
                                            fontSize: 9,
                                            color: Color(0XFB9C9BA6),
                                          ),
                                        );
                                      case 15:
                                        return const Text(
                                          "03PM",
                                          style: TextStyle(
                                            fontSize: 9,
                                            color: Color(0XFB9C9BA6),
                                          ),
                                        );
                                      case 16:
                                        return const Text(
                                          "04PM",
                                          style: TextStyle(
                                            fontSize: 9,
                                            color: Color(0XFB9C9BA6),
                                          ),
                                        );
                                    }
                                    return const SizedBox();
                                  },
                                ),
                              ),
                            ),
                            borderData: FlBorderData(show: false),
                            minX: 10,
                            maxX: 16,
                            minY: 0,
                            maxY: 700,
                            lineBarsData: [
                              LineChartBarData(
                                isCurved: true,
                                preventCurveOverShooting: true,
                                spots: const [
                                  FlSpot(10, 200),
                                  FlSpot(11, 250),
                                  FlSpot(12, 500), // Peak
                                  FlSpot(13, 300),
                                  FlSpot(14, 450),
                                  FlSpot(15, 400),
                                  FlSpot(16, 550),
                                ],
                                gradient: const LinearGradient(
                                  colors: [Colors.orange, Colors.deepOrange],
                                ),
                                belowBarData: BarAreaData(
                                  show: true,
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.orange.withValues(alpha: 0.3),
                                      Colors.transparent,
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                                dotData: FlDotData(show: false),
                                isStrokeCapRound: true,
                                barWidth: 3,
                              ),
                            ],
                            lineTouchData: LineTouchData(
                              enabled: true,
                              touchTooltipData: LineTouchTooltipData(
                                getTooltipItems: (touchedSpots) {
                                  return touchedSpots.map((spot) {
                                    return LineTooltipItem(
                                      "\$${spot.y.toInt()}",
                                      const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  }).toList();
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      offset: Offset(0, 4),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Reviews", style: TextStyle(fontSize: 14)),
                        Text(
                          "See All Reviews",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0XFBFB6D3A),
                            decoration: TextDecoration.underline,
                            decorationColor: Color(0XFBFB6D3A),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Icon(Icons.star, size: 21.8, color: Color(0XFBFB6D3A)),
                        Text(
                          "4.9",
                          style: TextStyle(
                            color: Color(0XFBFB6D3A),
                            fontWeight: FontWeight.bold,
                            fontSize: 21.8,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Total 20 Reviews",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0XFB32343E),
                          ),
                        ),
                      ],
                    ),
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

void _showBottomSheet(BuildContext context) {
  showModalBottomSheet(
    enableDrag: true,
    showDragHandle: true,
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
    ),
    builder: (BuildContext context) {
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.7,
        // 70% of screen height
        minChildSize: 0.3,
        maxChildSize: 0.95,
        // almost full screen
        builder: (BuildContext context, ScrollController scrollController) {
          return RunningOrders();
        },
      );
    },
  );
}
