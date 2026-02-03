import 'dart:io';

import 'package:chef_app/cubits/product_cubit.dart';
import 'package:chef_app/indexPage.dart';
import 'package:chef_app/pages/food/ingredientsTile.dart';
import 'package:chef_app/repositories/product_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';

class AddFood extends StatefulWidget {
  const AddFood({super.key});

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  late bool pickup = false;
  late bool delivery = false;
  int? ingredientsIndex;
  final TextEditingController _foodNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  List foodIngredients = [
    ["assets/ingredients/salt.png", "Salt"],
    ["assets/ingredients/chicken.png", "Chicken"],
    ["assets/ingredients/onion.png", "Onion"],
    ["assets/ingredients/garlic.png", "Garlic"],
    ["assets/ingredients/pappers.png", "Pappers"],
    ["assets/ingredients/ginger.png", "Ginger"],
    ["assets/ingredients/onion.png", "Onion"],
    ["assets/ingredients/pappers.png", "Pappers"],
  ];
  final Set<int> selectedIndexes = {};
  bool showAllIngredients = false;
  final List<File> _selectedFiles = [];
  late final ProductRepository productRepository;
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    productRepository = ProductRepository(
      firebaseFirestore: FirebaseFirestore.instance,
      firebaseStorage: FirebaseStorage.instance,
    );
  }

  Future<void> pickMedia() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'mp4', 'mov', 'avi'],
    );
    if (result != null) {
      setState(() {
        _selectedFiles.addAll(result.paths.map((path) => File(path!)).toList());
      });
    }
  }

  // Future<void> _saveProduct() async {
  //   if (_foodNameController.text.isEmpty ||
  //       _priceController.text.isEmpty ||
  //       _descController.text.isEmpty) {
  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(SnackBar(content: Text("⚠️ Please fill all fields")));
  //     return;
  //   }
  //
  //   if (_selectedFiles.isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text("⚠️ Please upload at least one image/video")),
  //     );
  //     return;
  //   }
  //
  //   setState(() => _isUploading = true);
  //
  //   try {
  //     // ✅ Upload images/videos
  //     final imageUrls = await productRepository.uploadMultipleFiles(
  //       _selectedFiles,
  //     );
  //
  //     // ✅ Get selected ingredients
  //     final selectedIngredients = selectedIndexes
  //         .map((index) => foodIngredients[index][1].toString())
  //         .toList();
  //
  //     // ✅ Create Product object using your model
  //     final product = Product(
  //       productName: _foodNameController.text.trim(),
  //       productImages: imageUrls,
  //       productPrice: int.parse(_priceController.text.trim()),
  //       ingredients: selectedIngredients,
  //       productDesc: _descController.text.trim(),
  //       productRating: 0.0,
  //       // default rating
  //       pickup: pickup,
  //       delivery: delivery,
  //     );
  //
  //     // ✅ Save to Firestore
  //     await productRepository.addProduct(product);
  //
  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(SnackBar(content: Text("✅ Product added successfully")));
  //
  //     // ✅ Clear form
  //     _foodNameController.clear();
  //     _priceController.clear();
  //     _descController.clear();
  //     _selectedFiles.clear();
  //     selectedIndexes.clear();
  //   } catch (e) {
  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(SnackBar(content: Text("❌ Error: $e")));
  //   }
  //
  //   setState(() => _isUploading = false);
  // }

  @override
  Widget build(BuildContext context) {
    final ingredientsToShow = showAllIngredients
        ? foodIngredients
        : foodIngredients.take(6).toList();
    return BlocConsumer<ProductCubit, ProductState>(
      listener: (context, state) {
        if (state.isSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("✅✔️✔ Product Added Successfully.")),
          );
          _foodNameController.clear();
          _priceController.clear();
          _descController.clear();
          _selectedFiles.clear();
          selectedIndexes.clear();
          setState(() {});
          context.read<ProductCubit>().resetState();
        }
        if (state.errorMessage.isNotEmpty) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("❌${state.errorMessage}")));
          context.read<ProductCubit>().resetState();
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            scrolledUnderElevation: 0,
            elevation: 0,
            leadingWidth: double.maxFinite,
            backgroundColor: Colors.white,
            leading: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                spacing: 10,
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
                    "Add New Items",
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
                "RESET",
                style: TextStyle(fontSize: 14, color: Color(0XFBFB6D3A)),
              ),
              SizedBox(width: 15),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                spacing: 18,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Column(
                    spacing: 6,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "ITEM NAME",
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0XFB32343E),
                          letterSpacing: 2,
                        ),
                      ),
                      TextField(
                        controller: _foodNameController,
                        decoration: InputDecoration(
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Color(0XFBE8EAED)),
                          ),
                          enabled: true,
                          hintText: "Mazalichiken Halim",
                          hintStyle: TextStyle(
                            color: Color(0XFB9C9BA6),
                            letterSpacing: 2,
                          ),
                          fillColor: Color(0XFBFDFDFD),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Color(0XFBE8EAED)),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
                    children: [
                      Text(
                        "UPLOAD PHOTO/VIDEO",
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0XFB32343E),
                          letterSpacing: 2,
                        ),
                      ),
                      SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          spacing: 30,
                          children: [
                            GestureDetector(
                              onTap: pickMedia,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 14,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: DashedBorder.fromBorderSide(
                                    side: BorderSide(
                                      color: Color(0XFBE8EAED),
                                      width: 1.5,
                                    ),
                                    dashLength: 9.0,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 13,
                                        vertical: 8,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 22,
                                        vertical: 17,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Color(
                                          0XFB523BB1,
                                        ).withValues(alpha: 0.10),
                                        shape: BoxShape.circle,
                                      ),
                                      child: SvgPicture.asset(
                                        "assets/upload.svg",
                                      ),
                                    ),
                                    Text(
                                      "Add",
                                      style: TextStyle(
                                        color: Color(0XFB9C9BA6),
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            _selectedFiles.isEmpty
                                ? Text("No files uploaded")
                                : SizedBox(
                                    height: 101,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: _selectedFiles.length,
                                      itemBuilder: (context, index) {
                                        final file = _selectedFiles[index];
                                        final isImage = productRepository
                                            .isImage(file);

                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            right: 10,
                                          ),
                                          child: Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: isImage
                                                    ? Image.file(
                                                        file,
                                                        width: 100,
                                                        height: 100,
                                                        fit: BoxFit.cover,
                                                      )
                                                    : Container(
                                                        width: 100,
                                                        height: 100,
                                                        color: Colors.black12,
                                                        child: const Icon(
                                                          Icons.videocam,
                                                          size: 40,
                                                        ),
                                                      ),
                                              ),
                                              Positioned(
                                                top: 0,
                                                right: 0,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      _selectedFiles.removeAt(
                                                        index,
                                                      );
                                                    });
                                                  },
                                                  child: Container(
                                                    height: 22,
                                                    width: 22,
                                                    decoration: BoxDecoration(
                                                      color: Colors.red
                                                          .withValues(alpha: 1),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: const Icon(
                                                      Icons.close,
                                                      size: 14,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: 7,
                    children: [
                      Text(
                        "PRICE",
                        style: TextStyle(
                          letterSpacing: 2,
                          fontSize: 13,
                          color: Color(0XFB32343E),
                        ),
                      ),
                      Row(
                        spacing: 18,
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _priceController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 20,
                                  horizontal: 5,
                                ),
                                hintText: "\$50",
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  letterSpacing: 2,
                                  color: Color(0XFB9C9BA6),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Color(0XFBE8EAED),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Color(0XFBE8EAED),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                pickup = !pickup;
                                print(pickup);
                              });
                            },
                            child: Row(
                              spacing: 7,
                              children: [
                                Container(
                                  height: 19,
                                  width: 19,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Color(0xFFFB6D3A),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: pickup
                                      ? Center(
                                          child: Icon(
                                            Icons.check,
                                            size: 18,
                                            color: Color(0xFFFB6D3A),
                                          ),
                                        )
                                      : null,
                                ),

                                Text(
                                  "Pick up",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0XFB9C9BA6),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () => setState(() => delivery = !delivery),
                            child: Row(
                              spacing: 7,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 19,
                                  width: 19,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Color(0xFFFB6D3A),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: delivery
                                      ? Center(
                                          child: Icon(
                                            Icons.check,
                                            size: 18,
                                            color: Color(0xFFFB6D3A),
                                          ),
                                        )
                                      : null,
                                ),
                                Text(
                                  "Delivery",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0XFB9C9BA6),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    "INGREDIENTS",
                    style: TextStyle(
                      letterSpacing: 2,
                      fontSize: 13,
                      color: Color(0XFB32343E),
                    ),
                  ),
                  Column(
                    spacing: 9,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Basic",
                            style: TextStyle(
                              letterSpacing: 2,
                              fontSize: 14,
                              color: Color(0XFB32343E),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                showAllIngredients = !showAllIngredients;
                              });
                            },
                            child: Row(
                              children: [
                                Text(
                                  showAllIngredients ? "See Less" : "See All",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0XFB9C9BA6),
                                    letterSpacing: 1,
                                  ),
                                ),
                                Icon(
                                  showAllIngredients
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down,
                                  color: Color(0XFB9C9BA6),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: List.generate(ingredientsToShow.length, (
                            index,
                          ) {
                            final actualIndex = foodIngredients.indexOf(
                              ingredientsToShow[index],
                            );
                            final isSelected = selectedIndexes.contains(
                              actualIndex,
                            );
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (isSelected) {
                                    selectedIndexes.remove(actualIndex);
                                  } else {
                                    selectedIndexes.add(actualIndex);
                                  }
                                  print(selectedIndexes.contains(actualIndex));
                                });
                              },
                              child: IngredientsTile(
                                ingredientsImgPath: ingredientsToShow[index][0],
                                ingredientsName: ingredientsToShow[index][1],
                                selectedIngredients: isSelected,
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
                    children: [
                      Text(
                        "DETAILS",
                        style: TextStyle(
                          color: Color(0XFB32343E),
                          letterSpacing: 2,
                          fontSize: 13,
                        ),
                      ),
                      TextField(
                        controller: _descController,
                        maxLines: 4,
                        // you can change height by increasing/decreasing this
                        decoration: InputDecoration(
                          hintText:
                              "Lorem ipsum dolor sit amet, consectetur adips cing elit. Bibendum in vel, mattis et amet dui mauris turpis.",
                          hintStyle: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFB6B6E82),
                            letterSpacing: 2,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.all(13),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                              color: Color(0xFBE8EAED),
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color(0xFFFB6D3A), // highlight on focus
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: GestureDetector(
                      onTap: state.isLoading
                          ? null
                          : () {
                              final selectedIngredients = selectedIndexes
                                  .map(
                                    (index) =>
                                        foodIngredients[index][1].toString(),
                                  )
                                  .toList();
                              context.read<ProductCubit>().addProduct(
                                name: _foodNameController.text,
                                files: _selectedFiles,
                                price: _priceController.text,
                                ingredients: selectedIngredients,
                                desc: _descController.text,
                                pickup: pickup,
                                delivery: delivery,
                              );
                            },
                      child: Container(
                        height: 62,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: Color(0XFBFF7622),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Center(
                          child: state.isLoading
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text(
                                  "SAVE CHANGES",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
