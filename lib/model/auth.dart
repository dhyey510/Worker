import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:worker/screen/HirerHome.dart';

class Auth{
  String Verificode;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signInPhone(String phone, BuildContext ctx) async {
    try {
      _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential).then((value) async {
            if(value.user!=null){
                Navigator.of(ctx).pushNamed(Profile.profileRoute,arguments: {'user':value.user});
            }
          });
        },
        verificationFailed: (FirebaseAuthException ex ) async {
          print(ex);
        },
        codeSent: (String verificationId, int resendToken) {
          Verificode=verificationId;
        },
        codeAutoRetrievalTimeout: (String veriID){
          Verificode=veriID;
        },
      );

    } catch (e) {
      print(e.toString());
    }
  }

  // state change then call this

  Stream<User> get user{
    return _auth.authStateChanges();
  }

  // signout
  Future signout() async{
    try {
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

}