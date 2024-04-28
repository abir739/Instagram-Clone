import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/providers/userProvider.dart';
import 'package:instagram_clone/responsives/mobile_screen.dart';
import 'package:instagram_clone/responsives/responsive_screen.dart';
import 'package:instagram_clone/responsives/web_screen.dart';
import 'package:instagram_clone/screens/login_page.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure binding is initialized
  if (kIsWeb) {
    await Firebase.initializeApp(
      // Initialize Firebase
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Instagram Clone',
        theme:
            ThemeData.dark().copyWith(scaffoldBackgroundColor: backgroundColor),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Text('Not connected to the stream or null');
              case ConnectionState.waiting:
                return const CircularProgressIndicator();
              case ConnectionState.active:
                if (snapshot.hasData) {
                  // If snapshot has data which means user is logged in,
                  // then we check the width of screen and accordingly display the screen layout.
                  return const ResponsiveScreen(
                    mobileScreen: MobileScreen(),
                    webScreen: WebScreen(),
                  );
                } else {
                  // If the snapshot has no data, return the LoginPage.
                  return const LoginPage();
                }
              case ConnectionState.done:
                return const Text('Stream has finished');
            }
            // If the connection state is not active or done, return LoginPage by default.
            // return const LoginPage();
          },
        ),
      ),
    );
  }
}
