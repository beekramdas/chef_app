import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FoodDetails extends StatefulWidget {
  const FoodDetails({super.key});

  @override
  State<FoodDetails> createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetails> {
  PageController foodImageController = PageController();

  List foodImages = [
    "assets/foods/food1.jpg",
    "assets/foods/image2.jpg",
    "assets/foods/image4.jpg",
    "assets/foods/food1.jpg",
    "assets/foods/image2.jpg",
    "assets/foods/image4.jpg",
  ];
  List foodIngredients = [
    ["assets/ingredients/salt.png", "Salt"],
    ["assets/ingredients/chicken.png", "Chicken"],
    ["assets/ingredients/onion.png", "Onion"],
    ["assets/ingredients/garlic.png", "Garlic"],
    ["assets/ingredients/pappers.png", "Pappers"],
    ["assets/ingredients/ginger.png", "Ginger"],
    ["assets/ingredients/onion.png", "Onion"],
    ["assets/ingredients/pappers.png", "Pappers"],
    ["assets/ingredients/ginger.png", "Ginger"],
  ];

  @override
  void dispose() {
    foodImageController.dispose();
    super.dispose();
  }

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
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Color(0XFBFB6D3A),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 15),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 210,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      controller: foodImageController,
                      itemCount: foodImages.length,
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            foodImages[index],
                            fit: BoxFit.fill,
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 0,
                    left: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        spacing: 10,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(61),
                              color: Colors.white.withValues(alpha: 0.8),
                            ),
                            child: Text(
                              "Breakfast",
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0XFB32343E),
                              ),
                            ),
                          ),
                          SmoothPageIndicator(
                            controller: foodImageController,
                            count: foodImages.length,
                            effect: ExpandingDotsEffect(
                              dotHeight: 10,
                              dotWidth: 10,
                              spacing: 3.5,
                              dotColor: Colors.white.withValues(alpha: 0.5),
                              activeDotColor: Colors.white,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(61),
                              color: Colors.white.withValues(alpha: 0.8),
                            ),
                            child: Text(
                              "Delivery",
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0XFB32343E),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Chicken Thai Biriyani",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0XFB32343E),
                      ),
                    ),
                    Text(
                      "\$60",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0XFB32343E),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Icon(
                      Icons.location_on,
                      color: Color(0XFBAFAFAF),
                      size: 13,
                    ),
                  ),
                  Text(
                    "Kentucky 3949",
                    style: TextStyle(fontSize: 13, color: Color(0XFBAFAFAF)),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Icon(Icons.star, size: 17, color: Color(0XFBFB6D3A)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      "4.9",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0XFBFB6D3A),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    "(10 Reviews)",
                    style: TextStyle(fontSize: 14, color: Color(0XFBAFAFAF)),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Divider(color: Color(0XFBF0F4F9)),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  "INGREDIENTS",
                  style: TextStyle(fontSize: 14, color: Color(0XFB32343E)),
                ),
              ),
              Container(
                height: 190,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.5,
                  ),
                  itemCount: foodIngredients.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0XFBFFEBE4),
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            foodIngredients[index][0],
                            color: Color(0XFBFB6D3A),
                          ),
                        ),
                        Text(
                          foodIngredients[index][1],
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0XFB747783),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Divider(color: Color(0XFBF0F4F9)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Description",
                  style: TextStyle(color: Color(0XFB32343E), fontSize: 14),
                ),
              ),
              Text(
                "Lorem ipsum dolor sit amet, consetdur Maton adipiscing elit. Bibendum in vel, mattis et amet dui mauris turpis.",
                style: TextStyle(fontSize: 13, color: Color(0XFB747783)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
