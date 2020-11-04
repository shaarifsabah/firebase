import 'package:firebase_setup/Controllers/authController.dart';
import 'package:firebase_setup/Screens/Home.dart';
import 'package:firebase_setup/Screens/Home.dart';
import 'package:firebase_setup/Controllers/authController.dart';
import 'package:firebase_setup/Controllers/authController.dart';
import 'package:firebase_setup/Controllers/userControllers.dart';
import 'package:firebase_setup/Screens/SplashScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Root extends GetWidget<AuthController>{

 @override
 Widget build(BuildContext context){
   return GetX(
     initState: (_)async {
       Get.put<UserController>(UserController());
       },
       builder: (_){
       if (Get.find<AuthController>().user?.uid != null){
         return Home();
       }
       else{
         return SplashScreen();
       }
   }
   ,
   );
 }

}