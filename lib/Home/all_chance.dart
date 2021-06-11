import 'package:b/Home/show.dart';
import 'package:b/myDrawer/Drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'show.dart';



class all_chance extends StatelessWidget {
  List jobs=[];
  all_chance(List all_jobs){
    jobs=all_jobs;

  }

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      body: ListView.builder(
        itemCount: jobs.length,
        /////// loop
        itemBuilder: (context, i) {
          return GestureDetector(
              onTap: () {
                Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context) => show(jobs[i])),
                );
              },
              child: Card(
                  color: Colors.purple[200],
                  margin: EdgeInsets.all(10),
                  child: Text(" NAME :" +
                      " ${jobs[i]["name_job"]} \n" +
                      " PRICE :" +
                      " ${jobs[i]["price"]} \n" +
                      " SKILL :" +
                      " ${jobs[i]["skill"]} \n")));
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );

    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: ListView.builder(
            itemCount: jobs.length,
            /////// loop
            itemBuilder: (context, i) {
              return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => show(jobs[i])),
                    );
                  },

                  child: Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
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
                                        " ${jobs[i]["name_job"]} \n" +
                                        " الراتب :" +
                                        " ${jobs[i]["price"]} \n" +
                                        " المهارات :" +
                                        " ${jobs[i]["skill"]} \n"),
                                  )]),
                                ])),
                          ]))));
            },
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}
