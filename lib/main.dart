import 'package:chef_app/cubits/product_cubit.dart';
import 'package:chef_app/indexPage.dart';
import 'package:chef_app/repositories/product_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ProductRepository>(
          create: (context) => ProductRepository(
            firebaseFirestore: FirebaseFirestore.instance,
            firebaseStorage: FirebaseStorage.instance,
          ),
        ),
      ],
      child: RepositoryProvider(
        create: (context) => ProductRepository(
          firebaseFirestore: FirebaseFirestore.instance,
          firebaseStorage: FirebaseStorage.instance,
        ),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<ProductCubit>(
              create: (context) => ProductCubit(
                productRepository: context.read<ProductRepository>(),
              ),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              bottomSheetTheme: BottomSheetThemeData(
                dragHandleColor: Color(0XFBC1C8D2),
                showDragHandle: true,
                dragHandleSize: Size(60, 6),
              ),
              scaffoldBackgroundColor: Colors.white,
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.white,
                elevation: 0,
                scrolledUnderElevation: 0,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                  statusBarBrightness: Brightness.light,
                ),
              ),
              textTheme: GoogleFonts.senTextTheme(),
            ),
            home: IndexPage(),
          ),
        ),
      ),
    );
  }
}
