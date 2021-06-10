import 'package:flutter/material.dart';

class buildText extends StatelessWidget {
  int flex_;
  String text;
  buildText(this.text, this.flex_);

  @override
  Widget build(BuildContext context) {
    return flex_ != 0
        ? Expanded(
        flex: flex_,
        child: Container(
            padding: EdgeInsets.only(top: 15, right: 15),
            child: Text(
              text,
              style: TextStyle(fontSize: 16, color: Colors.black),
            )))
        : Container(
        padding: EdgeInsets.only(top: 15, right: 15),
        child: Text(
          text,
          style: TextStyle(fontSize: 16, color: Colors.black),
        ));
  }
}
