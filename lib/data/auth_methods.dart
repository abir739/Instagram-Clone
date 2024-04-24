import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/models/userModel.dart';

class AuthenticationMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // Creates an instance of FirebaseAuth which is used to interact with the Firebase Authentication service.
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late UserModel user;

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

        // Initialize the UserModel with the user's details.
        user = UserModel(
          uid: userCred.user!.uid,
          email: email,
          username: username,
          fullname: fullname,
          // pictue:
          //     'data:image/jpeg;base64,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',
          followers: [],
          following: [],
        );

        // If successful, the UserCredential object will contain information about the newly created user.
        await _firestore.collection('users').doc(userCred.user!.uid).set(
              user.toJson(),
            );
        resp = "success";
      }
    } catch (e) {
      // If an error occurs during the sign-up process, catch the exception and store its message in 'resp'.
      resp = e.toString();
    }
    // Returns the result, which will either be the default error message or a success message
    return resp;
  }

// Method for logging in a user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String resp = "error occurred";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        resp = "success";
      } else {
        resp = "Please enter valid fields";
      }
    } catch (e) {
      resp = e.toString();
    }
    return resp;
  }

// method to get user data

  Future<UserModel> fetchUserData() async {
    User? firebaseUser =
        _auth.currentUser; // Get the current user from FirebaseAuth

    if (firebaseUser != null) {
      DocumentSnapshot snap =
          await _firestore.collection('users').doc(firebaseUser.uid).get();

      return UserModel.fromSnap(snap); // Convert the snapshot to a UserModel
    } else {
      throw Exception('No user logged in');
    }
  }
}
