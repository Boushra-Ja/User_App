import 'package:b/Home/ThemeManager.dart';
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
            appBar: AppBar(backgroundColor:ThemeNotifier.mode ?  Colors.pink.shade900 : Colors.black87,
              title:  Text("شركة " + name),
              centerTitle: true,
            ),
            body: Container(
              color: ThemeNotifier.mode ? Colors.grey.shade100 : Colors.grey.shade700,
              child: Column(
                children: [
                  Expanded(child: Massege(docid,com_id)),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20, left: 5, right: 5),
                    child: NewMassage(docid,com_id),
                  ),
                ],
              ),
            )));
  }
}