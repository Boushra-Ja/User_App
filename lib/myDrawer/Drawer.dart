import 'dart:io';
import 'dart:math';
import 'package:b/authintication/login.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:b/Home/homepage.dart';
import 'package:b/SettingPage/setting_page.dart';
import 'package:b/component/alart.dart';
import 'package:b/cv_page/EditProfile.dart';
import 'package:b/cv_page/EditProfile2.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class mydrawer extends StatefulWidget {
  final userInfo, docid;

  const mydrawer({Key key, this.userInfo, this.docid}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return drawerState();
  }
}

class drawerState extends State<mydrawer> {
  File file;

  var imagepicker = ImagePicker();

  CollectionReference userref = FirebaseFirestore.instance.collection("users");

  @override
  void initState() {
    print(widget.userInfo);
    super.initState();
  }

  UploadImagesFromCamera(context, int num) async {
    var picker;
    if (num == 1)
      picker = await imagepicker.getImage(source: ImageSource.camera);
    else
      picker = await imagepicker.getImage(source: ImageSource.gallery);

    if (picker != null) {
      file = File(picker.path);
      var nameImage = basename(picker.path);
      var random = Random().nextInt(10000);
      nameImage = "$random$nameImage";
      var refstorage = FirebaseStorage.instance
          .ref()
          .child("profileImages")
          .child("$nameImage");
      showLoading(context);
      await refstorage.putFile(file);
      var url = await refstorage.getDownloadURL();

      print(widget.docid);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.docid)
          .update({'imageurl': url}).then((value) {
        print("sucsess");
        showLoading(context);
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacementNamed('homepage');
      }).catchError((e) {
        print("error");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl, child: Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              widget.userInfo['firstname'] + " " + widget.userInfo['endname'],
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
            currentAccountPicture: InkWell(
              onTap: () async {
                showDialog(
                    context: context,
                    builder: (ctxt) => new AlertDialog(
                        title: Column(
                          children: [
                            InkWell(
                                onTap: () async {
                                  UploadImagesFromCamera(context, 1);
                                },
                                child: Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            flex: 4,
                                            child: Container(
                                                width: double.infinity,
                                                child: Text(
                                                  "تحميل من الكاميرا",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                      FontWeight.normal),
                                                  textDirection:
                                                  TextDirection.rtl,
                                                  textAlign: TextAlign.right,
                                                ))),
                                        Expanded(
                                            flex: 1,
                                            child: Icon(
                                              Icons.camera_alt,
                                              size: 30,
                                            )),
                                      ],
                                    ))),
                            InkWell(
                                onTap: () async {
                                  UploadImagesFromCamera(context, 2);
                                },
                                child: Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            flex: 4,
                                            child: Container(
                                                width: double.infinity,
                                                child: Text(
                                                  "تحميل من المعرض",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                      FontWeight.normal),
                                                  textDirection:
                                                  TextDirection.rtl,
                                                  textAlign: TextAlign.right,
                                                ))),
                                        Expanded(
                                            flex: 1,
                                            child: Icon(
                                              Icons.camera,
                                              size: 30,
                                            )),
                                      ],
                                    ))),
                          ],
                        )));
                //  await UploadImages();
              },
              child: CircleAvatar(
                  radius: 45,
                  backgroundImage: widget.userInfo['imageurl'] != 'not'
                      ? NetworkImage(widget.userInfo['imageurl'])
                      : null,
                  backgroundColor: widget.userInfo['imageurl'] == 'not'
                      ? Colors.pink.shade800
                      : null,
                  child: widget.userInfo['imageurl'] == 'not'
                      ? Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.white,
                  )
                      : null),
            ),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/photo8.jpg'), fit: BoxFit.fill)),
          ),
          ListTile(
              title: Text(
                "الصفحة الرئيسية",
                style: TextStyle(fontSize: 16),
              ),
              leading: IconButton(
                icon: Icon(
                  Icons.home,
                  color: Colors.grey.shade600,
                ),
                iconSize: 22,
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return MyHomePage();
                }));
              }),
          ListTile(
              title: Text(
                "  المعلومات الشخصية",
                style: TextStyle(fontSize: 16),
              ),
              leading: IconButton(
                icon: Icon(Icons.edit, color: Colors.grey.shade600),
                iconSize: 22,
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  print("**************************");
                  print(widget.userInfo);
                  print("**************************");
                  return EditProfile(
                      list: widget.userInfo, docid: widget.docid);
                }));
              }),
          ListTile(
              title: Text(
                "  معلومات العمل",
                style: TextStyle(fontSize: 16),
              ),
              leading: IconButton(
                icon: Icon(Icons.work, color: Colors.grey.shade600),
                iconSize: 22,
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  print("**************************");
                  print(widget.userInfo);
                  print("**************************");
                  return EditProfile2(
                      list: widget.userInfo, docid: widget.docid);
                }));
              }),
          ListTile(
              title: Text(
                "الاشعارات",
                style: TextStyle(fontSize: 16),
              ),
              leading: IconButton(
                icon: Icon(Icons.notifications_rounded,
                    color: Colors.grey.shade600),
                iconSize: 22,
              ),
              onTap: () {}),
          ListTile(
              title: Text(
                "تصنيف الفرص",
                style: TextStyle(fontSize: 16),
              ),
              leading: IconButton(
                icon: Icon(Icons.filter, color: Colors.grey.shade600),
                iconSize: 22,
              ),
              onTap: () {}),
          ListTile(
              title: Text(
                " الاعدادات",
                style: TextStyle(fontSize: 16),
              ),
              leading: IconButton(
                icon: Icon(Icons.settings, color: Colors.grey.shade600),
                iconSize: 22,
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  print("**************************");
                  print(widget.userInfo);
                  print("**************************");
                  return settingPage(
                      list: widget.userInfo, docid: widget.docid);
                }));
              }),
          Divider(
            thickness: 2,
          ),
          ListTile(
              title: Text(
                " دعوة صديق ",
                style: TextStyle(fontSize: 16),
              ),
              leading: IconButton(
                icon: Icon(Icons.group_add, color: Colors.grey.shade600),
                iconSize: 22,
              ),
              onTap: () {}),
          ListTile(
              title: Text(
                " تسجيل الخروج",
                style: TextStyle(fontSize: 16),
              ),
              leading: IconButton(
                icon: Icon(Icons.logout, color: Colors.grey.shade600),
                iconSize: 22,
              ),
              onTap: () async {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog();
                    });
                await FirebaseAuth.instance.signOut();
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return Login();
                }));
              })
        ],
      ),
    ));
  }
}
