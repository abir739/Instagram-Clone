import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),

        // Set icon color
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.account_circle), // Account Icon
            title: Text('Account'),
            onTap: () {
              // Navigate to Account settings page
              // Implement navigation logic here
            },
          ),
          ListTile(
            leading: Icon(Icons.privacy_tip), // Privacy Icon
            title: Text('Privacy'),
            onTap: () {
              // Navigate to Privacy settings page
              // Implement navigation logic here
            },
          ),
          ListTile(
            leading: Icon(Icons.security), // Security Icon
            title: Text('Security'),
            onTap: () {
              // Navigate to Security settings page
              // Implement navigation logic here
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications), // Notifications Icon
            title: Text('Notifications'),
            onTap: () {
              // Navigate to Notifications settings page
              // Implement navigation logic here
            },
          ),
          ListTile(
            leading: Icon(Icons.help), // Help Icon
            title: Text('Help'),
            onTap: () {
              // Navigate to Help page
              // Implement navigation logic here
            },
          ),
          ListTile(
            leading: Icon(Icons.info), // About Icon
            title: Text('About'),
            onTap: () {
              // Navigate to About page
              // Implement navigation logic here
            },
          ),
        ],
      ),
    );
  }
}
