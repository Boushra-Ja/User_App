import 'dart:convert';
import 'package:b/Home/ThemeManager.dart';
import 'package:b/component/Loading.dart';
import 'package:http/http.dart' as http;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:b/Home/Leatest_New/Company_Publication.dart';
import 'package:b/Home/all_chance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:share/share.dart';
import '../../Info_Job.dart';
import '../../UserInfo.dart';
import '../../postInformation.dart';
import '../../temp_ForPost.dart';
import 'AboutCompany.dart';
import 'Employe_Page.dart';

class companyProfile extends StatefulWidget {
  var list, user_id, company_Id  ,user_name ,num_followers ;
  companyProfile(
      {Key key,
      this.list,
      this.user_id,
        this.user_name,
        this.company_Id,
        this.num_followers
      })
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return profileState();
  }
}

bool check_saved;

class profileState extends State<companyProfile> {
  bool check1 = true,
      check2 = false,
      check3 = false,
      check4 = false , loading = true;
  var num_companies_follow, num_follow ,com_Info , owner_token;
  Info_Job IJ = new Info_Job();
  temp_ForPost tem = new temp_ForPost();
  var posts = [];
  List  All_jobs = [] ;
  CollectionReference company =
  FirebaseFirestore.instance.collection("companies");
  CollectionReference user = FirebaseFirestore.instance.collection("users");
  bool check_followers = true;
  List  employe = [] ;
  List<userInfo> employe_List = [];
  userInfo user_ = new userInfo();

  check_follower() async {
    await company.doc(widget.company_Id).get().then((value) async {
      widget.num_followers = value.data()['followers'].length;
      if (widget.num_followers == 0) {
        if(this.mounted)
        {
          setState(() {
            check_followers = false;
          });
        }
      } else {
        for (int i = 0; i < widget.num_followers; i++) {
          if (value.data()['followers'][i] == widget.user_id) {
            if(this.mounted)
            {
              setState(() {
                check_followers = true;
              });
            }
            break;
          } else {
            if(this.mounted)
            {
              setState(() {
                check_followers = false;
              });
            }
          }
        }
      }
    });
  }

  get_employe()async{
    await FirebaseFirestore.instance.collection('companies').doc(widget.company_Id).get().then((value) {
      employe = value.data()['all_accepted'];
      print(value.data()['all_accepted']);
    });

    if(employe.isNotEmpty){
      employe.forEach((element) async {
        await  FirebaseFirestore.instance.collection('users').doc(element).get().then((value) {
          user_ = new userInfo();
          user_.firstName = value.data()['firstname'];
          user_.endName = value.data()['endname'];
          user_.selectedCountry = value.data()['originalhome'];
          user_.selectedCity = value.data()['placerecident'];
          user_.selectedDay = value.data()['date']['day'];
          user_.selectedMonth = value.data()['date']['month'];
          user_.selectedYear = value.data()['date']['year'];
          user_.selectedEdu = value.data()['scientific_level'];
          user_.selectedFun = value.data()['carrer_level'];
          user_.selectedjob = value.data()['work_field'];
          user_.language =  value.data()['language'];
          user_.Skills =  value.data()['skill'];
          user_.mygmail = value.data()['gmail'];
          user_.imageurl = value.data()['imageurl'];
          if(this.mounted){
            employe_List.add(user_);
          }
        });
      });

    }

  }

