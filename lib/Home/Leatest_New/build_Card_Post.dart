import 'package:auto_size_text/auto_size_text.dart';
import 'package:b/Home/ThemeManager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:convert';

class build_post extends StatefulWidget {
  var post_Info , user_Id , user_name;
  build_post({this.post_Info , this.user_Id , this.user_name});

  @override
  State<StatefulWidget> createState() {
    return build_postState();
  }
}

class build_postState extends State<build_post> {

  var title , body , date;

  sendNotify(bool reaction)async {
    title = 'تفاعل مع البوست' ;
    body = (reaction == true  ? "أعجب المستخدم " : "تفاعل المستخدم ") + "  ${widget.user_name}  " + "مع البوست الخاص بك";
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
            'body': body ,
            'title': title
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'num' : 2 ,
            'post_Id' : widget.post_Info.companies_post.post_Id
          },
          'to': await widget.post_Info.token,
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

  storage_interaction(String txt)async{
    print("${widget.post_Info.companies_post.post_Id}");
    await FirebaseFirestore.instance.collection("users").doc(widget.user_Id).update({
      "Interaction_log.${widget.post_Info.companies_post.post_Id}" : txt
    }).then((value) {
      print("success");
    });
  }

  delete_interacton()async{
    var map ;
    await FirebaseFirestore.instance.collection("users").doc(widget.user_Id).get().then((value) {
      map = value.data()['Interaction_log'];
    });
    map.remove('${widget.post_Info.companies_post.post_Id}');
    await FirebaseFirestore.instance.collection("users").doc(widget.user_Id).update({
      'Interaction_log' : map
    }).then((value) {
      print("sucesss");
    });
  }

  storage_notification()async{

    await FirebaseFirestore.instance.collection('companies').doc(widget.post_Info.company_Id).collection("notification").add({
      'body' : body,
      'title' : title ,
      'post_Id' : widget.post_Info.companies_post.post_Id,
      'date_publication' : {
        'day' : DateTime.now().day,
        'month' : DateTime.now().month,
        'year' : DateTime.now().year

      },
      'num':2
    });
  }

  @override
  void initState() {
    if(DateTime.now().month == widget.post_Info.companies_post.date['month'])
    {
      if(DateTime.now().day == widget.post_Info.companies_post.date['day'])
      {
        date = "${ DateTime.now().hour -  widget.post_Info.companies_post.date['hour']}" + " ساعة";
      }
      else
        date = "${DateTime.now().day -  widget.post_Info.companies_post.date['day']}" + " يوم";
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool check_sav = true;
    CollectionReference saved_Item = FirebaseFirestore.instance
        .collection("users")
        .doc(widget.user_Id)
        .collection("posts_saved");

    return Container(
        color: ThemeNotifier.mode == true ? Colors.pink.shade50 : Colors.grey.shade800,
        width: MediaQuery.of(context).size.width,
        child: Card(
          color: ThemeNotifier.mode == true ? Colors.white : Colors.grey.shade600,
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
                      child: widget.post_Info.picture== "not" ? Icon(
                        Icons.business,
                        size: 35,
                        color: Colors.white,
                      ) : null,
                      radius: 30,
                      backgroundImage: widget.post_Info.picture != "not"
                          ? NetworkImage(widget.post_Info.picture)
                          : null,
                      backgroundColor: widget.post_Info.picture== "not"
                          ? Colors.pink.shade900
                          : null,
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
                              style: TextStyle(color: ThemeNotifier.mode == true ? Colors.grey.shade700 : Colors.white70),
                            ),
                            Row(
                              children: [
                                Text(date,
                                    style:
                                    TextStyle(color: ThemeNotifier.mode == true ? Colors.grey.shade700 : Colors.white70)),
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
                              storage_interaction("like");
                              setState(() {
                                widget.post_Info.check_like = true;
                                widget.post_Info.check_dislike = false;

                              });
                              await sendNotify(true);
                              storage_notification();
                              await getMessage();
                            }else{
                              delete_interacton();
                              setState(() {
                                widget.post_Info.check_like = false;
                              });
                            }
                          },
                          child: Column(
                            children: [Icon(Icons.thumb_up_alt , color: widget.post_Info.check_like == false && ThemeNotifier.mode == true ? Colors.grey.shade700 : widget.post_Info.check_like == false && ThemeNotifier.mode == false ? Colors.white : Colors.blue), Text("أعجبني")],
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
                              storage_interaction("dislike");
                              setState(() {
                                widget.post_Info.check_dislike = true;
                                widget.post_Info.check_like = false;

                              });
                              await sendNotify(false);
                              storage_notification();
                              await getMessage();

                            }else{
                              delete_interacton();
                              setState(() {
                                widget.post_Info.check_dislike = false;
                              });
                            }

                          },
                          child: Column(
                            children: [
                              Icon(Icons.thumb_down_alt , color: widget.post_Info.check_dislike == false && ThemeNotifier.mode == true ? Colors.grey.shade700 : widget.post_Info.check_dislike == false && ThemeNotifier.mode == false ? Colors.white : Colors.red),
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
                              Icon(Icons.save ,color: widget.post_Info.check_save == false && ThemeNotifier.mode == true ? Colors.grey.shade700 : widget.post_Info.check_save == false && ThemeNotifier.mode == false ? Colors.white : Colors.yellow.shade500),
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

