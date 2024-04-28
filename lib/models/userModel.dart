// The final keyword is used to declare a variable that can be assigned a value only once.
// Once a final variable is assigned, its value cannot be changed.
// Use final when you have a value that won’t change after initialization
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String email;
  final String uid;
  String? photoUrl; // Make photoUrl nullable
  final String username;
  final String fullname;
  final List followers;
  final List following;
  final List posts;

  UserModel(
      {required this.email,
      required this.uid,
      required this.followers,
      required this.following,
      required this.fullname,
      required this.photoUrl,
      required this.username,
      required this.posts});

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'email': email,
        'username': username,
        'fullname': fullname,
        'photoUrl': photoUrl,
        'followers': followers,
        'following': following,
        'posts': posts
      };

// Data Conversion:
// Firestore returns data as DocumentSnapshot, which needs to be converted to a format that the application can use.
// The fromSnap method takes the DocumentSnapshot, extracts the data, and creates a UserModel object with that data.

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    // Use the 'List.from' constructor to ensure a non-null List is created,
    // even if the source is null.
    return UserModel(
      email: snapshot['email'] ?? '',
      uid: snapshot['uid'] ?? '',
      followers: List.from(snapshot['followers'] ?? []),
      following: List.from(snapshot['following'] ?? []),
      fullname: snapshot['fullname'] ?? '',
      photoUrl: snapshot['photoUrl'] ?? '',
      username: snapshot['username'] ?? '',
      posts: List.from(snapshot['posts'] ?? []),
    );
  }
}
