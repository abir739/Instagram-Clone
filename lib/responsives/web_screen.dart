import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/screens/settings_Page.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/variablesUtil.dart';

class WebScreen extends StatefulWidget {
  const WebScreen({Key? key}) : super(key: key);

  @override
  State<WebScreen> createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  int _page = 0;
  late PageController pageController; // for tabs animation

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        centerTitle: false,
        title: SvgPicture.asset(
          'assets/instagram_icon.svg',
          color: primaryColor,
          height: 32,
        ),
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
        children: pageItems,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        onTap: navigationTapped,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(
              Icons.home,
              color: _page == 0 ? const Color(0xFFF56040) : secondaryColor,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(
              Icons.search,
              color: _page == 1 ? const Color(0xFFF56040) : secondaryColor,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(
              Icons.add_a_photo,
              color: _page == 2 ? const Color(0xFFF56040) : secondaryColor,
            ),
            label: 'Add Photo',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(
              Icons.favorite,
              color: _page == 3 ? const Color(0xFFF56040) : secondaryColor,
            ),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(
              Icons.person,
              color: _page == 4 ? const Color(0xFFF56040) : secondaryColor,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
