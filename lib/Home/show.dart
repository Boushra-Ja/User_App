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
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.pink.shade800,
                title: Text("معلومات عن الفرصة"),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.arrow_forward,
                      // color: Colors.amberAccent,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ]),
            drawer: mydrawer(user: user, docid: docid,),
            body: Container(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
                    child: Column(children: [
                      Row(children: [
                        Icon(
                          Icons.account_circle,
                          size: 30,
                        ),
                        Text(
                          " العنوان ",
                        ),
                      ]),

                      Card(
                          color: Colors.white70,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(children: [
                            Row(children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
                                child: Text(" الأسم :" +
                                    " ${job["name_job"]} \n" +
                                    " الراتب :" +
                                    " ${job["price"]} \n" +
                                    " المهارات :" +
                                    " ${job["skill"]} \n"),
                              )
                            ]),
                          ])),
                      ///////////////////////////
                      Card(
                          color: Colors.white70,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(children: [

                            Text("المهارات المطلوبة ",style: TextStyle(fontSize: 20), ),
                            new Divider(
                              color: Colors.black,
                            ),
                            Row(children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
                                child: Text(" -------------------------------------------------------------------------------------------------"),
                              )
                            ]),
                          ])),
                      ////////////////////////////////////////
                Card(
                    color: Colors.white70,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(children: [

                      Text("عن الفرصة  ",style: TextStyle(fontSize: 20), ),
                      new Divider(
                        color: Colors.black,
                      ),
                      Row(children: [
                        Flexible(child:Text(" *------------------------------------------------------------------------------------------------------------------------------------------------------------------------------",overflow: TextOverflow.fade,),
                      )

                        /*Container(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 5),height: 250,
                          child: Expanded(child:
                          Column(children:[
                            Text(" *------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"),
                    ],)
                          )
                        )*/
                      ]),
                    ])),
                      //////////////////////////////
                    ])))));
  }
}
