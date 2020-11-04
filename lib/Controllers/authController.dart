import 'dart:ffi';
import 'package:firebase_setup/Screens/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_setup/Controllers/userControllers.dart';
import 'package:firebase_setup/Model/user.dart';
import 'package:firebase_setup/Services/database.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';



class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<User> _firebaseUser = Rx<User>();
  User get user => _firebaseUser.value;
  @override
  onInit() {
    _firebaseUser.bindStream(_auth.authStateChanges());
  }
  void createUser(
      String name, String email, String password, String uid) async {
    try {
      UserCredential _authResult = await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);
      //create user in database.dart
      UserModel _user = UserModel(
        id: _authResult.user.uid,
        name: name,
        email: _authResult.user.email,
      );
      if (await Database().createNewUser(_user)) {
        Get.find<UserController>().user = _user;
        Get.to(Home());
      }
    } catch (e) {
      Get.snackbar(
        'Error Creating Account',
        e.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
  void login(String email, String password) async {
    try {
      UserCredential _authResult = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
      Get.to(Home());
      Get.find<UserController>().user =
      await Database().getUser(_authResult.user.uid);
    } catch (e) {
      Get.snackbar('Error Signing In', e.message,
          snackPosition: SnackPosition.BOTTOM);
    }
  }
  void signOut() async {
    try {
      await _auth.signOut();
      Get.back();
      Get.find<UserController>().clear();
    } catch (e) {
      Get.snackbar('Error Signing Out', e.message,
          snackPosition: SnackPosition.BOTTOM);
    }
  }
  Future<String> signInWithGoogle() async {
    String retVal = 'Error';
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    UserModel _user = UserModel();
    try {
      GoogleSignInAccount _googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication _googleAuth = await _googleUser.authentication;
      Get.to(Home());
      AuthCredential credential = GoogleAuthProvider.credential(
          idToken: _googleAuth.idToken, accessToken: _googleAuth.accessToken);
      UserCredential _authResult = await _auth.signInWithCredential(credential);
      if (_authResult.additionalUserInfo.isNewUser) {
        _user.id = _authResult.user.uid;
        _user.email = _authResult.user.email;
        _user.name = _authResult.user.displayName;
        Database().createNewUser(_user);

      }
      retVal = 'success';
    } catch (e) {
      retVal = e.message;
    }
    return retVal;
  }
}