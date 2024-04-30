import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   title: const Text(
      //     'Instagram',
      //     style: TextStyle(
      //       color: Colors.black,
      //       fontFamily: 'Billabong',
      //       fontSize: 32.0,
      //     ),
      //   ),
      //   actions: <Widget>[
      //     IconButton(
      //       icon: const Icon(Icons.add),
      //       color: Colors.black,
      //       onPressed: () {},
      //     ),
      //     IconButton(
      //       icon: const Icon(Icons.favorite),
      //       color: Colors.black,
      //       onPressed: () {},
      //     ),
      //     IconButton(
      //       icon: const Icon(Icons.message),
      //       color: Colors.black,
      //       onPressed: () {},
      //     ),
      //   ],
      // ),
      body: Container(
        child: ListView.builder(
          itemCount: 20, // Assuming you have 20 posts
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: PostWidget(), // Custom Widget for displaying a post
            );
          },
        ),
      ),
    );
  }
}

class PostWidget extends StatelessWidget {
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
              const Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 20.0,
                    backgroundImage:
                        NetworkImage('https://via.placeholder.com/150'),
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    'username',
                    style: TextStyle(
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
        Image.network(
          'https://via.placeholder.com/600x400',
          width: MediaQuery.of(context).size.width,
          height: 300.0,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              Row(
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.favorite_border),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.comment),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.share),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(
                width: 190,
              ),
              IconButton(
                icon: const Icon(Icons
                    .bookmark_border), // Add bookmark icon for saving the post
                onPressed: () {
                  // Add functionality to save the post
                },
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'Liked by username and 10 others',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Caption text here',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'View all 10 comments',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
        const SizedBox(height: 8.0),
      ],
    );
  }
}
