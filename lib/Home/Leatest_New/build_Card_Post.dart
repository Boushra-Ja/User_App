import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:convert';

class build_post extends StatefulWidget {
  //var post, company_name, num_follwers, user_Id;
  var post_Info , user_Id;
  build_post({this.post_Info , this.user_Id});

  @override
  State<StatefulWidget> createState() {
    return build_postState();
  }
}

class build_postState extends State<build_post> {

  sendNotify(bool reaction)async {

    var serverToken = "AAAAUnOn5ZE:APA91bGSkIL6DLpOfbulM_K3Yp5W1mlcp8F0IWu2mcKWloc4eQcF8C230XaHhXBfBYphuyp2P92dc_Js19rBEuU6UqPBGYOSjJfXsBJVmIu9TsLe44jaSOLDAovPTspwePb1gw7-1GNZ";
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': (reaction == true  ? "أعجب المستخدم " : "تفاعل المستخدم ") + "بشرى " + "مع البوست الخاص بك",
            'title': 'تفاعل مع البوست'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          'to': await FirebaseMessaging.instance.getToken(),
        },
      ),
    );


  }
  getMessage()async{
    FirebaseMessaging.onMessage.listen((event) {
      print("++++++++++++++++++++++++++++++");
      print(event.notification.title);
      print(event.notification.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    bool check_sav = true;
    CollectionReference saved_Item = FirebaseFirestore.instance
        .collection("users")
        .doc(widget.user_Id)
        .collection("posts_saved");

    return Container(
        color: Colors.pink.shade50,
        width: MediaQuery.of(context).size.width,
        child: Card(
          color: Colors.white,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.pink.shade900,
                      child: Icon(
                        Icons.business,
                        size: 35,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 13),
                      child: Container(
                        width:
                            2 * ((MediaQuery.of(context).size.width - 40) / 3),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              "${widget.post_Info.company_name}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                              maxLines: 2,
                            ),
                            Text(
                              "${widget.post_Info.num_follwers}" + " متابع",
                              style: TextStyle(color: Colors.grey.shade700),
                            ),
                            Row(
                              children: [
                                Text("${widget.post_Info.companies_post.date}",
                                    style:
                                        TextStyle(color: Colors.grey.shade700)),
                                Icon(Icons.public,
                                    size: 17, color: Colors.grey.shade700)
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: AutoSizeText("##"+
                    "${widget.post_Info.companies_post.title}",
                    style: TextStyle(fontSize: 16),
                    maxLines: 10,
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: AutoSizeText(
                    "${widget.post_Info.companies_post.my_post}",
                    style: TextStyle(fontSize: 16),
                    maxLines: 10,
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Divider(
                  color: Colors.grey.shade700,
                ),
                SizedBox(
                  height: 2,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: ()async{
                            if(widget.post_Info.check_like == false){
                              setState(() {
                                widget.post_Info.check_like = true;
                                widget.post_Info.check_dislike = false;

                              });
                              await sendNotify(true);
                              await getMessage();
                            }else{
                              setState(() {
                                widget.post_Info.check_like = false;
                              });
                            }
                          },
                          child: Column(
                            children: [Icon(Icons.thumb_up_alt , color: widget.post_Info.check_like == false ? Colors.grey.shade700 : Colors.blue), Text("أعجبني")],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 60,
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: ()async{
                            if(widget.post_Info.check_dislike == false){
                              setState(() {
                                widget.post_Info.check_dislike = true;
                                widget.post_Info.check_like = false;

                              });
                              await sendNotify(false);
                              await getMessage();

                            }else{
                              setState(() {
                                widget.post_Info.check_dislike = false;
                              });
                            }

                          },
                          child: Column(
                            children: [
                              Icon(Icons.thumb_down_alt , color: widget.post_Info.check_dislike == false ? Colors.grey.shade700 : Colors.red,),
                              Text("لم يعجبني")
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 60,
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () async {
                            if (widget.post_Info.check_save == false) {
                              setState(() {
                                widget.post_Info.check_save = true;
                              });
                              await saved_Item.add({
                                'post_Id': widget.post_Info.companies_post.post_Id,
                                'company_Id' : widget.post_Info.company_Id
                              }).then((value) {
                                print("success");
                              }).catchError((onError) {
                                print(onError);
                              });
                            } else {
                              print("_________________________________________");
                              setState(() {
                                widget.post_Info.check_save = false;
                              });
                              await saved_Item.get().then((value) async {
                                if (value.docs.isNotEmpty) {
                                  for (int j = 0; j < value.docs.length; j++) {
                                    if (value.docs[j].data()['post_Id'] ==
                                        widget.post_Info.companies_post.post_Id) {
                                      saved_Item
                                          .where("post_Id",
                                              isEqualTo: widget.post_Info.companies_post.post_Id)
                                          .get()
                                          .then((value) {
                                        value.docs.forEach((element) {
                                          saved_Item
                                              .doc(element.id)
                                              .delete()
                                              .then((value) {
                                            print("Success!");
                                          });
                                        });
                                      });
                                    }
                                  }
                                }
                              });
                            }
                          },
                          child: Column(
                            children: [
                              Icon(Icons.save , color: widget.post_Info.check_save == false ? Colors.grey.shade700:Colors.yellow.shade500,),
                              Text(widget.post_Info.check_save == false
                                  ? "حفظ"
                                  : "الغاء الحفظ")
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 6,
                )
              ],
            ),
          ),
        ));
  }
}

/*
 "#شاغر وظيفي " + '\n'+ "شركة ملابس تعلن غن توفر فرصة جديدة" + "\n\n" +"#في الرياض" +'\n\n'+ "الشروط : "
                        + "\n" + "-خبرة في نفس المجال "
 */
