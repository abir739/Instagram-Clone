import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/data/auth_methods.dart';
import 'package:instagram_clone/methods/methods_Util.dart';
import 'package:instagram_clone/responsives/mobile_screen.dart';
import 'package:instagram_clone/responsives/responsive_screen.dart';
import 'package:instagram_clone/responsives/web_screen.dart';
import 'package:instagram_clone/screens/signUp_page.dart';
import 'package:instagram_clone/screens/widgets/textField_input.dart';
import 'package:instagram_clone/utils/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoaing = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void signIn() async {
    setState(() {
      isLoaing = true;
    });
    String resp = await AuthenticationMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);

    setState(() {
      isLoaing = false;
    });

    if (resp == 'success') {
      // Use pushReplacement() when you want to replace the current screen entirely and prevent the user from going back to it.
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => const ResponsiveScreen(
                  mobileScreen: MobileScreen(),
                  webScreen: WebScreen(),
                )),
      );
    } else {
      showSnackBar(context, resp);
    }
  }

  @override
  Widget build(BuildContext contexte) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(flex: 2, child: Container()),
              SvgPicture.asset(
                'assets/images/instagram_icon.svg',
                color: primaryColor,
                height: 63,
              ),
              const SizedBox(
                height: 60,
              ),
              TextFieldInput(
                  textFieldController: _emailController,
                  inputBorder: InputBorder.none,
                  hintText: 'Enter your email',
                  textInputType: TextInputType.emailAddress),
              const SizedBox(
                height: 18,
              ),
              TextFieldInput(
                textFieldController: _passwordController,
                inputBorder: InputBorder.none,
                hintText: 'Enter your password',
                textInputType: TextInputType.text,
                isPwd: true,
              ),
              const SizedBox(
                height: 28,
              ),

              // login button
              InkWell(
                onTap: signIn,
                child: Container(
                  // Sets the width of the container to take up all available horizontal space.
                  width: double.infinity,
                  // Centers the child widget (in this case, the Text widget) within the container.
                  alignment: Alignment.center,
                  // Adds vertical padding inside the container for the top and bottom.
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    color: Colors.blue,
                  ),
                  child: isLoaing
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : const Text('Log in',
                          style: TextStyle(
                              fontSize: 18, fontStyle: FontStyle.normal)),
                ),
              ),

              const SizedBox(height: 28),
              // OR Divider
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Divider(color: Colors.white)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "OR",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.white)),
                ],
              ),
              Flexible(flex: 2, child: Container()),
              // Login with Facebook
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/images/facebook_icon.svg',
                      height: 33),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text("Log in with Facebook"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Forgot Password
              GestureDetector(
                onTap: () {},
                child: const Text(
                  "Forgot password?",
                  style: TextStyle(color: Colors.blue, fontSize: 14),
                ),
              ),
              Flexible(flex: 2, child: Container()),
              // Sign Up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SignUpPage())),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 18, color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
