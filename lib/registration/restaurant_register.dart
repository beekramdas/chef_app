import 'dart:io';

import 'package:chef_app/cubits/restaurant/restaurant_cubit.dart';
import 'package:chef_app/indexPage.dart';
import 'package:chef_app/repositories/restaurant_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';

class RestaurantRegister extends StatefulWidget {
  const RestaurantRegister({super.key});

  @override
  State<RestaurantRegister> createState() => _RestaurantRegisterState();
}

class _RestaurantRegisterState extends State<RestaurantRegister> {
  String? resName, role, phoneNumber, address;
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<File> _selectedFiles = [];

  @override
  void initState() {
    restaurantRepository = RestaurantRepository(
      firebaseFirestore: FirebaseFirestore.instance,
      firebaseStorage: FirebaseStorage.instance,
    );
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      context.read<RestaurantCubit>().getRestaurant(user.uid);
    }
    super.initState();
  }

  late final RestaurantRepository restaurantRepository;

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

  void addRestaurant() {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });

    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;
    form.save();
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("User not logged in!")));
    }
    context.read<RestaurantCubit>().addRestaurant(
      userId: user!.uid,
      resName: resName!,
      role: role!,
      phone: phoneNumber!,
      address: address!,
      files: _selectedFiles,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RestaurantCubit, RestaurantState>(
      listener: (context, state) {
        /// Success
        if (state.isSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Restaurant Added Successfully")),
          );

          context.read<RestaurantCubit>().resetState();

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => IndexPage()),
          );
        }

        /// Error
        if (state.errMsg.isNotEmpty) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errMsg)));

          context.read<RestaurantCubit>().resetState();
        }
      },
      builder: (context, state) {
        return PopScope(
          canPop: false,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Color(0XFBFF7622),
                title: Text(
                  "Please fill this form to register\n your restaurant in Food App",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Form(
                  key: _formKey,
                  autovalidateMode: _autovalidateMode,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 7,
                      children: [
                        SizedBox(height: 10),
                        Text("Enter your restaurant details:"),
                        SizedBox(height: 10),
                        Text(
                          "Restaurant name",
                          style: TextStyle(
                            color: Color(0XFB32343E),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            hintText: "Birtamod Cafe",
                            hintStyle: TextStyle(fontSize: 14),
                            fillColor: Color(0xFFF0F5FA),
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Restaurant name required";
                            }
                            return null;
                          },
                          onSaved: (String? value) {
                            resName = value;
                          },
                        ),
                        Text(
                          "Role",
                          style: TextStyle(
                            color: Color(0XFB32343E),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: "Owner/Staff/Manager/Chef",
                            hintStyle: TextStyle(fontSize: 14),
                            fillColor: Color(0xFFF0F5FA),
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Role required";
                            }
                            return null;
                          },
                          onSaved: (String? value) {
                            role = value;
                          },
                        ),
                        Text(
                          "Restaurant Contact number",
                          style: TextStyle(
                            color: Color(0XFB32343E),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: "Phone number must be with country code",
                            hintStyle: TextStyle(fontSize: 14),
                            fillColor: Color(0xFFF0F5FA),
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Phone number required";
                            }
                            if (value.trim().length < 9) {
                              return "Please enter a valid phone number";
                            }
                            return null;
                          },
                          onSaved: (String? value) {
                            phoneNumber = value;
                          },
                        ),
                        Text(
                          "Restaurant address",
                          style: TextStyle(
                            color: Color(0XFB32343E),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "Street address",
                            hintStyle: TextStyle(fontSize: 14),
                            fillColor: Color(0xFFF0F5FA),
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Restaurant address required";
                            }
                            if (value.trim().length < 4) {
                              return "Enter valid address";
                            }
                            return null;
                          },
                          onSaved: (String? value) {
                            address = value;
                          },
                        ),
                        Text(
                          "UPLOAD PHOTO/VIDEO",
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0XFB32343E),
                            letterSpacing: 2,
                          ),
                        ),

                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: AlwaysScrollableScrollPhysics(),
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
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemCount: _selectedFiles.length,
                                        itemBuilder: (context, index) {
                                          final file = _selectedFiles[index];
                                          final isImage = restaurantRepository
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
                                                            .withValues(
                                                              alpha: 1,
                                                            ),
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

                        GestureDetector(
                          onTap: addRestaurant,
                          child: Container(
                            height: 62,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              color: Color(0XFBFF7622),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Center(
                              child: Text(
                                "SAVE ",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
