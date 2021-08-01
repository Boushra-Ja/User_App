import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:b/Home/Leatest_New/Company_Publication.dart';
import 'package:b/Home/all_chance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../Info_Job.dart';
import 'AboutCompany.dart';
import 'Employe_Page.dart';

class companyProfile extends StatefulWidget {
  var list, user_id, check_followers, list_post , company_Id ,num_followers , chance_list;
  companyProfile(
      {Key key,
      this.list,
      this.user_id,
      this.check_followers,
        this.company_Id,
        this.num_followers,
      this.list_post,
        this.chance_list
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
      check4 = false;
  var num_companies_follow, num_follow;
  CollectionReference company =
      FirebaseFirestore.instance.collection("companies");
  CollectionReference user = FirebaseFirestore.instance.collection("users");
  Info_Job IJ = new Info_Job();
  bool loading = true ;

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

  @override
  void initState() {
    () async {
      await checkSaved();
    }();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              body: Container(
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
                                    colors: <Color>[
                                  Colors.pink.shade900,
                                  Colors.grey.shade800
                                ])),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20.0, right: 30),
                                      child: CircleAvatar(
                                        radius: 50,
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
                                              Text("8k",
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
                                  MediaQuery.of(context).size.height / 2 - 240),
                              child: Center(
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 4 -
                                          35,
                                  width:
                                      MediaQuery.of(context).size.width - 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.white,
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
                                                  primary: Colors.amber.shade50,
                                                  shadowColor: Colors.pink,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          new BorderRadius
                                                              .circular(30.0)),
                                                ),
                                                onPressed: () async {
                                                  //////////////Add User to Company
                                                  if (widget.check_followers ==
                                                      false) {
                                                    setState(() {
                                                      widget.check_followers =
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
                                                      widget.check_followers =
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
                                                  widget.check_followers ==
                                                          false
                                                      ? Icons.plus_one
                                                      : Icons.minimize,
                                                  color: Colors.black,
                                                  size: 16,
                                                ),
                                                label: Text(
                                                  widget.check_followers ==
                                                          false
                                                      ? "متابعة"
                                                      : "الغاء المتابعة",
                                                  style: TextStyle(
                                                      color: Colors.black,
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
                                                  primary: Colors.amber.shade50,
                                                  shadowColor: Colors.pink,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          new BorderRadius
                                                              .circular(30.0)),
                                                ),
                                                onPressed: () {},
                                                child: PopupOptionMenu(
                                                    user_Id: widget.user_id,
                                                    company_Id:
                                                        widget.company_Id),
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
                            ?company_Publication(post_Info: widget.list_post,user_Id: widget.user_id)
                            : check3 == true ?  all_chance(widget.chance_list, widget.user_id):employePage()

                  ],

                ),
              ),
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
              ? (check1 == true
                  ? Colors.pink.shade900.withOpacity(0.4)
                  : Colors.amber.shade50)
              : num == 2
                  ? (check2 == true
                      ? Colors.pink.shade900.withOpacity(0.4)
                      : Colors.amber.shade50)
                  : num == 3
                      ? (check3 == true
                          ? Colors.pink.shade900.withOpacity(0.4)
                          : Colors.amber.shade50)
                      : num == 4
                          ? (check4 == true
                              ? Colors.pink.shade900.withOpacity(0.4)
                              : Colors.amber.shade50)
                          : null,
          borderRadius: BorderRadius.circular(30)),
    );
  }
}

enum MenuOption { save, share, report }

class PopupOptionMenu extends StatefulWidget {
  final user_Id, company_Id;
  const PopupOptionMenu({Key key, this.user_Id, this.company_Id})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return PopupOptionMenuState();
  }
}

class PopupOptionMenuState extends State<PopupOptionMenu> {
  @override
  Widget build(BuildContext context) {
    CollectionReference saved_Item = FirebaseFirestore.instance
        .collection("users")
        .doc(widget.user_Id)
        .collection("companies_saved");

    return Directionality(
      textDirection: TextDirection.rtl,
      child: PopupMenuButton<MenuOption>(
          icon: Icon(
            Icons.menu,
            color: Colors.black,
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
                  onTap: () {},
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
                  onTap: () {},
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
}
