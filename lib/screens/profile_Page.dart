import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/models/userModel.dart';

class ProfilePage extends StatefulWidget {
  final String userId;

  const ProfilePage({Key? key, required this.userId}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int followers = 0;
  int following = 0;
  int posts = 0;
  bool isFollowing = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instagram Profile'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.userId)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('User not found'));
          }

          UserModel user = UserModel.fromSnap(snapshot.data!);

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (user.photoUrl != null)
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(user.photoUrl!),
                  ),
                if (user.photoUrl == null)
                  GestureDetector(
                    onTap: () {
                      // Implement logic to allow user to add a profile photo
                      // For example, you can navigate to a page where the user can upload a photo
                    },
                    child: const CircleAvatar(
                      radius: 50,
                      child: Icon(Icons.add_a_photo),
                    ),
                  ),
                const SizedBox(height: 20.0),
                Text(
                  'Username: ${user.username}',
                  style: const TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10.0),
                Text(
                  'Full Name: ${user.fullname}',
                  style: const TextStyle(fontSize: 18.0),
                ),
                const SizedBox(height: 10.0),
                Text(
                  'Email: ${user.email}',
                  style: const TextStyle(fontSize: 18.0),
                ),
                const SizedBox(height: 10.0),
                Text(
                  'Followers: ${user.followers.length}',
                  style: const TextStyle(fontSize: 18.0),
                ),
                const SizedBox(height: 10.0),
                Text(
                  'Following: ${user.following.length}',
                  style: const TextStyle(fontSize: 18.0),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
