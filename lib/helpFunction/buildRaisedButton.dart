import 'package:flutter/material.dart';

class buildRaisedButton extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Center(
        child: Container(
          width: 150,
          child: RaisedButton(
              onPressed: () async {
                //     await addData();
              },
              elevation: 10,
              child: Text(
                "حفظ",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              color: Colors.deepPurple.shade400.withOpacity(0.8)),
        ),
      ),
    );
  }

}