  checkSaved() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.user_id)
        .collection("companies_saved")
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (int i = 0; i < value.docs.length; i++) {
          if (value.docs[i].data()['company_Id'] == widget.company_Id) {
            setState(() {
              check_saved = true;
            });
            break;
          } else {
            setState(() {
              check_saved = false;
            });
          }
        }
      } else {
        setState(() {
              check_saved = false;
        });
      }
    });
  }

  sendNotify(String title , String body , var token , String num )async {

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
            'body': body,
            'title': title
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'user_Id' :widget.user_id,
            'num' : num,
          },
          'to':await token  ,
        },
      ),
    );


  }

  storage_notificatio(title , body)async{

    await company.doc(widget.company_Id).collection("notification").add({
      'body' : body,
      'title' : title ,
      'user_Id' : widget.user_id,
      'date_publication' : {
        'day' : DateTime.now().day,
        'month' : DateTime.now().month,
        'year' : DateTime.now().year,
        'hour' :  DateTime.now().hour

      },
      'num':1,
      "date": Timestamp.now()

    });
  }

  get_chance()async{
    await company.doc(widget.company_Id).get().then((value) {
      com_Info = value.data();
    });
    company.doc(widget.company_Id).collection("chance").get().then((value) async {
      if(value.docs.isNotEmpty) {
        /////////for chance
        for(int k = 0 ; k <value.docs.length ; k++) {
          IJ = new Info_Job();
          IJ.job_Info = value.docs[k].data();
          IJ.company_Id = widget.company_Id ;
          IJ.company_Info = com_Info;

          if (this.mounted) {
            setState(() {
              All_jobs.add(IJ);
            });
          }
        }
      }

    });
    if(this.mounted)
      {
        setState(() {
          loading = false;
        });
      }

  }

  get_Post() async {
    await FirebaseFirestore.instance
        .collection('companies')
        .doc(widget.company_Id)
        .collection('Post').orderBy('date_publication' , descending: true).
    get()
        .then((docs) async {
      if (docs.docs.isNotEmpty) {
        /////for to post for company
        for (int i = 0; i < docs.docs.length; i++) {
          tem = new temp_ForPost();

          await FirebaseFirestore.instance
              .collection('users')
              .doc(widget.user_id)
              .collection('posts_saved')
              .get()
              .then((value) async {
            if (value.docs.isNotEmpty) {
              ///////for to post_saved in user
              for (int j = 0; j < value.docs.length; j++) {
                if (value.docs[j].data()['post_Id'] ==
                    docs.docs[i].data()['id']) {
                  tem.check_save = true;
                  break;
                } else {
                  tem.check_save = false;
                }

              }
            } else {
              tem.check_save = false;
            }
          });

          tem.companies_post = new postInformation();
          tem.companies_post.post_Id = docs.docs[i].data()['id'];
          tem.companies_post.my_post = docs.docs[i].data()['myPost'];
          tem.companies_post.title = docs.docs[i].data()['title'];
          tem.companies_post.date = docs.docs[i].data()['date_publication'];
          tem.company_Id = widget.company_Id;
          tem.company_name = widget.list['company'];
          tem.token = widget.list['token'];
          tem.picture = widget.list['link_image'];
          await company.doc(widget.company_Id).get().then((v) {
            tem.num_follwers = v.data()['followers'].length;
          });

          await FirebaseFirestore.instance
              .collection('users')
              .doc(widget.user_id).get().then((t) {
            if(t.data()['Interaction_log'].containsKey("${docs.docs[i].data()['id']}")){
              if(this.mounted) {
                if (t.data()['Interaction_log']["${docs.docs[i]
                    .data()['id']}"] == 'like') {
                  setState(() {
                    tem.check_like = true;
                    tem.check_dislike = false;
                  });
                } else {
                  setState(() {
                    tem.check_like = false;
                    tem.check_dislike = true;
                  });
                }
              }
            }
          });
          posts.add(tem);
        }
      }
    });
  }

  @override
  void initState() {
    () async {
      await FirebaseFirestore.instance.collection('oner').doc('DPi7T09bNPJGI0lBRqx4').get().then((value) {
        owner_token = value.data()['token'];
      });
      await check_follower();
      await checkSaved();
      await get_Post();
      await get_chance();
      await get_employe();
    }();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  loading ? Loading() : Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              body: LayoutBuilder(

                builder: (context , constraints){
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: ListView(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height / 2 + 70,
                          width: MediaQuery.of(context).size.width,
                          child: Stack(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height / 2,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors:ThemeNotifier.mode == true ?  <Color>[
                                          Colors.pink.shade900,
                                          Colors.grey.shade800
                                        ] :<Color>[
                                          Colors.grey.shade900,
                                          Colors.grey.shade700
                                        ] )),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 20.0, right: 30),
                                          child: CircleAvatar(
                                            radius: MediaQuery.of(context).size.width/8,
                                            backgroundImage:
                                            widget.list['link_image'] != "not"
                                                ? NetworkImage(
                                                widget.list['link_image'])
                                                : null,
                                            backgroundColor:
                                            widget.list['link_image'] == "not"
                                                ? Colors.amber.shade50
                                                : null,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 30.0),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: AutoSizeText(
                                                  "${widget.list['company']}",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w600),
                                                  maxLines: 2,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.only(top: 8.0),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.room,
                                                      size: 16,
                                                      color: Colors.white,
                                                    ),
                                                    Text(
                                                      "${widget.list['region']} ، ${widget.list['city']}",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Divider(
                                      color: Colors.white,
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(top: 3, bottom: 3),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              flex: 1,
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "عدد الموظفين",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.white),
                                                  ),
                                                  Text("${widget.list['all_accepted'].length}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                          FontWeight.w900,
                                                          color: Colors.white))
                                                ],
                                              )),
                                          Expanded(
                                              flex: 1,
                                              child: Column(
                                                children: [
                                                  Text("عدد المتابعين",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white)),
                                                  Text(
                                                    "${widget.num_followers}",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w900,
                                                        color: Colors.white),
                                                  )
                                                ],
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                  child: Transform.scale(
                                    scale: 1.4,
                                    child: Transform.translate(
                                      offset: Offset(0,
                                          (MediaQuery.of(context).size.height / 2 - 240)),
                                      child: Center(
                                        child: Container(
                                          height:
                                          MediaQuery.of(context).size.height / 4 -
                                              35,
                                          width:
                                          MediaQuery.of(context).size.width - 100,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30),
                                            color: ThemeNotifier.mode == true ? Colors.white : Colors.grey.shade600,
                                          ),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                const EdgeInsets.only(top: 20.0),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      padding:
                                                      EdgeInsets.only(right: 15),
                                                      width: 170,
                                                      height: 30,
                                                      child: ElevatedButton.icon(
                                                        style: ElevatedButton.styleFrom(
                                                          elevation: 2,
                                                          primary:  ThemeNotifier.mode == true ? Colors.amber.shade50 : Colors.grey.shade800,
                                                          shadowColor: Colors.pink.shade300,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                              new BorderRadius
                                                                  .circular(30.0)),
                                                        ),
                                                        onPressed: () async {
                                                          //////////////Add User to Company
                                                          if (check_followers ==
                                                              false) {
                                                            sendNotify('متابعة' , "قام المستخدم " + "${widget.user_name}" + " بعمل متابعة لشركتك ^_^" ,  widget.list['token']  , "1" );
                                                            storage_notificatio('متابعة' , "قام المستخدم " + "${widget.user_name}" + " بعمل متابعة لشركتك ^_^" );
                                                            setState(() {
                                                              check_followers =
                                                              true;
                                                              widget.num_followers =
                                                                  widget.num_followers +
                                                                      1;
                                                            });
                                                            await company
                                                                .doc(widget.company_Id)
                                                                .update({
                                                              "followers":
                                                              FieldValue.arrayUnion(
                                                                  [widget.user_id])
                                                            }).then((value) {
                                                              print('Sucsess');
                                                            }).catchError((e) {
                                                              AwesomeDialog(
                                                                  context: context,
                                                                  title: "Error",
                                                                  body: Text('Error'))
                                                                ..show();
                                                            });
                                                            ///////////////Add Company To user
                                                            await user
                                                                .doc(widget.user_id)
                                                                .update({
                                                              "companies_follow":
                                                              FieldValue
                                                                  .arrayUnion([
                                                                widget.company_Id
                                                              ])
                                                            }).then((value) {
                                                              print('Sucsess');
                                                            }).catchError((e) {
                                                              AwesomeDialog(
                                                                  context: context,
                                                                  title: "Error",
                                                                  body: Text('Error'))
                                                                ..show();
                                                            });
                                                          } else {
                                                            setState(() {
                                                              check_followers =
                                                              false;
                                                              widget.num_followers =
                                                                  widget.num_followers -
                                                                      1;
                                                            });
                                                            //////////////////////Delete User From Company
                                                            await company
                                                                .doc(widget.company_Id)
                                                                .get()
                                                                .then((value) async {
                                                              for (int i = 0;
                                                              i <
                                                                  value
                                                                      .data()[
                                                                  'followers']
                                                                      .length;
                                                              i++) {
                                                                if (value.data()[
                                                                'followers']
                                                                [i] ==
                                                                    widget.user_id) {

                                                                  var val =
                                                                  []; //blank list for add elements which you want to delete
                                                                  val.add(
                                                                      '${value.data()['followers'][i]}');
                                                                  company
                                                                      .doc(widget
                                                                      .company_Id)
                                                                      .update({
                                                                    "followers":
                                                                    FieldValue
                                                                        .arrayRemove(
                                                                        val)
                                                                  }).then((value) {
                                                                    print('Sucsess');
                                                                  }).catchError((e) {
                                                                    AwesomeDialog(
                                                                        context:
                                                                        context,
                                                                        title: "Error",
                                                                        body: Text(
                                                                            'Error'))
                                                                      ..show();
                                                                  });
                                                                }
                                                              }
                                                            });
                                                            ///////////////Delete Company From User
                                                            await user
                                                                .doc(widget.user_id)
                                                                .get()
                                                                .then((value) async {
                                                              num_companies_follow = value
                                                                  .data()[
                                                              'companies_follow']
                                                                  .length;
                                                              for (int i = 0;
                                                              i < num_companies_follow;
                                                              i++) {
                                                                if (value.data()[
                                                                'companies_follow']
                                                                [i] ==
                                                                    widget.company_Id) {
                                                                  var val =
                                                                  []; //blank list for add elements which you want to delete
                                                                  val.add(
                                                                      '${value.data()['companies_follow'][i]}');
                                                                  user
                                                                      .doc(widget
                                                                      .user_id)
                                                                      .update({
                                                                    "companies_follow":
                                                                    FieldValue
                                                                        .arrayRemove(
                                                                        val)
                                                                  }).then((value) {
                                                                    print('Sucsess');
                                                                  }).catchError((e) {
                                                                    AwesomeDialog(
                                                                        context:
                                                                        context,
                                                                        title: "Error",
                                                                        body: Text(
                                                                            'Error'))
                                                                      ..show();
                                                                  });
                                                                }
                                                              }
                                                            });
                                                          }
                                                        },
                                                        icon: Icon(
                                                          check_followers ==
                                                              false
                                                              ? Icons.plus_one
                                                              : Icons.minimize,
                                                          color: ThemeNotifier.mode == true ? Colors.black : Colors.white,
                                                          size: 16,
                                                        ),
                                                        label: Text(
                                                          check_followers ==
                                                              false
                                                              ? "متابعة"
                                                              : "الغاء المتابعة",
                                                          style: TextStyle(
                                                              color: ThemeNotifier.mode == true ? Colors.black : Colors.white,
                                                              fontSize: 12),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Container(
                                                      width: 60,
                                                      height: 30,
                                                      child: ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                          elevation: 2,
                                                          primary: ThemeNotifier.mode == true ? Colors.amber.shade50 : Colors.grey.shade800,
                                                          shadowColor: Colors.pink.shade300,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                              new BorderRadius
                                                                  .circular(30.0)),
                                                        ),
                                                        onPressed: () {},
                                                        child: PopupOptionMenu(
                                                            user_Id: widget.user_id,
                                                            company_Id:
                                                            widget.company_Id,user_name: widget.user_name,company_name: widget.list['company'],owner_token: owner_token,),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Divider(
                                                color: Colors.black,
                                              ),

                                              /////Scroll horizantal//////
                                              SingleChildScrollView(
                                                scrollDirection: Axis.horizontal,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(
                                                      right: 10.0),
                                                  child: Row(
                                                    children: [
                                                      InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              check1 = true;
                                                              check2 = false;
                                                              check3 = false;
                                                              check4 = false;
                                                            });
                                                          },
                                                          child: buildContainer(
                                                              "نبذة عني", 1)),
                                                      SizedBox(
                                                        width: 15,
                                                      ),
                                                      InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              check2 = true;
                                                              check1 = false;
                                                              check3 = false;
                                                              check4 = false;
                                                            });
                                                          },
                                                          child: buildContainer(
                                                              "المنشورات", 2)),
                                                      SizedBox(
                                                        width: 15,
                                                      ),
                                                      InkWell(
                                                        child: buildContainer(
                                                            "الوظائف", 3),
                                                        onTap: () {
                                                          setState(() {
                                                            check3 = true;
                                                            check2 = false;
                                                            check4 = false;
                                                            check1 = false;
                                                          });
                                                        },
                                                      ),
                                                      SizedBox(
                                                        width: 15,
                                                      ),
                                                      InkWell(
                                                        child: buildContainer(
                                                            "الموظفين", 4),
                                                        onTap: () {
                                                          setState(() {
                                                            check4 = true;
                                                            check2 = false;
                                                            check3 = false;
                                                            check1 = false;
                                                          });
                                                        },
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        check1 == true
                            ? aboutCompany(
                          list: widget.list,
                        )
                            : check2 == true
                            ?Container(
                          width: MediaQuery.of(context).size.width,
                            color: ThemeNotifier.mode ? Colors.white : Colors.grey.shade800,
                            child: company_Publication(post_Info: posts,user_Id: widget.user_id ,user_name: widget.user_name))
                            : check3 == true ?  Container(
                            width: MediaQuery.of(context).size.width,
                            color: ThemeNotifier.mode ? Colors.white : Colors.grey.shade800,
                            child: all_chance(All_jobs,All_jobs, widget.user_id  ,false)) :
                        Container(
                            width: MediaQuery.of(context).size.width,
                            color: ThemeNotifier.mode ? Colors.white : Colors.grey.shade800,
                            child: employePage(employe_List : employe_List))

                      ],

                    ),
                  );
                },
              )
            ));
  }

  buildContainer(String text, int num) {
    return Container(
      width: 100,
      height: 25,
      child: Center(
          child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 10),
      )),
      decoration: BoxDecoration(
          color: num == 1
              ? ((check1 == true && ThemeNotifier.mode == true) ?
                   Colors.pink.shade900.withOpacity(0.4) : (check1 == true && ThemeNotifier.mode == false) ?Colors.grey.shade300
              : ThemeNotifier.mode == true ? Colors.amber.shade50 : Colors.grey.shade700)
              : num == 2
                  ? ((check2 == true && ThemeNotifier.mode == true) ?
          Colors.pink.shade900.withOpacity(0.4) : (check2 == true && ThemeNotifier.mode == false) ? Colors.grey.shade300
              : ThemeNotifier.mode == true ? Colors.amber.shade50 : Colors.grey.shade700)
                  : num == 3
                      ? ((check3 == true && ThemeNotifier.mode == true) ?
          Colors.pink.shade900.withOpacity(0.4) : (check3 == true && ThemeNotifier.mode == false) ?Colors.grey.shade300
              : ThemeNotifier.mode == true ? Colors.amber.shade50 : Colors.grey.shade700)
                      : num == 4
                          ? ((check4 == true && ThemeNotifier.mode == true) ?
          Colors.pink.shade900.withOpacity(0.4) : (check4 == true && ThemeNotifier.mode == false) ? Colors.grey.shade300
              : ThemeNotifier.mode == true ? Colors.amber.shade50 : Colors.grey.shade700)
                          : null,
          borderRadius: BorderRadius.circular(30)),
    );
  }
}

