import 'package:b/UserInfo.dart';
import 'package:flutter/material.dart';
import 'package:b/myDrawer/Drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'show.dart';


class My_Chances extends StatefulWidget {
  var userInfo;
  My_Chances({Key key, this.title,this.userInfo}) : super(key: key);
  final String title;

  @override
  m_Chances createState() => m_Chances();
}

class m_Chances extends State<My_Chances> {
  List obs = [];
  List ds = [];
  //////////////تعديل الاسم
  //////////////edit
  String aa=userInfo().previous_job;
  CollectionReference jobsref = FirebaseFirestore.instance.collection("company");
  getdata() async {
    await jobsref.where("degree",isEqualTo: "اعدادي").get().then((value) => {
      value.docs.forEach((element) {
    if (this.mounted) {
      setState(() {
        obs.add(element.data());
      });
    }
      })
    });
    print(obs.length);
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
            length: 3,
            child: Scaffold(
              body: ListView.builder(
                itemCount: obs.length,
                /////// loop
                itemBuilder: (context, i) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => show(obs[i])),

                        );
                      },
                      child: Card(
                          color: Colors.purple[200],
                          margin: EdgeInsets.all(10),
                          child: Text(" NAME :" +
                              " ${obs[i]["name_job"]} \n" +
                              " PRICE :" +
                              " ${obs[i]["price"]} \n" +
                              " SKILL :" +
                              " ${obs[i]["skill"]} \n")));
                },
              ),
            )));
  }
}
