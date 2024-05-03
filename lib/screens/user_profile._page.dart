import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/models/userModel.dart';

class UsersProfilePage extends StatefulWidget {
  final UserModel user;

  const UsersProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  State<UsersProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<UsersProfilePage> {
  int followers = 0;
  int following = 0;
  int posts = 0;
  bool isFollowing = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Profile')),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to settings page
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: widget.user.photoUrl != null
                  ? NetworkImage(widget.user.photoUrl!)
                  : null,
              child: widget.user.photoUrl == null
                  ? const Icon(Icons.add_a_photo, size: 50)
                  : null,
            ),
            const SizedBox(height: 10),
            Text(
              widget.user.username,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.user.fullname,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatColumn('Posts', widget.user.posts.length),
                _buildStatColumn('Followers', widget.user.followers.length),
                _buildStatColumn('Following', widget.user.following.length),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Follow/Unfollow logic
              },
              child: Text(isFollowing ? 'Unfollow' : 'Follow'),
              style: ElevatedButton.styleFrom(
                primary: isFollowing ? Colors.grey : Colors.blue,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn(String label, int number) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          number.toString(),
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
