import 'package:flutter/material.dart';
import 'package:resturant_main_scrolling_page/resturant_page.dart';

void main() {
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
       scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
      ),
      home: const ResturantPage(),
    );
  }
}
