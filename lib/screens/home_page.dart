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
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
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
        ),
        Image.network(
          'https://via.placeholder.com/600x400',
          width: MediaQuery.of(context).size.width,
          height: 300.0,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
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
