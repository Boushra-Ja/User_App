import 'package:b/Home/ThemeManager.dart';
import 'package:flutter/material.dart';
import 'Massege.dart';
import 'NewMassage.dart';


class Chat extends StatelessWidget {
  GlobalKey<FormState> k1 = new GlobalKey<FormState>();
  var docid , com_id , name , img;
  Chat(com_id , docid  , name , img){
    this.name=name;
    this.docid=docid;
    this.com_id=com_id;
    this.img = img;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(backgroundColor:ThemeNotifier.mode ?  Colors.pink.shade900 : Colors.black87,toolbarHeight: 80,
              leadingWidth: 2,
              title:  Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    child: img == "not" ? Icon(
                      Icons.business,
                      color: Colors.black,
                    ) : null,

                    backgroundImage:
                    img != "not"
                        ? NetworkImage(
                        img)
                        : null,
                    backgroundColor:
                   img == "not"
                        ? Colors.pink.shade100
                        : null,

                  ),
                  SizedBox(width: 10,),
                  Text("شركة " + name),
                ],
              ),
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