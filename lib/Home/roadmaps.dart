import 'package:b/Home/ThemeManager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';

class roadmaps extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            body: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: ThemeNotifier.mode ? Colors.pink.shade50.withOpacity(0.4) : Colors.grey.shade700,
                ),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance.collection('roadmaps').snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text("Error");
                        }
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: SpinKitCircle(
                            color: Colors.pink.shade300,
                            size: 50,
                          ),);
                        }
                        if (snapshot.hasData) {
                          return GridView.builder(
                            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                            itemCount: snapshot.data.docs.length,
                            /////// loop
                            itemBuilder: (context, i) {
                              return GestureDetector(
                                onTap: () async =>
                                {await canLaunch(snapshot.data.docs[i]["web_name"]) ? await launch(snapshot.data.docs[i]["web_name"]) : throw 'noooo'},
                                child: Container(
                                  height: 400,
                                  child:
                                  GridTile(
                                      footer: Padding(
                                        padding: const EdgeInsets.only(top : 15.0),
                                        child: new Text(snapshot.data.docs[i]['road_name'],textAlign: TextAlign.center,
                                            style: new TextStyle(fontWeight: FontWeight.bold,fontSize: 22)),
                                      ),
                                      child :Card(
                                          margin: EdgeInsets.all(25),
                                          shadowColor: Colors.transparent,
                                          color: Colors.transparent,
                                          child:Column(children: [
                                            CircleAvatar(
                                              radius: 40,
                                              backgroundImage:
                                              snapshot.data.docs[i]['ima'] != "not"
                                                  ? NetworkImage(
                                                  snapshot.data.docs[i]['ima']
                                              ) : null,
                                              backgroundColor:
                                              snapshot.data.docs[i]['ima'] == "not"
                                                  ? Colors.amber.shade100 : Colors.black12,
                                            ),
                                          ],)
                                      )
                                  ),

                                ),
                              );
                            },
                          );
                        }
                        return Text("loading");
                      }),
                )
              ],
            )));
  }
}





