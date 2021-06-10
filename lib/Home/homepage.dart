import 'package:b/myDrawer/Drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'All_Chances.dart';
import 'Company_Pages/Company_Page.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var docid, userInfo;

  ///////////////////getdata 1
  List jobs = [];
  List ids=[];
  CollectionReference jobsref = FirebaseFirestore.instance.collection("companies");
  getdata() async {
    print("hi");
    QuerySnapshot respon = await jobsref.get();
    respon.docs.forEach((element) {
      print(element.id);
      //gettdata(element.id);
      setState(() {
        jobs.add(element.data());
        ids.add(element.id);


        // gettdata();
      });
    });
    print(jobs);
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
            print(userInfo) ;
          });
        }
      });
    });
  }

  @override
  void initState() {

    getId();
    getdata();
    //gettdata();
    //setdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(length:3,
            child: Directionality(textDirection: TextDirection.rtl,child: Scaffold(
              appBar: AppBar( backgroundColor: Colors.pink.shade900,
                  bottom: TabBar(
                    tabs: [
                      Tab(icon : Icon(Icons.home)),
                      Tab(icon : Icon(Icons.ac_unit_outlined)),
                      Tab(icon : Icon(Icons.access_time_sharp)),

                    ],

                  ),
                 // title:Center(
                  //  child: Text(" BR jobs", style: TextStyle(fontSize: 30)),)

              ),

              drawer: mydrawer(userInfo: userInfo, docid: docid,),

              body:TabBarView(
                children: [
                  All_Chances(),
                  companyPage(),
                  Icon(Icons.directions_bike),
                ],
              ),
              /*ListView.builder(
          itemCount: jobs.length,
          /////// loop
          itemBuilder: (context, i) {
            return GestureDetector(
                onTap: () {
                  print ("hii "+ ids[i]);

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SecondRoute(jobs[i])),
                  );

                },
                child: Card(
                    color: Colors.purple[200],
                    margin: EdgeInsets.all(10),
                    child: Text(
                        " NAME :"+" ${jobs[i]["name_job"]} \n"
                            +  " PRICE :"+" ${jobs[i]["price"]} \n"
                            +  " SKILL :"+" ${jobs[i]["skill"]} \n")
                )
            );
            /*Card(
                color: Colors.purple,
                margin: EdgeInsets.all(10),
                child: Text(" المرتب :"+" ${jobs[i]["salary"]} ")
            );*/
            /*Container(
                color: Colors.purple,
                margin: EdgeInsets.all(10),
                child: Text(" المرتب :"+" ${jobs[i]["salary"]} "));*/
          },
        ),*/

/*
body: PageView(
    children: [
        ListView.builder(
          itemCount: jobs.length,
          /////// loop
          itemBuilder: (context, i) {
            return GestureDetector(
                onTap: () {
                  print ("hii "+ ids[i]);

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SecondRoute(jobs[i])),
                  );

                },
                child: Card(
                    color: Colors.purple[200],
                    margin: EdgeInsets.all(10),
                    child: Text(
                        " NAME :"+" ${jobs[i]["name_job"]} \n"
                            +  " PRICE :"+" ${jobs[i]["price"]} \n"
                            +  " SKILL :"+" ${jobs[i]["skill"]} \n")
                )
            );
            /*Card(
                color: Colors.purple,
                margin: EdgeInsets.all(10),
                child: Text(" المرتب :"+" ${jobs[i]["salary"]} ")
            );*/
            /*Container(
                color: Colors.purple,
                margin: EdgeInsets.all(10),
                child: Text(" المرتب :"+" ${jobs[i]["salary"]} "));*/
          },
        ),
    SecondRoute(jobs[2])],)
 */

              /////////////2
              /*Container(color: Colors.purple,child: ListView.builder(
          itemCount: jobs.length,
          /////// loop
          itemBuilder: (context, i) {
            return Text(" المرتب :"+" ${jobs[i]["salary"]} ");
          },
        ),)*/
              /////////////////1
              /*ListView.builder(
          itemCount: jobs.length,
          /////// loop
          itemBuilder: (context, i) {
            return Text(" المرتب :"+" ${jobs[i]["salary"]} ");
          },
        )*/
            ),)
        )) ;
  }
}


class SecondRoute extends StatelessWidget {

  SecondRoute(job){
    print(job["name_job"]);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body:
      ListView(
        children: [Text(
            " NAME :")
          , ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Go back!'),
          ),
        ],),
    );
  }

}