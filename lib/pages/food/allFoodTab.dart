import 'package:chef_app/cubits/product_cubit.dart';
import 'package:chef_app/pages/food/foodDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllFoodTab extends StatefulWidget {
  const AllFoodTab({super.key});

  @override
  State<AllFoodTab> createState() => _AllFoodTabState();
}

class _AllFoodTabState extends State<AllFoodTab> {
  // final List allFoodItems = [
  //   ["Chicken Biryani", "Breakfast", 4.9, 60, "Pickup"],
  //   ["Chicken Bhuna", "Lunch", 4.6, 30, "Delivery"],
  //   ["Mazalichiken Halim", "Dinner", 4.0, 60, "Pickup"],
  //   ["Mazalichiken Halim", "Dinner", 4.0, 60, "Pickup"],
  //   ["Mazalichiken Halim", "Dinner", 4.0, 60, "Pickup"],
  //   ["Mazalichiken Halim", "Dinner", 4.0, 60, "Pickup"],
  // ];

  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state.isLoading) {
          return Center(child: CircularProgressIndicator());
        }
        final allFoodItems = state.products;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Total ${allFoodItems.length.toString()} items",
              style: TextStyle(fontSize: 14, color: Color(0XFB9C9BA6)),
            ),
            Expanded(
              child: ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                primary: true,
                scrollDirection: Axis.vertical,
                itemCount: allFoodItems.length,
                itemBuilder: (context, index) {
                  final product = allFoodItems[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FoodDetails(),
                          ),
                        );
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 22,
                        children: [
                          Container(
                            height: 102,
                            width: 102,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0XFB98A8B8),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 13,
                            children: [
                              Text(
                                product.productName,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0XFB32343E),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 9,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(
                                    0XFBFF7622,
                                  ).withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(29.28),
                                ),
                                child: Text(
                                  "Breakfast",
                                  style: TextStyle(
                                    color: Color(0XFBFF7622),
                                    fontSize: 13.67,
                                  ),
                                ),
                              ),
                              Row(
                                spacing: 10,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Color(0XFBFF7622),
                                    size: 17,
                                  ),
                                  Text(
                                    product.productRating.toString(),
                                    style: TextStyle(
                                      color: Color(0XFBFF7622),
                                      fontSize: 13.67,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "(10 Review)",
                                    style: TextStyle(
                                      color: Color(0XFBAFAFAF),
                                      fontSize: 13.67,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Expanded(
                            child: Column(
                              spacing: 18,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.more_horiz,
                                  size: 24,
                                  color: Color(0XFB32343E),
                                ),
                                Text(
                                  "\$${product.productPrice}",
                                  style: TextStyle(
                                    fontSize: 17.49,
                                    color: Color(0XFB32343E),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  product.delivery
                                      ? "Delivery"
                                      : product.pickup
                                      ? "Pickup"
                                      : "",
                                  style: TextStyle(
                                    color: Color(0XFBAFAFAF),
                                    fontSize: 13.6,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
