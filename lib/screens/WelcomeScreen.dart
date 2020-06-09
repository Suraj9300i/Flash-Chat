import 'package:flashchat/Reusable_Widgets/RoundedButton.dart';
import 'package:flashchat/screens/LoginScreen.dart';
import 'package:flashchat/screens/RegistrationScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = "WelcomeScreen";

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: "logo",
                  child: Container(
                    height: animation.value * 60,
                    child: Image.asset(
                      "assets/images/flash_chat_logo.png",
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                SizedBox(
                  child: TypewriterAnimatedTextKit(
                    speed: Duration(seconds: 1),
                    text: ["Flash Chat"],
                    textStyle: TextStyle(
                      fontSize: 50.0,
                      fontFamily: "Bitter",
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.start,
                    alignment:AlignmentDirectional.topStart, // or Alignment.topLeft
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            RoundedButton(
                label: "Log In",
                color: Colors.blueAccent,
                function: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                }),
            SizedBox(
              height: 20.0,
            ),
            RoundedButton(
              label: "Register",
              color: Colors.indigo,
              function: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            )
          ],
        ),
      ),
    );
  }
}
