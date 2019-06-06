import 'package:cineproyecto/screens/home.dart';
import 'package:flutter/material.dart';
import 'screens/login.dart';  //aqui
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/home.dart';
import 'package:cineproyecto/screens/splashScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState(
  
  );
 }

 
class _MyAppState extends State<MyApp> {
  

   
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cine',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Splash(),
    );
  }
}
