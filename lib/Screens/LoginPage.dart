import 'package:firebase_setup/Controllers/authController.dart';
import 'package:firebase_setup/Screens/SignUp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends GetWidget<AuthController> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text(
                        'Welcome',
                        style: TextStyle(
                          fontSize: 60.0,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        '!',
                        style:
                            TextStyle(color: Colors.pinkAccent, fontSize: 60.0),
                      ),
                    )
                  ],
                ),
                Container(
                  child: Text(
                    'Earnerss',
                    style: TextStyle(fontSize: 60.0),
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  controller: emailController,
                ),
                SizedBox(
                  height: 40.0,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  controller: passwordController,
                  obscureText: true,
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.bottomRight,
                    padding: EdgeInsets.only(top: 15.0),
                    child: InkWell(
                      child: Text(
                        'Forget Password',
                        style: TextStyle(color: Colors.pinkAccent),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: RaisedButton(
                    color: Colors.pinkAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      'LOGIN',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () {
                      controller.login(emailController.text, passwordController.text);
                    },
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                  ),
                  child: RaisedButton(
                    color: Colors.pinkAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child:
                              ImageIcon(AssetImage('images/s.png')),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Center(
                          child: Text(
                            "Login In With Google",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        )
                      ],
                    ),
                    onPressed: (){
                      controller.signInWithGoogle();
                    },
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('New To Earnerss'),
                    SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(SignUp());
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.pinkAccent),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
