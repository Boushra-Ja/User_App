import 'package:b/myDrawer/Drawer.dart';
import 'package:flutter/material.dart';

import '../UserInfo.dart';


class show extends StatelessWidget {
  var job , docid;
  userInfo user;
  show(job , userInfo user , docid) {
    this.job=job;
    this.user = user;
    this.docid = docid;
   // print(job["name_job"]);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl, child: Scaffold(
      appBar: AppBar(backgroundColor: Colors.pink.shade800,
        title: Text("Second Route"),
      ),
      drawer: mydrawer(user: user,docid: docid,),
      body: ListView(
        children: [
          Text(" NAME :" +"${job["name_job"]}"),
          ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.amberAccent),),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Go back!'),
          ),
        ],
      ),
    ));
  }
}
