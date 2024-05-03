import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:instagram_clone/models/userModel.dart';
import 'package:instagram_clone/screens/user_profile._page.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  bool isUsers = false;

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onSubmitted: (String value) {
                setState(() {
                  isUsers = true;
                });
              },
            ),
            const SizedBox(height: 16.0),
            isUsers
                ? Expanded(
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .where('username',
                                isGreaterThanOrEqualTo: _searchController.text)
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: ((context, index) {
                                var user = snapshot.data!.docs[index];
                                return GestureDetector(
                               onTap: () {
                                    // Navigate to user profile page
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => UsersProfilePage(
                                          user: UserModel.fromSnap(user),
                                        ),
                                      ),
                                    );
                                  },
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        user['photoUrl'] != null &&
                                                user['photoUrl'].isNotEmpty
                                            ? user['photoUrl']
                                            : 'https://i.pinimg.com/564x/71/1a/8e/711a8e93dcabf86214671996f1b397fb.jpg',
                                      ),
                                    ),
                                    title: Text(user['username']),
                                    subtitle: Text(user['fullname']),
                                  ),
                                );
                              }));
                        }))
                : const Text(
                    'Popular Posts',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            const SizedBox(height: 8.0),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('posts')
                    .orderBy('likes')
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  // return GridView.builder(
                  //   gridDelegate:
                  //       const SliverGridDelegateWithFixedCrossAxisCount(
                  //     crossAxisCount: 3,
                  //     crossAxisSpacing: 8.0,
                  //     mainAxisSpacing: 8.0,
                  //   ),
                  //   itemCount: snapshot.data!.docs.length,
                  //   itemBuilder: ((context, index) {
                  //     var post = snapshot.data!.docs[index];
                  //     return Image.network(
                  //       post['postUrl'],
                  //       fit: BoxFit.cover,
                  //     );
                  //   }),
                  // );
                  return MasonryGridView.count(
                    crossAxisCount: 3,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: ((context, index) => Image.network(
                          snapshot.data!.docs[index]['postUrl'],
                          fit: BoxFit.cover,
                        )),
                    mainAxisSpacing: 9.0,
                    crossAxisSpacing: 9.0,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
