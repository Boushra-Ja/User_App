import 'package:flutter/material.dart';
import 'Massege.dart';
import 'NewMassage.dart';


class Chat extends StatelessWidget {
  GlobalKey<FormState> k1 = new GlobalKey<FormState>();
var docid,com_id;
var name="اسم الشركة";
  Chat(com_id,docid,name){
    this.name=name;
    this.docid=docid;
    this.com_id=com_id;
    print(docid);
    print(com_id);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(80.0),
              child: AppBar(backgroundColor: Colors.pink.shade900,
                title: Center(
                  child: Text(name ,),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(60.0),
                  ),
                ),
              ),
            ),
            body: Column(
              children: [
                Expanded(child: Massege(docid,com_id)),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20, left: 5, right: 5),
                  child: NewMassage(docid,com_id),
                ),
              ],
            )));
  }
}

/*
Chat(
      widget.user_id , snapshot.data.docs[i].id);
 */