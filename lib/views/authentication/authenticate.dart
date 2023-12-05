import 'package:blog_it/views/authentication/signin.dart';
import 'package:blog_it/views/authentication/signup.dart';
import 'package:flutter/material.dart';

class Authentication extends StatefulWidget {
  const Authentication({super.key});

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(
        toggleView: toggleView,
      );
    } else {
      return SignUp(toggleView: toggleView);
    }
  }
}
