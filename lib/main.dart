import 'package:flutter/material.dart';
import 'package:flutter_course/HomePage.dart';
import 'package:flutter_course/CartPage.dart';
import 'package:flutter_course/account.dart';
import 'package:flutter_course/detail_item.dart';
import 'package:flutter_course/products.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blueGrey,
          foregroundColor: Colors.white,
          centerTitle: true,
          titleTextStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        textTheme: TextTheme(
          bodySmall: TextStyle(color: Colors.black87, fontSize: 14),
          bodyMedium: TextStyle(color: Colors.black54, fontSize: 16),
          bodyLarge: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
      home: HomePage(),
      routes: {
        "home": (context) => HomePage(),
        "CartPage": (context) => CartPage(cartItems: []),
        "detailitem": (context) => DetailItem(data: {}, cartItems: []),
        "account": (context) => AccountPage(cartItems: []),
        "products": (context) => Products(),
      },
    );
  }
}
