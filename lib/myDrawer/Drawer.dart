import 'dart:io';
import 'dart:math';
import 'package:b/authintication/login.dart';
import 'package:b/helpFunction/showDialoge_photo.dart';
import 'package:b/myDrawer/UserProfilePage/ProfilePage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:b/Home/homepage.dart';
import 'package:b/SettingPage/setting_page.dart';
import 'package:b/component/alart.dart';
import 'package:b/cv_page/EditProfile2.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../UserInfo.dart';

class mydrawer extends StatefulWidget {
  final userInfo user;
  final docid;

  const mydrawer({Key key, this.user, this.docid}) : super(key: key);

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
    print(widget.user);
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
    final bloc = Provider.of<userInfo>(context) ;

    return Directionality(textDirection: TextDirection.rtl, child: Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              widget.user.firstName + " " + widget.user.endName,
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
                        title: showDialog_Photo(),

                    ));
                //  await UploadImages();
              },
              child: CircleAvatar(
                  radius: 45,
                  backgroundImage: widget.user.imageurl!= 'not'
                      ? NetworkImage(widget.user.imageurl)
                      : null,
                  backgroundColor: widget.user.imageurl == 'not'
                      ? Colors.pink.shade800
                      : null,
                  child: widget.user.imageurl == 'not'
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
                print("___________________________");
                print(bloc.firstName);
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return MyHomePage();
                }));
              }),
          ListTile(
              title: Text(
                "  الملف الشخصي",
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
                  print(widget.user);
                  print("**************************");
                  return userProfile(user : widget.user , docid : widget.docid);
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
                  print(widget.user);
                  print("**************************");
                  return settingPage(
                      user: widget.user, docid: widget.docid);
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
                    .pushReplacement(MaterialPageRoute(builder: (context) {
                  return Login();
                }));
              })
        ],
      ),
    ));
  }
}
