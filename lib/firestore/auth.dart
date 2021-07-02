import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<bool> SignIn(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> Register(String email, String password,String name) async {
  try {
    print("firestor true");
    print(email);
    print(password);
    print("here");

    await FirebaseAuth.instance
    
        .createUserWithEmailAndPassword(email: email, password: password).then((value) {
          print("TRUUUUUUUUUUUUUUUUUUUUUUUE");
          print(value.credential.providerId);
        }
        
        );

    // final FirebaseAuth auth = FirebaseAuth.instance;
    // final User user = auth.currentUser;
    // final uid = user.uid;
    // print(uid);
    //       Firestore.instance
    //     .collection("Users")
    //     .doc(uid)
    //     .setData({
    //         'name' : name,
    //         'email':email,
    //         'statut':'student'
    //     })
    //     .catchError((e) {
    //   print(e);
    // });
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
    return false;
  } catch (e) {
    print(e.toString());
    return false;
  }
}