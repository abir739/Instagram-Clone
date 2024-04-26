import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/add_post_page.dart';


import 'package:image_picker/image_picker.dart';

// for picking up image from gallery
pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: source);
  if (file != null) {
    return await file.readAsBytes();
  }
}

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
  const Center(child: Text('Profile')),
];

