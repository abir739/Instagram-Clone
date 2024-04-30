import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/add_post_page.dart';
import 'package:instagram_clone/screens/home_page.dart';
import 'package:instagram_clone/screens/notification_page.dart';
import 'package:instagram_clone/screens/profile_Page.dart';
import 'package:instagram_clone/screens/search_page.dart';

// for displaying snackbars
showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

List<Widget> pageItems = [
  const Center(child: HomePage()),
  Center(child: SearchPage()),
  const Center(child: AddPostPage()),
  Center(child: NotificationsPage()),
  Center(
      child: ProfilePage(
    userId: FirebaseAuth.instance.currentUser!.uid,
  )),
];
