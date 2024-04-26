import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/models/userModel.dart';
import 'package:instagram_clone/providres/userProvider.dart';
import 'package:instagram_clone/utils/variablesUtil.dart';
import 'package:provider/provider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({Key? key}) : super(key: key);

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  int _selectedIndex = 0;

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(index,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    UserModel? user = Provider.of<UserProvider>(context).fetchUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: SvgPicture.asset(
          'assets/images/instagram_icon.svg',
          height: 30,
          // width: 30,
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.notifications,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.messenger_outline_rounded,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: PageView(
          controller: _pageController,
          // physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          children: pageItems),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.black, // #405DE6
        color: Colors.white, // #C13584
        buttonBackgroundColor: const Color(0xFFF56040),
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
            Icons.add_circle_rounded,
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
