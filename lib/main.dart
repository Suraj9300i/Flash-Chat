import 'package:flutter/material.dart';

import 'screens/WelcomeScreen.dart';
import 'screens/LoginScreen.dart';
import 'screens/ChatScreen.dart';
import 'screens/RegistrationScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
      routes: {
        WelcomeScreen.id : (context)=>WelcomeScreen(),
        LoginScreen.id : (context)=>LoginScreen(),
        RegistrationScreen.id : (context)=>RegistrationScreen(),
        ChatScreen.id : (context)=>ChatScreen()
      },
    );
  }
}
