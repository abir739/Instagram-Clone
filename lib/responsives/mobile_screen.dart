import 'package:flutter/material.dart';
import 'package:instagram_clone/models/userModel.dart';
import 'package:instagram_clone/providres/userProvider.dart';
import 'package:provider/provider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({Key? key}) : super(key: key);

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    UserModel? user = Provider.of<UserProvider>(context)?.fetchUser;

    // If user is not null, continue building the UI
    return Scaffold(
      body: Center(
        child: Text(user!.email), // or any other property you want to display
      ),
      // bottomNavigationBar: CurvedNavigationBar(
      //   backgroundColor:
      //       Colors.white, // Change this to match Instagram's background color
      //   color: Colors.blue, // Change this to match Instagram's primary color
      //   buttonBackgroundColor:
      //       Colors.blue, // Change this to match Instagram's primary color
      //   items: <Widget>[
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.black, // #405DE6
        color: Colors.white, // #C13584
        buttonBackgroundColor: Color.fromARGB(255, 250, 131, 4), // #FBAF45
        items: const <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: Colors.black,
          ),
          Icon(
            Icons.search,
            size: 30,
            color: Colors.black,
          ),
          Icon(
            Icons.add,
            size: 30,
            color: Colors.black,
          ),
          Icon(
            Icons.favorite,
            size: 30,
            color: Colors.black,
          ),
          Icon(
            Icons.account_circle,
            size: 30,
            color: Colors.black,
          ),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}
