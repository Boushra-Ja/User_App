import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:b/myDrawer/UserProfilePage/ProfilePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'dart:math';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:b/component/alart.dart';
import '../UserInfo.dart';

class showDialog_Photo extends StatefulWidget {
  final docid , num ;
  final userInfo user;
  const showDialog_Photo({Key key,  this.user , this.docid , this.num}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return showDialogeState();
  }
}

class showDialogeState extends State<showDialog_Photo>{
  var imagepicker = ImagePicker(), photo;
  Reference refstorage;
  File file;
  CollectionReference userRef = FirebaseFirestore.instance.collection("users");


  @override
  Widget build(BuildContext context) {

    return Center(
          child: InkWell(
            onTap: (){
              showDialog(
                  context: context,
                  builder: (ctxt) => new AlertDialog(
                      title: Column(
                        children: [
                          InkWell(
                              onTap: () async {
                                await UploadImages(
                                    context, 1);
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
                                await UploadImages(
                                    context, 2);

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
                      )
                  )
              );

            },
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [ widget.num == 0 ? Colors.grey.shade500 : Colors.pink.shade800 , Colors.grey.shade800 ]),
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                  radius: 70,
                  backgroundImage: photo != null
                      ? FileImage(photo)
                      : widget.user.imageurl != 'not'
                      ? NetworkImage(widget.user.imageurl)
                      : null,
                  backgroundColor: widget.user.imageurl == 'not'
                      ?        Colors.transparent

                  : null,
                  child: (widget.user.imageurl == 'not'&& photo == null)
                      ? Icon(
                    Icons.person,
                    size: widget.num == 0 ? 70 : 40,
                    color: Colors.white,
                  )
                      : null),
            )
          ),
        );
  }

  UploadImages(BuildContext context, int num) async {
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
      refstorage = FirebaseStorage.instance
          .ref()
          .child("profileImages")
          .child("$nameImage");
      setState(() {
        photo = file;
      });

      showLoading(context);
      await UpdateData(context);
    }
  }
  UpdateData(context) async {
        await refstorage.putFile(file);
        var url = await refstorage.getDownloadURL();
        widget.user.imageurl = url;
        await userRef.doc(widget.docid).update({
          'imageurl': url
        }).then((value) {
          widget.num == 0 ? Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
            return userProfile(user: widget.user, docid: widget.docid);
          })) : Navigator.of(context).pop() ;
          print('Sucsess');
        }).catchError((e) {
          AwesomeDialog(context: context, title: "Error", body: Text('Error'))
            ..show();
        });

  }
    }
