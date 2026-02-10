import 'package:cached_network_image/cached_network_image.dart';
import 'package:chef_app/models/productModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FoodDetails extends StatefulWidget {
  final Product product;

  const FoodDetails({super.key, required this.product});

  @override
  State<FoodDetails> createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetails> {
  PageController foodImageController = PageController();

  final Map<String, String> foodIngredientsImages = {
    "Salt": "assets/ingredients/salt.png",
    "Chicken": "assets/ingredients/chicken.png",
    "Onion": "assets/ingredients/onion.png",
    "Garlic": "assets/ingredients/garlic.png",
    "Pappers": "assets/ingredients/pappers.png",
    "Ginger": "assets/ingredients/ginger.png",
  };

  @override
  void dispose() {
    foodImageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
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
                      itemCount: product.productImages.length,
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: CachedNetworkImage(
                            imageUrl: product.productImages[index],
                            fit: BoxFit.cover,
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
                            count: product.productImages.length,
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
                              product.delivery
                                  ? "Delivery"
                                  : product.pickup
                                  ? "Pickup"
                                  : "",
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
                      product.productName,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0XFB32343E),
                      ),
                    ),
                    Text(
                      "\$${product.productPrice}",
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
                      product.productRating.toString(),
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
              const SizedBox(height: 10),
              Container(
                height: 190,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.5,
                  ),
                  itemCount: product.ingredients.length,
                  itemBuilder: (context, index) {
                    final ingredient = product.ingredients[index];
                    final imgPath =
                        foodIngredientsImages[ingredient] ??
                        "assets/ingredients/salt.png";
                    return Column(
                      children: [
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0XFBFFEBE4),
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(imgPath, color: Color(0XFBFB6D3A)),
                        ),
                        Text(
                          ingredient,
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

              Divider(color: Color(0XFBF0F4F9), height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Description",
                  style: TextStyle(color: Color(0XFB32343E), fontSize: 14),
                ),
              ),
              Text(
                product.productDesc,
                style: TextStyle(fontSize: 13, color: Color(0XFB747783)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
