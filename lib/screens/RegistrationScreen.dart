import 'package:flashchat/Reusable_Widgets/RoundedButton.dart';
import 'package:flashchat/screens/ChatScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = "RegistrationScreen";
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool _modalProgressHud = false;
  String _emailIdHolder;
  String _passwordHolder;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> createUser({String email,String password}) async{
    try{
      final user = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      if(user != null){
        Navigator.pushNamed(context, ChatScreen.id);
      }
    }catch(e){
      print(e);
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
              SizedBox(
                height: 15.0,
              ),
              _buildTextField(
                label: "Enter your email",
                onChange: (value) {
                  _emailIdHolder = value;
                },
                privacy: false,
              ),
              SizedBox(height: 14.0,),
              _buildTextField(
                label: "Enter Password",
                privacy: true,
                onChange: (value) {
                  _passwordHolder = value;
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              RoundedButton(
                label: "Register",
                color: Colors.indigo,
                function: () async{
                  setState(() {
                    _modalProgressHud = true;
                  });
                  await createUser(
                    email: _emailIdHolder,
                    password: _passwordHolder
                  );
                  setState(() {
                    _modalProgressHud = false;
                  });
                }
              )
            ],
          ),
        ),
      ),
    );
  }

  TextField _buildTextField({String label, Function onChange, bool privacy}) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(color: Colors.indigo, width: 1.0)),
        hintText: label,
      ),
      textAlign: TextAlign.center,
      onChanged: onChange,
      keyboardType: TextInputType.emailAddress,
      obscureText: privacy,
    );
  }
}
