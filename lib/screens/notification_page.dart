import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Add your search functionality here
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 20, // Assuming there are 20 notifications
        itemBuilder: (context, index) {
          return NotificationItem(
            // You can pass notification data to the NotificationItem widget here
            username: 'username',
            notificationText: 'Liked your photo',
            time: '2m', // Time of the notification
            onTap: () {
              // Add functionality to handle tapping on a notification
            },
          );
        },
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String username;
  final String notificationText;
  final String time;
  final VoidCallback onTap;

  NotificationItem({
    required this.username,
    required this.notificationText,
    required this.time,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        // You can load the user's profile image here
        backgroundColor: Colors.grey,
        radius: 20,
        child: Text(
          username[0],
          style: const TextStyle(color: Colors.white),
        ),
      ),
      title: Text(
        '$username $notificationText',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        '$time ago',
        style: const TextStyle(color: Colors.grey),
      ),
      onTap: onTap,
    );
  }
}
