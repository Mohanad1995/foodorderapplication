import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomAuthintication extends ChangeNotifier{
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn=GoogleSignIn();
   String userId,userEmail;
   dynamic messageErorr= '';
  dynamic get getMessageErorr=>messageErorr;
  String get getUserUid => userId;
  String get getUserEmail => userEmail;
  Future logIntoAccount(String email,String password) async{
    SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
    UserCredential userCredential;
    try {
      userCredential = await firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      User user=userCredential.user;
      userId=user.uid;
      userEmail= userCredential.user.email;
      sharedPreferences.setString('userId', userId);
      sharedPreferences.setString('userEmail', userEmail);
      print('getuserId $getUserUid');
      notifyListeners();
    } catch (e) {
      if (e.code == 'user-not-found') {
        messageErorr='user-not-found';
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        messageErorr='wrong-password';
        print('Wrong password provided for that user.');
      }
      else {
        messageErorr = 'email-faild';
        print('Wrong email provided for that user.');
      };
    }

  }
  Future createAccount(String email,String password) async{
    SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
    UserCredential userCredential;
    try {
      userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      User user=userCredential.user;
      userId=user.uid;
      sharedPreferences.setString('userId', userId);
      print(userId);
      notifyListeners();
    } catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    }
  }

}