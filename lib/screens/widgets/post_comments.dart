import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/models/userModel.dart';
import 'package:instagram_clone/providers/userProvider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CommentsScreen extends StatefulWidget {
  final String postId;

  const CommentsScreen({Key? key, required this.postId}) : super(key: key);

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _commentController = TextEditingController();

  Future<void> postComment(
      String text, String uid, String username, String userImg) async {
    try {
      if (text.isNotEmpty) {
        String commentId = const Uuid().v1();
        await _firestore
            .collection('posts')
            .doc(widget.postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'commentId': commentId,
          'uid': uid,
          'userImg': userImg,
          'username': username,
          'text': text,
          'likes': [],
          'datePosted': FieldValue.serverTimestamp() // Use server timestamp
        });
        // Clear the comment text field after posting
        _commentController.clear();
      } else {
        print('Text is empty');
      }
    } catch (e) {
      print('Error posting comment: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserModel? user = Provider.of<UserProvider>(context).fetchUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Comments',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.grey[200],
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('posts')
                  .doc(widget.postId)
                  .collection('comments')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var comment = snapshot.data!.docs[index];
                    List<dynamic> commentLikes = comment['likes'] ?? [];
                    return ListTile(
                      leading: CircleAvatar(
                        // backgroundImage: NetworkImage(comment['userImg']),
                        backgroundImage: NetworkImage(
                          comment['userImg'] != null &&
                                  comment['userImg'].isNotEmpty
                              ? comment['userImg']
                              : 'https://i.pinimg.com/564x/71/1a/8e/711a8e93dcabf86214671996f1b397fb.jpg',
                        ),
                      ),
                      title: Text(comment['username']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(comment['text']),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (commentLikes
                                        .contains(_auth.currentUser!.uid)) {
                                      commentLikes
                                          .remove(_auth.currentUser!.uid);
                                    } else {
                                      commentLikes.add(_auth.currentUser!.uid);
                                    }
                                    FirebaseFirestore.instance
                                        .collection('posts')
                                        .doc(widget.postId)
                                        .collection('comments')
                                        .doc(comment['commentId'])
                                        .update({'likes': commentLikes});
                                  });
                                },
                                icon: Icon(
                                  commentLikes.contains(_auth.currentUser!.uid)
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: commentLikes
                                          .contains(_auth.currentUser!.uid)
                                      ? Colors.red
                                      : null,
                                ),
                              ),
                              Text(
                                DateFormat('dd/MM/yyyy').format(
                                    (comment['datePosted'] as Timestamp)
                                        .toDate()),
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    user?.photoUrl ?? 'https://via.placeholder.com/600x400',
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: _commentController, // Assign the controller
                    decoration:
                        const InputDecoration(hintText: 'Add comment...'),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    await postComment(
                        _commentController.text.trim(),
                        user!.uid,
                        user.username,
                        user.photoUrl ?? 'https://via.placeholder.com/600x400');
                  },
                  icon: const Icon(Icons.send),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
