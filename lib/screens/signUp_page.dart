import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/methods/methods_Util.dart';
import 'package:instagram_clone/responsives/mobile_screen.dart';
import 'package:instagram_clone/responsives/responsive_screen.dart';
import 'package:instagram_clone/responsives/web_screen.dart';
import 'package:instagram_clone/screens/login_page.dart';
import 'package:instagram_clone/screens/widgets/textField_input.dart';
import 'package:instagram_clone/utils/colors.dart';

import '../app_data/auth_methods.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  bool isLoading = false;

  void signUp() async {
    setState(() {
      isLoading = true;
    });
    String resp = await AuthenticationMethods().SignUp(
        email: _emailController.text,
        password: _passwordController.text,
        fullname: _fullNameController.text,
        username: _userNameController.text);
    print(resp);

    setState(() {
      isLoading = false;
    });

    if (resp != 'success') {
      // ignore: use_build_context_synchronously
      showSnackBar(context, resp);
    } else {
      
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const ResponsiveScreen(
              mobileScreen: MobileScreen(), webScreen: WebScreen())));
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _fullNameController.dispose();
    _userNameController.dispose();
    _mobileNumberController.dispose();
  }

  @override
  Widget build(BuildContext contexte) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 63, // Specify the desired height
                  child: SvgPicture.asset(
                    'assets/images/instagram_icon.svg',
                    color: primaryColor,
                    fit: BoxFit
                        .contain, // Ensure the SVG fits within the specified height
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                const Center(
                    child: Text(
                  "Sign up to see photos and videos from your friends.",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                )),
                const SizedBox(
                  height: 20,
                ),
                // Login with Facebook

                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        color: Colors.blue),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/images/facebook_icon.svg',
                            height: 33),
                        const SizedBox(width: 8),
                        const Text(
                          "Log in with Facebook",
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),
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
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                    textFieldController: _emailController,
                    inputBorder: InputBorder.none,
                    hintText: 'Mobile Number or Email',
                    textInputType: TextInputType.emailAddress),
                const SizedBox(
                  height: 18,
                ),
                TextFieldInput(
                    textFieldController: _fullNameController,
                    inputBorder: InputBorder.none,
                    hintText: 'Full Name',
                    textInputType: TextInputType.text),
                const SizedBox(
                  height: 18,
                ),
                TextFieldInput(
                    textFieldController: _userNameController,
                    inputBorder: InputBorder.none,
                    hintText: 'Username',
                    textInputType: TextInputType.text),
                const SizedBox(
                  height: 18,
                ),
                TextFieldInput(
                  textFieldController: _passwordController,
                  inputBorder: InputBorder.none,
                  hintText: 'Password',
                  textInputType: TextInputType.text,
                  isPwd: true,
                ),

                const SizedBox(height: 24),

                Center(
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to another page when "Learn More" is tapped
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => AnotherPage()),
                      // );
                    },
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text:
                                "People who use our service may have uploaded your contact information to Instagram. ",
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                          TextSpan(
                            text: "Learn More",
                            style: TextStyle(color: Colors.blue, fontSize: 12),
                          ),
                        ],
                      ),
                      maxLines: 2,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                Center(
                  child: GestureDetector(
                    onTap: () {
                      //Use push() when you want to add a new screen to the stack and allow the user to navigate back.
                      
                      // Navigate to another page when "Learn More" is tapped
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => AnotherPage()),
                      // );
                    },
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: "By signing up, you agree to our ",
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                          TextSpan(
                            text: "Terms , Privacy Policy and Cookies Policy .",
                            style: TextStyle(color: Colors.blue, fontSize: 12),
                          ),
                        ],
                      ),
                      maxLines: 2,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 28,
                ),

                // login button
                InkWell(
                  onTap: signUp,
                  child: Container(
                    // Sets the width of the container to take up all available horizontal space.
                    width: double.infinity,
                    // Centers the child widget (in this case, the Text widget) within the container.
                    alignment: Alignment.center,
                    // Adds vertical padding inside the container for the top and bottom.
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      color: Colors.blue,
                    ),
                    child: isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : const Text('Sign up',
                            style: TextStyle(
                                fontSize: 18, fontStyle: FontStyle.normal)),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Have an account?"),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const LoginPage())),
                      child: const Text(
                        "Log in",
                        style: TextStyle(fontSize: 17, color: Colors.blue),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
