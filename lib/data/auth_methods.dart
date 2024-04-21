import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // Creates an instance of FirebaseAuth which is used to interact with the Firebase Authentication service.
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Method for signing up a new user with the provided details.
  Future<String> SignUp({
    required String email,
    required String password,
    required String fullname,
    required String username,
    // required Uint8List file,
  }) async {
    String resp = "error occurred"; // Default response if an error occurs.
    try {
      // Checks if all the fields are not empty or the file is not null.
      if (email.isNotEmpty ||
              password.isNotEmpty ||
              fullname.isNotEmpty ||
              username.isNotEmpty
          // ||
          // file != null
          ) {
        // Attempts to create a new user with the provided email and password.
        UserCredential userCred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        // If successful, the UserCredential object will contain information about the newly created user.
        print(userCred.user!.uid);
        await _firestore.collection('users').doc(userCred.user!.uid).set({
          'username': username,
          'fullname': fullname,
          'email': email,
          'uid': userCred.user!.uid,
          'followers': [],
          'following': [],
        });
        resp = "success";
      }
    } catch (e) {
      // If an error occurs during the sign-up process, catch the exception and store its message in 'resp'.
      resp = e.toString();
    }
    // Returns the result, which will either be the default error message or a success message
    return resp;
  }
}
