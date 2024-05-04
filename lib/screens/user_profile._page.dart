import 'package:firebase_auth/firebase_auth.dart';
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
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });

    try {
      // get post lENGTH
      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: widget.user.uid)
          .get();
      posts = postSnap.docs.length;

      setState(() {});
    } catch (e) {}
  }

  Future<void> follow(String uid, String followid) async {
    try {
      DocumentSnapshot snap =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      List followings = (snap.data()! as dynamic)['following'];

      if (followings.contains(followid)) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(followid)
            .update({
          'followers': FieldValue.arrayRemove([uid])
        });

        await FirebaseFirestore.instance.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([uid])
        });
      } else {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(followid)
            .update({
          'followers': FieldValue.arrayUnion([uid])
        });

        await FirebaseFirestore.instance.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([uid])
        });
        setState(() {
          isFollowing = true;
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> unfollow(String uid, String unfollowId) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'followers': FieldValue.arrayRemove([unfollowId])
      });

      await FirebaseFirestore.instance
          .collection('users')
          .doc(unfollowId)
          .update({
        'following': FieldValue.arrayRemove([uid])
      });

      setState(() {
        isFollowing = false;
      });
    } catch (e) {
      print(e.toString());
    }
  }

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
                _buildStatColumn('Posts', posts),
                _buildStatColumn('Followers', widget.user.followers.length),
                _buildStatColumn('Following', widget.user.following.length),
              ],
            ),
            const SizedBox(height: 20),
            isFollowing
                ? ElevatedButton(
                    onPressed: () async {
                      // Follow logic
                      await follow(FirebaseAuth.instance.currentUser!.uid,
                          widget.user.uid);
                      setState(() {
                        isFollowing = false;
                        widget.user.followers.length--;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 100, vertical: 10),
                    ),
                    child: const Text('Unfollow'),
                  )
                : ElevatedButton(
                    onPressed: () async {
                      await follow(FirebaseAuth.instance.currentUser!.uid,
                          widget.user.uid);
                      setState(() {
                        isFollowing = true;
                        widget.user.followers.length++;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 100, vertical: 10),
                    ),
                    child: Text('Follow'),
                  ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('posts')
                  .where('uid', isEqualTo: widget.user.uid)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  shrinkWrap: true,
                  itemCount: (snapshot.data! as dynamic).docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot post =
                        (snapshot.data! as dynamic).docs[index];

                    return Image.network(
                      post['postUrl'],
                      fit: BoxFit.cover,
                    );
                  },
                );
              },
            )
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
