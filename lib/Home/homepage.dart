import 'package:b/Home/My_Chances.dart';
import 'package:b/Home/show.dart';
import 'package:b/Home/test.dart';

import 'package:b/myDrawer/Drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'all_chance.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var docid, userInfo;

  ///////////////////getdata 1    all_chances
  List All_jobs = [];
  List My_jobs=[];
  List ids = [];


  CollectionReference jobsref = FirebaseFirestore.instance.collection("company");
  get_All_data() async {
    // print("hi");
    QuerySnapshot respon = await jobsref.get();
    respon.docs.forEach((element) {
      setState(() {
        All_jobs.add(element.data());
        ids.add(element.id);
      });
    });
    print(All_jobs.length);
  }
  /////////////////////////////end all_chances

  get_My_data()async {
      await jobsref.where("degree",isEqualTo: "اعدادي").get().then((value) => {
        value.docs.forEach((element) {
          if (this.mounted) {
            setState(() {
              My_jobs.add(element.data());
            });
          }
        })
      });
      print(My_jobs.length);
    }


  getId(){
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc['uid'] == FirebaseAuth.instance.currentUser.uid) {
          setState(() {
            userInfo = doc.data();
            docid = doc.id;
           // print(docid);
           // print(userInfo) ;
          });
        }
      });
    });
  }

  @override
  void initState() {
    get_All_data();
    get_My_data();
        getId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(length:3,
            child: Scaffold(
              appBar: AppBar( backgroundColor: Colors.purple[700],

                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
                      //  topRight: Radius.circular(10),
                      //  topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(100),
                        bottomRight: Radius.circular(70),)),

                bottom: TabBar(indicatorColor:Colors.white  ,
                  tabs: [
                    Tab(child: Text("جميع الفرص"),),
                    Tab(child: Text("فرصي"),),
                    Tab(child: Text("الشركات"),)],
                ),
                title: TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 3.0,),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple[700], width: 3.0,),
                        borderRadius: BorderRadius.all(
                            Radius.circular(30.0)),
                      ),

                      hintText: " Search...",
                      border: InputBorder.none,
                      suffixIcon: IconButton(icon:Icon(Icons.search), onPressed: () {
                      },)
                  ),
                  style: TextStyle(color: Colors.white, fontSize: 14.0),
                ),
                iconTheme: IconThemeData(color: Colors.white),

                //backgroundColor: Colors.white,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.notifications_active,
                      color: Colors.amberAccent,
                    ),
                    onPressed: (){
                      //do some things to show notifications
                    },
                  ),
                ],
              ),

              drawer: mydrawer(userInfo: userInfo, docid: docid,),

              body:TabBarView(
                children: [
                  ///////////////////////////////////////////////
                  // All_Chances(),
                  all_chance(All_jobs),
                  ListView.builder(
                    itemCount: All_jobs.length,
                    /////// loop
                    itemBuilder: (context, i) {
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context) => show(All_jobs[i])),
                            );
                          },
                          child: Card(
                              color: Colors.purple[200],
                              margin: EdgeInsets.all(10),
                              child: Text(" NAME :" +
                                  " ${All_jobs[i]["name_job"]} \n" +
                                  " PRICE :" +
                                  " ${All_jobs[i]["price"]} \n" +
                                  " SKILL :" +
                                  " ${All_jobs[i]["skill"]} \n")));
                    },
                  ),

                  //////////////////////////////////////
                  //My_Chances(userInfo :userInfo),
                  ListView.builder(
                    itemCount: My_jobs.length,
                    /////// loop
                    itemBuilder: (context, i) {
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => show(My_jobs[i])),

                            );
                          },
                          child: Card(
                              color: Colors.purple[200],
                              margin: EdgeInsets.all(10),
                              child: Text(" NAME :" +
                                  " ${My_jobs[i]["name_job"]} \n" +
                                  " PRICE :" +
                                  " ${My_jobs[i]["price"]} \n" +
                                  " SKILL :" +
                                  " ${My_jobs[i]["skill"]} \n")));
                    },
                  ),

                  ////////////////////////////////////
                  //My_Chances(userInfo :userInfo),

                  //////////////////////////////////////////
                ],
              ),
            )
        ))
    ;
  }
}