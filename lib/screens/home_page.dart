import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/widgets/Animated_Heart.dart';
import 'package:instagram_clone/screens/widgets/post_comments.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: PostWidget(
                  snap: snapshot.data!.docs[index].data(),
                ), // Custom Widget for displaying a post
              );
            },
          );
        },
      ),
    );
  }
}

class PostWidget extends StatefulWidget {
  final snap;
  const PostWidget({Key? key, required this.snap}) : super(key: key);

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<dynamic> currentLikes = [];
  bool showAnimatedHeart = false;

  @override
  void initState() {
    super.initState();
    currentLikes = widget.snap['likes'] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage(
                      widget.snap['userImg'] != null &&
                              widget.snap['userImg'].isNotEmpty
                          ? widget.snap['userImg']
                          : 'https://i.pinimg.com/564x/71/1a/8e/711a8e93dcabf86214671996f1b397fb.jpg',
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    widget.snap['username'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {
                  // Add your options menu logic here
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        child: Wrap(
                          children: <Widget>[
                            ListTile(
                              leading: const Icon(Icons.favorite),
                              title: const Text('Add to favorites'),
                              onTap: () {
                                // Handle 'Add to favorites' action
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.info),
                              title: const Text('About this account'),
                              onTap: () {
                                // Handle 'About this account' action
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.remove_circle),
                              title: const Text('No longer follow'),
                              onTap: () {
                                // Handle 'No longer follow' action
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.visibility_off),
                              title: const Text('Hide'),
                              onTap: () {
                                // Handle 'Hide' action
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.report),
                              title: const Text('Report'),
                              onTap: () {
                                // Handle 'Report' action
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
        // GestureDetector(
        //   onDoubleTap: () {
        //     setState(() {
        //       if (!currentLikes.contains(_auth.currentUser!.uid)) {
        //         currentLikes.add(_auth.currentUser!.uid);
        //         showAnimatedHeart = true;
        //         _playAnimation();
        //       }
        //       FirebaseFirestore.instance
        //           .collection('posts')
        //           .doc(widget.snap['postId'])
        //           .update({'likes': currentLikes});
        //     });
        //   },
        //   child: Stack(
        //     alignment: Alignment.center,
        //     children: [
        //       Image.network(
        //         widget.snap['postUrl'] ?? 'https://via.placeholder.com/600x400',
        //         width: MediaQuery.of(context).size.width,
        //         height: 300.0,
        //         fit: BoxFit.cover,
        //       ),
        //     ],
        //   ),
        // ),
        GestureDetector(
          onDoubleTap: () {
            setState(() {
              if (!currentLikes.contains(_auth.currentUser!.uid)) {
                currentLikes.add(_auth.currentUser!.uid);
                showAnimatedHeart = true;
                _playAnimation();
              }
              FirebaseFirestore.instance
                  .collection('posts')
                  .doc(widget.snap['postId'])
                  .update({'likes': currentLikes});
            });
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.network(
                widget.snap['postUrl'] ?? 'https://via.placeholder.com/600x400',
                width: MediaQuery.of(context).size.width,
                height: 300.0,
                fit: BoxFit.cover,
              ),
              if (showAnimatedHeart) AnimatedHeart(),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  // the logic for incrementing the likes count when the like button is pressed
                  // This code checks if the current user's ID is already in the list of likes for the post.
                  // If not, it adds the ID to the list and updates the Firestore document
                  // when the user taps the like button, it will toggle between liking and unliking the post,
                  // and the UI will reflect the change in real-time.
                  IconButton(
                    icon: Icon(
                      currentLikes.contains(_auth.currentUser!.uid)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: currentLikes.contains(_auth.currentUser!.uid)
                          ? Colors.red
                          : null,
                    ),
                    onPressed: () {
                      setState(() {
                        // Toggle like status
                        if (currentLikes.contains(_auth.currentUser!.uid)) {
                          // Unlike post
                          currentLikes.remove(_auth.currentUser!.uid);
                        } else {
                          // Like post
                          currentLikes.add(_auth.currentUser!.uid);
                        }
                        // Update Firestore
                        FirebaseFirestore.instance
                            .collection('posts')
                            .doc(widget.snap['postId'])
                            .update({'likes': currentLikes});
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.comment),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CommentsScreen(postId: widget.snap['postId']),
                          ));
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.share),
                    onPressed: () {},
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.bookmark_border),
                onPressed: () {
                  // Add functionality to save the post
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child:
             
              Text(
            '${widget.snap['likes'].length} likes',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.snap['caption'] ?? 'Caption text here',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
        //   child: Text(
        //     '${widget.snap['comments'].length} Comments',
        //     style: const TextStyle(
        //       color: Colors.grey,
        //     ),
        //   ),
        // ),

// fetch the comments data from Firestore and then count the number of comments for that specific post
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    CommentsScreen(postId: widget.snap['postId']),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('posts')
                  .doc(widget.snap['postId'])
                  .collection('comments')
                  .snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                int commentsCount = snapshot.data!.docs.length;
                return Text(
                  '$commentsCount Comments',
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                );
              },
            ),
          ),
        ),

        const SizedBox(height: 8.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            DateFormat('dd/MM/yyyy').format(
              DateTime.fromMillisecondsSinceEpoch(
                widget.snap['postedDate'].seconds * 1000,
              ),
            ),
            style: const TextStyle(color: Colors.grey),
          ),
        ),
        const SizedBox(height: 8.0),
      ],
    );
  }

  void _playAnimation() async {
    await Future.delayed(const Duration(milliseconds: 100));
    setState(() {
      showAnimatedHeart = false;
    });
  }
}
