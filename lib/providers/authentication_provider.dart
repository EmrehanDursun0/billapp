import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';

enum SignInMethod { emailAndPassword, google }

class AuthenticationProvider extends ChangeNotifier {
  final UserModel userModel = UserModel(
    email: '',
    password: '',
  );
  final firebase = FirebaseAuth.instance;
  User? currentUser = FirebaseAuth.instance.currentUser;
  SignInMethod method = SignInMethod.emailAndPassword;

  void signWithEmailAndPassword() async {
    try {
      if (userModel.authMode == AuthMode.login) {
        await firebase.signInWithEmailAndPassword(
            email: userModel.email.trimRight(),
            password: userModel.password.trimRight());
      } else {
       
      
        notifyListeners();
      }
    } on FirebaseAuthException catch (error) {
      
      print(error);
    }
  }

  void submitUserData(
    String? email,
    AuthMode authMode,
    String? password,
  ) {
    userModel.email = email!;

    userModel.authMode = authMode;
    userModel.password = password!;
    notifyListeners();
  }
}
