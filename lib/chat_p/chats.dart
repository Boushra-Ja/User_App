import 'package:b/Home/ThemeManager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'chat.dart';

class Chats extends StatefulWidget {
  var user_id;
  Chats({Key key, this.user_id}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return chats_s();
  }
}

class chats_s extends State<Chats> {
  @override
  Widget build(BuildContext context) {
    var company = FirebaseFirestore.instance
        .collection("users")
        .doc(widget.user_id)
        .collection("chat");

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeNotifier.mode ? Colors.pink.shade900 : Colors.black87,
          title: Text("الدردشات"),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: ThemeNotifier.mode ? Colors.pink.shade50.withOpacity(0.4) : Colors.grey.shade800,
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: StreamBuilder(
                  stream: company.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("Error");
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: SpinKitCircle(
                          color: Colors.pink.shade300,
                          size: 50,
                        ),
                      );
                    }
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, i) {
                            return InkWell(
                              child: Container(
                                // height: 110,
                                padding: EdgeInsets.only(bottom: 15),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  color: ThemeNotifier.mode ? Colors.white : Colors.grey.shade300.withOpacity(0.3),
                                  child: ListTile(
                                    contentPadding:
                                    EdgeInsets.fromLTRB(10, 15, 10, 15),
                                    title: Text(
                                      //"iiii",
                                      snapshot.data.docs[i]['name'],
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                      maxLines: 3,
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Row(
                                        children: [
                                          Text("يوجد رسائل"),
                                        ],
                                      ),
                                    ),
                                    leading: CircleAvatar(
                                      child: Icon(
                                        Icons.business,
                                        color: Colors.black,
                                      ),
                                      radius: 40,
                                      backgroundImage:
                                      snapshot.data.docs[i]['img'] != "not"
                                          ? NetworkImage(
                                          snapshot.data.docs[i]['img'])
                                          : null,
                                      backgroundColor:
                                      snapshot.data.docs[i]['img'] == "not"
                                          ? Colors.pink.shade100
                                          : null,
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () async {
                                // await check_follower();
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return Chat(
                                      snapshot.data.docs[i].id,
                                      widget.user_id,
                                      snapshot.data.docs[i]['name']);
                                }));
                              },
                            );
                          });
                    }
                    if (!snapshot.hasData) {
                      return Text(
                        "لم تراسلك أي شركة بعد",
                      );
                    }
                    return Text("loading");
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
