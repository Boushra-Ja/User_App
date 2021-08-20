
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class NewMassage extends StatefulWidget {
  var docid,com_id;

  NewMassage(docid,com_id){
    this.docid=docid;
    this.com_id=com_id;
    print(docid);
  }

  @override
  _NewMassageState createState() => _NewMassageState();
}

class _NewMassageState extends State<NewMassage> {
  String enterdMassage = "";
  final control = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: control,
            decoration: InputDecoration(labelText: 'ارسال رسالة'),
            onChanged: (val) {
              setState(() {
                enterdMassage = val;
              });
            },
          )),
          IconButton(
              onPressed: enterdMassage.trim().isEmpty ? null : sendMassage,
              icon: Icon(Icons.send))
        ],
      ),
    );
  }

  sendMassage() {
    FocusScope.of(context).unfocus();

    FirebaseFirestore.instance
        .collection("users").doc(widget.docid).collection("chat").
        doc("5PUyoxQA5uF8r7qswDYY")
        .collection("chats")
        .add({"text": enterdMassage, "date": Timestamp.now(), "num": 2});

    control.clear();
  }
}
