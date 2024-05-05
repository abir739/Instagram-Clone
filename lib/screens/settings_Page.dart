import 'package:flutter/material.dart';
import 'package:instagram_clone/app_data/auth_methods.dart';
import 'package:instagram_clone/screens/login_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),

        // Set icon color
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.account_circle), // Account Icon
            title: const Text('Account'),
            onTap: () {
              // Navigate to Account settings page
              // Implement navigation logic here
            },
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip), // Privacy Icon
            title: const Text('Privacy'),
            onTap: () {
              // Navigate to Privacy settings page
              // Implement navigation logic here
            },
          ),
          ListTile(
            leading: const Icon(Icons.security), // Security Icon
            title: const Text('Security'),
            onTap: () {
              // Navigate to Security settings page
              // Implement navigation logic here
            },
          ),
          ListTile(
            leading: const Icon(Icons.help), // Help Icon
            title: const Text('Help'),
            onTap: () {
              // Navigate to Help page
              // Implement navigation logic here
            },
          ),
          ListTile(
            leading: const Icon(Icons.info), // About Icon
            title: const Text('About'),
            onTap: () {
              // Navigate to About page
              // Implement navigation logic here
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.red,
            ), // Help Icon
            title: const Text(
              'Sign Out',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            onTap: () async {
              await AuthenticationMethods().signout();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            },
          ),
        ],
      ),
    );
  }
}