enum MenuOption { save, share, report }

class PopupOptionMenu extends StatefulWidget {
  final user_Id, company_Id , user_name , company_name , owner_token;
  const PopupOptionMenu({Key key, this.user_Id, this.company_Id,this.user_name,this.company_name,this.owner_token})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return PopupOptionMenuState();
  }
}

class PopupOptionMenuState extends State<PopupOptionMenu> {

  @override
  Widget build(BuildContext context) {
    String title , body;
    title = 'اشعار إبلاغ';
    body = "قام المستخدم " + "${widget.user_name}" + " بالإبلاغ عن الشركة " +"${widget.company_name}";
    CollectionReference saved_Item = FirebaseFirestore.instance
        .collection("users")
        .doc(widget.user_Id)
        .collection("companies_saved");

    return Directionality(
      textDirection: TextDirection.rtl,
      child: PopupMenuButton<MenuOption>(
          icon: Icon(
            Icons.menu,
            color: ThemeNotifier.mode == true ? Colors.black : Colors.white,
            size: 16,
          ),
          itemBuilder: (BuildContext context) {
            return <PopupMenuEntry<MenuOption>>[
              PopupMenuItem(
                child: ListTile(
                  onTap: () async {
                    if (check_saved == false) {
                      setState(() {
                        check_saved = true;
                      });
                      await saved_Item
                          .add({'company_Id': widget.company_Id}).then((value) {
                        print("success");
                        Navigator.of(context).pop();
                      }).catchError((onError) {
                        print(onError);
                      });
                    } else {
                      setState(() {
                        check_saved = false;
                      });
                      await saved_Item.get().then((value) async {
                        if (value.docs.isNotEmpty) {
                          for (int j = 0; j < value.docs.length; j++) {
                            if (value.docs[j].data()['company_Id'] ==
                                widget.company_Id) {
                              saved_Item
                                  .where("company_Id",
                                      isEqualTo: widget.company_Id)
                                  .get()
                                  .then((value) {
                                value.docs.forEach((element) {
                                  saved_Item
                                      .doc(element.id)
                                      .delete()
                                      .then((value) {
                                    print("Success!");
                                    Navigator.of(context).pop();
                                  });
                                });
                              });
                            }
                          }
                        }
                      });
                    }
                  },
                  trailing: Icon(
                    Icons.save,
                    color: Colors.black,
                  ),
                  title: Text(
                    check_saved == false ? "حفظ" : "الغاء الحفظ",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                value: MenuOption.save,
              ),
              PopupMenuItem(
                child: ListTile(
                  onTap: () {
                    share(context);
                    Navigator.of(context).pop();

                  },
                  trailing: Icon(Icons.share, color: Colors.black),
                  title: Text(
                    "مشاركة   ",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                value: MenuOption.share,
              ),
              PopupMenuItem(
                child: ListTile(
                  onTap: ()async {
                     await sendNotify(title , body);
                     Navigator.of(context).pop();
                     await storage_notificatio(title , body);
                  },
                  trailing: Icon(Icons.report, color: Colors.black),
                  title: Text(
                    "ابلاغ",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                value: MenuOption.report,
              )
            ];
          }),
    );
  }
  void share(BuildContext context ){
    String txt = "شركة فروح" +"\n" + "شركة مختصة بمحال ..... "  +"\n"+"موقع الشركة : بييييييييييي" + "\n"+
        "الوصف : " + "ييييييييي" +'\n';
    final RenderBox box = context.findRenderObject();
    final String text = txt;
    Share.share(text ,
      subject: "معلومات الفرصة",
      sharePositionOrigin: box.localToGlobal(Offset.zero)&box.size,
    );
  }

  sendNotify(String title , String body)async {

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
            'body': body,
            'title': title
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'user_Id' : widget.user_Id,
            'num' : "2",
            'id' : widget.company_Id,
            'type' : "1"

          },
          'to':await widget.owner_token  ,
        },
      ),
    );


  }

  storage_notificatio(String title , String body)async{

    await FirebaseFirestore.instance.collection('oner').doc("DPi7T09bNPJGI0lBRqx4").collection("reports").add({
      'body' : body,
      'title' : title ,
      'id' : widget.company_Id,
      'date_publication' : {
        'day' : DateTime.now().day,
        'month' : DateTime.now().month,
        'year' : DateTime.now().year,
        'hour' :  DateTime.now().hour
      },
      'num': 2 ,
      "date": Timestamp.now(),
      'type' : 1
    });
  }


}
