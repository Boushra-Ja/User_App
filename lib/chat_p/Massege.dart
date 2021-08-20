
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';




// ignore: must_be_immutable
class Massege extends StatelessWidget {
  var docid,com_id;

  Massege(docid,com_id){
    this.docid=docid;
    this.com_id=com_id;
    print(docid);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("users").doc(docid).collection("chat").
      doc("5PUyoxQA5uF8r7qswDYY")
          .collection("chats")
          .orderBy("date", descending: true)
          .snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(
          child: SpinKitCircle(
            color: Colors.pink.shade300,
            size: 50,
          ),
        );
        final docs = snapshot.data.docs;
        return ListView.builder(
            reverse: true,
            itemCount: docs.length,
            itemBuilder: (ctx, index) {
              return Row(
                  mainAxisAlignment: docs[index]["num"] == 1
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.end,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            color: docs[index]["num"] == 2
                                ? Colors.pink.shade50
                                : Colors.pink.shade100,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(14),
                              topRight: Radius.circular(14),
                              bottomLeft: docs[index]["num"] == 2
                                  ? Radius.circular(14)
                                  : Radius.circular(0),
                              bottomRight: docs[index]["num"] == 2
                                  ? Radius.circular(0)
                                  : Radius.circular(14),
                            )),
                        width: 140,
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                        margin:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        child: Column(
                          crossAxisAlignment: docs[index]["num"] == 2
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Text(
                              docs[index]["text"],
                              style: TextStyle(fontSize: 20),
                              textAlign: docs[index]["num"] == 2
                                  ? TextAlign.end
                                  : TextAlign.start,
                            ),
                          ],
                        ))
                  ]);
            });
      },
    );
  }

}
