import 'package:flashchat/Reusable_Widgets/MessageBubble.dart';
import 'package:flashchat/screens/WelcomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  static String id = "ChatScreen";

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String _currentTypedMsg;
  Firestore _fireStore = Firestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  String _currentUser;
  TextEditingController _controller = TextEditingController();


  Widget _getMessagesFromFireStore(){
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore.collection("messages").snapshots(),
      builder: (context,snapshot){
        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        List<MessageBubble> listOfMessages = [];
        var _documentsOfFireStore = snapshot.data.documents.reversed;
        for(var item in _documentsOfFireStore){
          String sender = item.data['sender'];
          String message = item.data['data'];
          print(_currentUser);
          print(sender);
          print(_currentUser==sender);
          MessageBubble newItem = MessageBubble(
            emailOfSender: sender,
            messageOfSender: message,
            isMe: _currentUser==sender,
          );
          listOfMessages.add(newItem);
        }
        return ListView(
          reverse: true,
            children: listOfMessages,
          );
      },
    );
  }
  
  Future<void> storeDataToFireStore({String message,String user}) async{
    if(message!=null){
      try{
        _fireStore.collection("messages").add({
          'data':message,
          'sender':user,
        });
      }catch(e){
        print(e);
      }
    }
  }

  Future<void> signOutUser() async{
    await _auth.signOut();
    Navigator.pushNamed(context, WelcomeScreen.id);
  }

  Future<void> getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        setState(() {
          _currentUser = user.email;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              signOutUser();
            },
          )
        ],
        title: Text("chat"),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(child: Container(
              child: _getMessagesFromFireStore(),
            )),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                fillColor: Colors.grey,
                hintText: "Type your message here...",
                prefixIcon: IconButton(
                  icon: Icon(Icons.keyboard),
                  onPressed: (){},
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: (){
                    storeDataToFireStore(
                        message: _currentTypedMsg,
                        user: _currentUser
                    );
                    _controller.clear();
                  },
                ),
              ),
              onChanged: (value){
                _currentTypedMsg = value;
              },
            ),
          ],
        ),
      ),
    );
  }
}
