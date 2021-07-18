import 'package:b/Home/show.dart';
import 'package:b/Home/show.dart';
import 'package:b/UserInfo.dart';
import 'package:b/myDrawer/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'show.dart';

class roadmaps extends StatelessWidget {
  userInfo user;
  var docid;
  var url = 'https://flutter.io';

  List roadm = [];
  roadmaps(List all_map, userInfo user, docid) {
    roadm = all_map;
    this.user = user;
    this.docid = docid;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          //drawer: mydrawer(user: user, docid: docid,),
          body: ListView.builder(
            itemCount: roadm.length,
            /////// loop
            itemBuilder: (context, i) {
              return GestureDetector(
                onTap: () async =>
                    {await canLaunch(roadm[i]["web_name"]) ? await launch(roadm[i]["web_name"]) : throw 'noooo'},
                child: Container(
                  height: 400,
                  child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    children: [
                      GridTile(
                        child: Image.asset("images/google.jpg"),
                      ),
                    ],
                  ),
                ),
              );
            },
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}

/*
   *  GestureDetector(onTap:() async  =>{
                             await canLaunch(_u) ? await launch(_u) : throw 'noooo'
                      },*/

//  ramayag@gmail.com
