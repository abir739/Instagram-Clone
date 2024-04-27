import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/add_post_page.dart';
import 'package:instagram_clone/screens/profile_Page.dart';

// for displaying snackbars
showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

List<Widget> pageItems = [
  const Center(child: Text('Home')),
  const Center(child: Text('Search')),
  const Center(child: AddPostPage()),
  const Center(child: Text('Notification')),
  Center(
      child: ProfilePage(
    userId: FirebaseAuth.instance.currentUser!.uid,
  )),
];
