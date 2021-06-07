import 'package:b/Home/show.dart';
import 'package:b/Home/test.dart';

import 'package:b/myDrawer/Drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'my_chance.dart';
import 'all_chance.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var docid, userInfo;

  List All_jobs = [];
  List My_jobs=[];

  CollectionReference jobsref = FirebaseFirestore.instance.collection("company");

  /////////////////////////////get all data
  get_All_data() async {
    QuerySnapshot respon = await jobsref.get();
    respon.docs.forEach((element) {
      if (this.mounted) {
        setState(() {
          All_jobs.add(element.data());
        });}});
    print(All_jobs.length);
  }


  /////////////////////////////get my chance
  get_My_data()async {
      await jobsref.where("degree",isEqualTo: "اعدادي").get().then((value) => {
        value.docs.forEach((element) {
          if (this.mounted) {
            setState(() {
              My_jobs.add(element.data());
            });}})});
      print(My_jobs.length);
    }


  getId(){
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc['uid'] == FirebaseAuth.instance.currentUser.uid) {
          if (this.mounted) {
          setState(() {
            userInfo = doc.data();
            docid = doc.id;
          });}}});});
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
    return Directionality(
        textDirection: TextDirection.rtl,
        child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(length:3,
        child:
        Directionality(
        textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar( backgroundColor:  Colors.pink.shade800,

                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
                      //  topRight: Radius.circular(10),
                      //  topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(100),
                        bottomRight: Radius.circular(70),)),

                bottom: TabBar(indicatorColor:Colors.white ,
                  indicator: UnderlineTabIndicator(
                    //  borderSide: BorderSide(width: 10.0),
                      insets: EdgeInsets.symmetric(horizontal:60.0,)
                  ),

                  tabs: [
                    Tab(child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("جميع الفرص"),),),
                    Tab(child: Text("فرصي"),),

                    Tab(child: Align(
                      alignment: Alignment.centerRight,child: Text("الشركات"),),)],
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
                        borderSide: BorderSide(color: Colors.pink.shade800, width: 3.0,),
                        borderRadius: BorderRadius.all(
                            Radius.circular(30.0)),
                      ),

                      hintText: "البحث ",
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
                  all_chance(All_jobs),
                  my_chance(My_jobs),
                  my_chance(My_jobs),
                ],
              ),
            )
        ))));
  }
}