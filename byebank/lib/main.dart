import 'package:byebank/login/login_screen.dart';
import 'package:byebank/menu.dart';
import 'package:byebank/resgate.dart';
import 'package:byebank/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        Menu.routeName: (context) => Menu(),
        LoginScreen.routeName: (context) => LoginScreen(),
        Resgate.routeName: (context) => Resgate(),
      },
    );
  }
}
