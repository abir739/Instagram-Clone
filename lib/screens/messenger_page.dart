import 'package:flutter/material.dart';

class MessagesScreen extends StatefulWidget {
  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Messages',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Add functionality to navigate back
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {
              // Add functionality to search messages
            },
          ),
          IconButton(
            icon: Icon(Icons.add, color: Colors.black),
            onPressed: () {
              // Add functionality to add new message
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 10, // Change this to the number of messages
        itemBuilder: (context, index) {
          return MessageListItem(
            profileImage:
                'assets/images/profile_image.jpg', // Replace with actual image path
            username: 'Username $index', // Replace with actual username
            message:
                'This is a message from user $index', // Replace with actual message content
            time: '10:30 AM', // Replace with actual message time
            onTap: () {
              // Add functionality to open message thread
            },
            key: ValueKey(index), // Use ValueKey instead of Key
          );
        },
      ),
    );
  }
}

class MessageListItem extends StatelessWidget {
  final String profileImage;
  final String username;
  final String message;
  final String time;
  final void Function()? onTap; // Correct function type

  const MessageListItem({
    required Key key,
    required this.profileImage,
    required this.username,
    required this.message,
    required this.time,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundImage: AssetImage(profileImage),
        radius: 24,
      ),
      title: Text(
        username,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        message,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(
        time,
        style: TextStyle(color: Colors.grey),
      ),
    );
  }
}
