import 'package:b/Home/ThemeManager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class NewMassage extends StatefulWidget {
  var docid,com_id;

  NewMassage(docid,com_id){
    this.docid=docid;
    this.com_id=com_id;
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
                decoration: InputDecoration(labelText: 'ارسال رسالة' , labelStyle: TextStyle(color: ThemeNotifier.mode ? Colors.black87 : Colors.white)),
                onChanged: (val) {
                  setState(() {
                    enterdMassage = val;
                  });
                },
              )),
          IconButton(
              onPressed: enterdMassage.trim().isEmpty ? null : sendMassage,
              icon: Icon(Icons.send , color: ThemeNotifier.mode ? Colors.black87 : Colors.white))
        ],
      ),
    );
  }

  sendMassage() async{
    FocusScope.of(context).unfocus();

    await FirebaseFirestore.instance.collection("users").doc(widget.docid).collection("chat").doc(widget.com_id).collection('chats')
        .add({"text": enterdMassage, "date": Timestamp.now(), "num": 2});

    control.clear();
  }
}