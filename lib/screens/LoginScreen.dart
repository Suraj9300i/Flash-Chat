import 'package:flashchat/Reusable_Widgets/RoundedButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'ChatScreen.dart';

class LoginScreen extends StatefulWidget {
  static String id = "LoginScreen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _modalProgressHud = false;
  String _emailIdHolder;
  String _passwordHolder;


  Future<void> signInUser({String emailId,String pass}) async{
    if(_emailIdHolder!=null && _passwordHolder!=null) {
      try {
        final user = await _auth.signInWithEmailAndPassword(
            email: _emailIdHolder, password: _passwordHolder);
        if (user != null) {
          Navigator.pushNamed(context, ChatScreen.id);
        }
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: _modalProgressHud,
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: "logo",
                child: Container(
                  height: 200.0,
                  child: Image.asset("assets/images/flash_chat_logo.png"),
                ),
              ),
              SizedBox(height: 20.0,),
              _buildTextField(
                label: "Enter your email",
                privacy: false,
                onChangedValue: (value){
                  _emailIdHolder = value;
                }
              ),
              SizedBox(
                height: 14.0,
              ),
              _buildTextField(
                label: "Enter Password",
                privacy: true,
                onChangedValue: (value){
                  _passwordHolder = value;
                }
              ),
              SizedBox(
                height: 20.0,
              ),
              RoundedButton(
                label: "LogIn",
                color: Colors.blueAccent,
                function: () async{
                  setState((){
                    _modalProgressHud = true;
                  });
                  await signInUser(emailId: _emailIdHolder,pass: _passwordHolder);
                  setState(() {
                    _modalProgressHud = false;
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  TextField _buildTextField({@required String label,@required Function onChangedValue,@required bool privacy}){
    return TextField(
        decoration: InputDecoration(
            hintText: label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide(color: Colors.blueAccent,width: 1.0)
            ),
        ),
        keyboardType: TextInputType.emailAddress,
        textAlign: TextAlign.center,
        obscureText: privacy,
        onChanged: onChangedValue
    );
  }
}
