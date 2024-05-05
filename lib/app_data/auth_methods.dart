import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/models/userModel.dart';

class AuthenticationMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // Creates an instance of FirebaseAuth which is used to interact with the Firebase Authentication service.
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late UserModel user;

  // Method for signing up a new user with the provided details.
  Future<String> signUp({
    required String email,
    required String password,
    required String fullname,
    required String username,
  }) async {
    String resp = "error occurred"; // Default response if an error occurs.
    try {
      // Checks if all the fields are not empty or the file is not null.
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          fullname.isNotEmpty ||
          username.isNotEmpty) {
        // Attempts to create a new user with the provided email and password.
        UserCredential userCred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        // Initialize the UserModel with the user's details.
        user = UserModel(
          uid: userCred.user!.uid,
          email: email,
          username: username,
          fullname: fullname,
          photoUrl:
              'https://i.pinimg.com/564x/f0/d3/d5/f0d3d5ab30a056c0063ce7e2389d09b4.jpg',
          followers: [],
          following: [],
          posts: [],
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

// methode to sign out user

  Future<void> signout() async {
    await _auth.signOut();
  }
}
