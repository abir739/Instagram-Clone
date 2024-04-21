import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/responsives/mobile_screen.dart';
import 'package:instagram_clone/responsives/responsive_screen.dart';
import 'package:instagram_clone/responsives/web_screen.dart';
import 'package:instagram_clone/screens/login_page.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure binding is initialized
  if (kIsWeb) {
    await Firebase.initializeApp( // Initialize Firebase
      options: const FirebaseOptions(
          apiKey: "AIzaSyCWrEeh17PhmJkf6dIbUuGobTccYrQ2rz4",
          authDomain: "instagram-clone-dbfce.firebaseapp.com",
          projectId: "instagram-clone-dbfce",
          storageBucket: "instagram-clone-dbfce.appspot.com",
          messagingSenderId: "795064199359",
          appId: "1:795064199359:web:f61c58d1502c5be0a07e0a"),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram Colone',
      theme:
          ThemeData.dark().copyWith(scaffoldBackgroundColor: backgroundColor),
      // home: const ResponsiveScreen(
      //   mobileScreen: MobileScreen(),
      //   webScreen: WebScreen(),)
      home: const LoginPage(),
    );
  }
}
