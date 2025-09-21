import 'package:flutter/material.dart';
import 'package:mobile/Pages/Login_screen.dart';
import 'package:mobile/Pages/ManufacturingOrder.dart';
import 'package:mobile/Pages/login.dart';

import 'Pages/Home_Screen.dart';
import 'Pages/Settings.dart';
import 'Pages/profile.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/l',
      routes: {
        '/l':(context) => AuthPage(),
        '/s':(context) => settings(),
        '/p':(context) => ProfileSetupPage(),
        '/':(context) => HomeScreen(),
        '/manufacturing':(context) => ManufacturingOrderPage(),



      },
    );
  }
}
