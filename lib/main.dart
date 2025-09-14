import 'package:chef_app/indexPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white, // 👈 Background color of status bar
      statusBarIconBrightness: Brightness.dark, // 👈 For Android
      statusBarBrightness: Brightness.light, // 👈 For iOS
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
      ),
      home: IndexPage(),
    );
  }
}
