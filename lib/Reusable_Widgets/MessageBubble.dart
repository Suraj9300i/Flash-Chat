import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String emailOfSender;
  final String messageOfSender;
  final bool isMe;

  MessageBubble(
      {@required this.emailOfSender,
      @required this.messageOfSender,
      @required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          emailOfSender,
          style: TextStyle(fontSize: 12.0, color: Colors.grey),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10.0),
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
            color: isMe ? Colors.indigo : Colors.blueAccent,
          ),
          child: Text(
            messageOfSender,
            style: TextStyle(fontSize: 20.0, color: Colors.white
            ),
          ),
        )
      ],
    );
  }
}
