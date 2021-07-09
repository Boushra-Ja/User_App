import 'package:b/Home/show.dart';
import 'package:b/UserInfo.dart';
import 'package:b/myDrawer/Drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'show.dart';



class my_chance extends StatelessWidget {
  List m_jobs=[];
  userInfo user ;
  var docid;

  my_chance(List my_jobs , userInfo user , docid){
    m_jobs=my_jobs;
    this.user = user;
    this.docid = docid;
    //print(jobs);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: ListView.builder(
            itemCount: m_jobs.length,
            /////// loop
            itemBuilder: (context, i) {
              return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => show(m_jobs[i] , user , docid)),
                    );
                  },

                  child: Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [Colors.black26, Colors.pink.shade800])),
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
                          child: Column(children: [
                            Row(children: [
                              Icon(Icons.account_circle,size: 30,),
                              Text(" العنوان ",),
                            ]),

                            Card(
                                color: Colors.white70,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),

                                child: Column(children: [
                                  Row(children: [Padding(
                                    padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
                                    child:
                                    Text(" الأسم :" +
                                        " ${m_jobs[i]["name_job"]} \n" +
                                        " الراتب :" +
                                        " ${m_jobs[i]["price"]} \n" +
                                        " المهارات :" +
                                        " ${m_jobs[i]["skill"]} \n"),
                                  )]),
                                ])),
                          ]))));
            },
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}
