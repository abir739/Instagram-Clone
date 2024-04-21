import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ResponsiveScreen extends StatelessWidget {
  final Widget mobileScreen;
  final Widget webScreen;
  

  const ResponsiveScreen({ Key? key, required this.mobileScreen, required this.webScreen,}) : super(key: key);

  @override 
  Widget build(BuildContext context) {
    // The LayoutBuilder widget in Flutter is a very handy tool for creating responsive and adaptive user interfaces. 
    // It builds a widget tree that can depend on the parent widget’s size.
    //This widget is particularly useful when you want your layout to adapt to different screen sizes
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth > 600) {
        return webScreen;
      }
      return mobileScreen;
    });
  }
}