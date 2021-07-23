import 'package:b/Home/show.dart';
import 'package:b/Home/show.dart';
import 'package:b/UserInfo.dart';
import 'package:b/myDrawer/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'show.dart';




class roadmaps extends StatelessWidget {
  List roadm = [];
  roadmaps(List all_map,) {
    roadm = all_map;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: GridView.builder(
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: roadm.length,
            /////// loop
            itemBuilder: (context, i) {
              return GestureDetector(
                onTap: () async =>
                    {await canLaunch(roadm[i]["web_name"]) ? await launch(roadm[i]["web_name"]) : throw 'noooo'},
                child: Container(
                  height: 400,
                  child:
                      GridTile(
                        footer: new Text(roadm[i]['road_name'],textAlign: TextAlign.center,
                            style: new TextStyle(fontWeight: FontWeight.bold,fontSize: 22)),
                       child :Card(
                           margin: EdgeInsets.all(25),
                         shadowColor: Colors.transparent,
                         color: Colors.transparent,
                         child:Column(children: [
                           CircleAvatar(
                             radius: 45,
                             backgroundImage:
                             roadm[i]['ima'] != "not"
                                 ? NetworkImage(
                                 roadm[i]['ima']
                             ) : null,
                             backgroundColor:
                             roadm[i]['ima'] == "not"
                                 ? Colors.amber.shade100 : Colors.black12,
                           ),
                         ],)
                       )
                      ),

                ),
              );
            },
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}




//  ramayag@gmail.com

//   flutter run -d chrome --web-renderer html

