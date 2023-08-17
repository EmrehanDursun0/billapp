import 'package:billapp/menu/menu.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
    Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.deepPurple, // Uygulama temel rengi
        hintColor: Colors.amber, // Vurgu rengi
      ),
      home: HomeMenu(),
    
      debugShowCheckedModeBanner: false,
    );
  }
}
