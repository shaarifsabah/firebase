import 'file:///D:/flutter%20projects/firebase_setup/lib/Screens/LoginPage.dart';
import 'file:///D:/flutter%20projects/firebase_setup/lib/Screens/SignUp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_setup/Controllers/bindings/bindings.dart';
import 'package:firebase_setup/utils/root.dart';
import 'package:flutter/material.dart';
import 'package:firebase_setup/Controllers/authController.dart';
import 'Screens/Home.dart';
import 'package:path/path.dart';
import 'package:get/get.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AuthBinding(),
      debugShowCheckedModeBanner: false,
      home:Root(),
      theme: ThemeData(
          primaryColor: Colors.pinkAccent,
          accentColor: Colors.white,
          fontFamily: "RussoOne",
      ),
    );
  }
}
