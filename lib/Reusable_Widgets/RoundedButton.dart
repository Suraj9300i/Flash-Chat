import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Color color;
  final Function function;
  final String label;
  RoundedButton({@required this.label,@required this.color,@required this.function});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      width: double.infinity,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: color,
        child: Text(
          label,
          style: TextStyle(color: Colors.white,fontSize: 23.0),
        ),
        onPressed: function
      ),
    );
  }
}
