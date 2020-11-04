import 'package:firebase_setup/Controllers/authController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUp extends GetWidget<AuthController> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController uidController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Full Name'),
                controller: nameController,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                controller: emailController,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'PassWord'),
                obscureText: true,
                controller: passwordController,
              ),
              SizedBox(
                height: 40,
              ),
              RaisedButton(
                  color: Colors.pinkAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    controller.createUser(
                        nameController.text,
                        emailController.text,
                        passwordController.text,
                        uidController.text);
                  }),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Text(
                    'Go Back',
                    style: TextStyle(color: Colors.pinkAccent, fontSize: 20.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
