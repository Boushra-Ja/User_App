import 'dart:js';

import 'package:b/myDrawer/Drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'show.dart';

class All_Chances extends StatelessWidget {

  ///////////////////getdata 1
  List jobs = [];
  List ids = [];
  CollectionReference jobsref =
  FirebaseFirestore.instance.collection("company");
  getdata() async {
   // print("hi");
    QuerySnapshot respon = await jobsref.get();
    respon.docs.forEach((element) {
      //print(element.id);
      //gettdata(element.id);
          jobs.add(element.data());
          ids.add(element.id);
          // gettdata();
    });
   // print(jobs);
  }

  //////////////////////// getdata 2
  List job = [];

  /*gettdata(String idd) async {
    DocumentReference jobsre = FirebaseFirestore.instance.collection("informationjob").doc(idd);
    DocumentSnapshot respo = await jobsre.get();
      setState(() {
        job.add(respo.data());
      });
    print(job);
  }*/

  /*setdata(){
    CollectionReference jobsre = FirebaseFirestore.instance.collection("informationjob");
    jobsre.add({
      "ID" : "4444",
      "name":"rama",
    });

  }*/
  getId() {
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        /* if (doc['uid'] == FirebaseAuth.instance.currentUser.uid) {
          setState(() {
            userInfo = doc.data();
            docid = doc.id;
            print(userInfo);
          });
        }*/
      });
    });
  }

  @override
  void initState() {
    getId();
    getdata();
    //gettdata();
    //setdata();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
            length: 3,
            child: Scaffold(
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
              ),
            )
        ));
  }
}


