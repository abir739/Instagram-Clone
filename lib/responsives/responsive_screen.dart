import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:instagram_clone/providers/userProvider.dart';
import 'package:provider/provider.dart';

class ResponsiveScreen extends StatefulWidget {
  final Widget mobileScreen;
  final Widget webScreen;

  const ResponsiveScreen({
    Key? key,
    required this.mobileScreen,
    required this.webScreen,
  }) : super(key: key);

  @override
  State<ResponsiveScreen> createState() => _ResponsiveScreenState();
}

class _ResponsiveScreenState extends State<ResponsiveScreen> {
  @override
  void initState() {
    super.initState();

    userData();
  }

  userData() async {
    UserProvider userprovider = Provider.of(context, listen: false);
    await userprovider.refreshUserData();
  }

  @override
  Widget build(BuildContext context) {
    // The LayoutBuilder widget in Flutter is a very handy tool for creating responsive and adaptive user interfaces.
    // It builds a widget tree that can depend on the parent widget’s size.
    //This widget is particularly useful when you want your layout to adapt to different screen sizes
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth > 600) {
        return widget.webScreen;
      }
      return widget.mobileScreen;
    });
  }
}
