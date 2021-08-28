import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:b/Home/ThemeManager.dart';
import 'package:b/component/alart.dart';
import 'package:b/helpFunction/buildCard.dart';
import 'package:b/helpFunction/buildDropdownButton.dart';
import 'package:b/helpFunction/buildText.dart';
import 'package:b/helpFunction/showDialoge_photo.dart';
import 'package:b/myDrawer/UserProfilePage/Edit_WorkInfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../UserInfo.dart';
import 'dart:ui' as ui;

class userProfile extends StatefulWidget {
  final docid, country, city;
  final userInfo user;

  const userProfile({Key key, this.user, this.docid, this.country, this.city})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return userProfileState();
  }
}

class userProfileState extends State<userProfile> {
  CollectionReference userRef = FirebaseFirestore.instance.collection("users");
  bool check1 = true, check2 = false, check3 = false, check4 = false;
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  GlobalKey<FormState> formstate2 = new GlobalKey<FormState>();
  GlobalKey<FormState> formstate3 = new GlobalKey<FormState>();

  updateData_personal(context) async {
    var formdata = formstate.currentState;
    if (formdata.validate()) {
      showLoading(context);
      formdata.save();
      print("))))))))))))))))))))))))))))))))))");
      print( widget.user.firstName);
      await userRef.doc(widget.docid).update({
        'firstname': widget.user.firstName,
        'endname': widget.user.endName,
        'gender': widget.user.selectedGender,
        'date': {
          'day': widget.user.selectedDay,
          'month': widget.user.selectedMonth,
          'year': widget.user.selectedYear
        },
        'Nationality': widget.user.selectedNationality,
        'originalhome': widget.user.selectedCountry,
        'placerecident': widget.user.selectedCity,
      }).then((value) {
        print('Sucsess');
        Navigator.of(context).pop();
      }).catchError((e) {
        AwesomeDialog(context: context, title: "Error", body: Text('Error'))
          ..show();
      });
    }
  }

  updateData_contact(context) async {
    var formdata = formstate2.currentState;
    if (formdata.validate()) {
      showLoading(context);
      formdata.save();
      await userRef.doc(widget.docid).update({
        'gmail': widget.user.mygmail,
        'phone': widget.user.phone,
      }).then((value) {
        print('Sucsess');
        Navigator.of(context).pop();
      }).catchError((e) {
        AwesomeDialog(context: context, title: "Error", body: Text('Error'))
          ..show();
      });
    }
  }

  updateData_seintific(context) async {
    var formdata = formstate3.currentState;
    if (formdata.validate()) {
      showLoading(context);
      formdata.save();
      await userRef.doc(widget.docid).update({
        'scientific_level': widget.user.selectedEdu,
        'carrer_level': widget.user.selectedFun,
        'experience_year': widget.user.selectedExpr,
        'skill': widget.user.Skills,
        'language': widget.user.language
      }).then((value) {
        print('Sucsess');
        Navigator.of(context).pop();
      }).catchError((e) {
        AwesomeDialog(context: context, title: "Error", body: Text('Error'))
          ..show();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: [
              Container(
                  height: 250,
                  child: Stack(
                    children: [
                      CustomPaint(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                        ),
                        painter: HeaderCurvedContainer(),
                      ),
                      Container(
                          margin: EdgeInsets.all(15),
                          child: InkWell(
                            child: Icon(
                              Icons.arrow_back,
                              size: 25,
                              color: Colors.white,
                            ),
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          )),
                      Positioned(
                          top: 5,
                          right: MediaQuery.of(context).size.width - 100,
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, size: 25),
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return  Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: Scaffold(
                                              appBar: AppBar(
                                                toolbarHeight: 80,
                                                title: Text(
                                                  "تعديل المعلومات االشخصية ",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white),
                                                ),
                                                backgroundColor:
                                                    ThemeNotifier.mode
                                                        ? Colors.pink.shade900
                                                        : Colors.black87,
                                                centerTitle: true,
                                                leading: InkWell(
                                                  child: Icon(Icons.arrow_back),
                                                  onTap: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ),
                                              body: Center(
                                                  child: Container(
                                                    width: 320,
                                                    child: Form(
                                                      key: formstate,
                                                      child: ListView(
                                                        children: [
                                                          SizedBox(
                                                            height: 40,
                                                          ),
                                                          buildCard(
                                                              'false',
                                                              1,
                                                              " الاسم الاول*",
                                                              0,
                                                              widget.user),
                                                          SizedBox(
                                                            height: 20,
                                                          ),
                                                          buildCard(
                                                              'false',
                                                              2,
                                                              " الاسم الأخير*",
                                                              0,
                                                              widget.user),
                                                          SizedBox(
                                                            height: 20,
                                                          ),
                                                          buildCard(
                                                              "اختر",
                                                              0,
                                                              "الجنس*",
                                                              4,
                                                              widget.user),
                                                          SizedBox(
                                                            height: 20,
                                                          ),
                                                          buildCard(
                                                              'اختر',
                                                              0,
                                                              'تاريخ الميلاد',
                                                              5,
                                                              widget.user),
                                                          SizedBox(
                                                            height: 30,
                                                          ),
                                                          Card(
                                                            margin: EdgeInsets.only(
                                                                bottom: 30,
                                                                top: 10),
                                                            color:
                                                                ThemeNotifier.mode
                                                                    ? Colors.grey
                                                                        .shade100
                                                                    : Colors.grey
                                                                        .shade500,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20)),
                                                            child: Column(
                                                              children: [
                                                                SizedBox(
                                                                  height: 40,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    buildText(
                                                                        "الجنسية*",
                                                                        2),
                                                                    buildDropdownButton(
                                                                        3,
                                                                        'اختر',
                                                                        5,
                                                                        widget.user,
                                                                        widget
                                                                            .country,
                                                                        widget
                                                                            .city),
                                                                    buildText(
                                                                        " ", 1),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 35,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    buildText(
                                                                        "بلد الإقامة*",
                                                                        2),
                                                                    buildDropdownButton(
                                                                        3,
                                                                        "البلد",
                                                                        6,
                                                                        widget.user,
                                                                        widget
                                                                            .country,
                                                                        widget
                                                                            .city),
                                                                    buildText(
                                                                        "", 1),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 35,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    buildText(
                                                                        "المدينة*",
                                                                        2),
                                                                    buildDropdownButton(
                                                                        3,
                                                                        "المدينة",
                                                                        7,
                                                                        widget.user,
                                                                        widget
                                                                            .country,
                                                                        widget
                                                                            .city),
                                                                    buildText(
                                                                        "", 1),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 40,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          Center(
                                                            child: Container(
                                                              width: 100,
                                                              height: 40,
                                                              child: RaisedButton(
                                                                color: ThemeNotifier
                                                                        .mode
                                                                    ? Colors.pink
                                                                        .shade900
                                                                    : Colors
                                                                        .black87,
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        new BorderRadius
                                                                                .circular(
                                                                            30.0)),
                                                                child: Text(
                                                                  "تعديل",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize: 18),
                                                                ),
                                                                onPressed:
                                                                    () async {
                                                                  await updateData_personal(
                                                                      context);
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 40,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                            ));
                                  }));
                                },
                              ),
                              IconButton(
                                  icon: Icon(Icons.share,
                                      size: 25, color: Colors.white),
                                  onPressed: () {})
                            ],
                          )),
                      Positioned(
                        top: 100,
                        right: MediaQuery.of(context).size.width / 2 - 70,
                        child: showDialog_Photo(
                            user: widget.user, docid: widget.docid, num: 0),
                      )
                    ],
                  )),
              Container(
                child: Column(
                  children: [
                    Center(
                        child: Text(
                      "${widget.user.firstName}" +
                          " " +
                          "${widget.user.endName}",
                      style: TextStyle(fontSize: 20),
                    )),
                    Center(
                        child: Text(
                      "-----",
                      style: TextStyle(fontSize: 16),
                    )),
                    Center(
                        child: Text(
                      "${widget.user.selectedCountry}" +
                          " ، " +
                          "${widget.user.selectedCity}",
                      style: TextStyle(fontSize: 16),
                    )),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  height: 150,
                  child: Card(
                    color: ThemeNotifier.mode == true
                        ? Colors.grey.shade100
                        : Colors.grey.shade500,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return Edit_WorkInfo(
                                user: widget.user,
                                docid: widget.docid,
                                country: widget.country);
                          }));
                        },
                        child: ListTile(
                          title: Padding(
                            padding:
                                const EdgeInsets.only(right: 15.0, top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("جاهز للعمل في مجال :"),
                                Divider(),
                                SizedBox(
                                  height: 5,
                                ),
                                Flexible(
                                    child: Text("${widget.user.selectedjob}",
                                        overflow: TextOverflow.fade))
                              ],
                            ),
                          ),
                          trailing: Padding(
                              padding: const EdgeInsets.only(top: 50),
                              child: Icon(Icons.arrow_forward_ios)),
                        ),
                      ),
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Card(
                  color: ThemeNotifier.mode == true
                      ? Colors.grey.shade100
                      : Colors.grey.shade500,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "التعليم ",
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            child: Icon(Icons.edit),
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return Form(
                                    key: formstate3,
                                    child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: Scaffold(
                                          appBar: AppBar(
                                            toolbarHeight: 80,
                                            title: Text(
                                              "تعديل المستوى العلمي ",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            ),
                                            backgroundColor: ThemeNotifier.mode
                                                ? Colors.pink.shade900
                                                : Colors.black87,
                                            centerTitle: true,
                                            leading: InkWell(
                                              child: Icon(Icons.arrow_back),
                                              onTap: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(50),
                                              bottomRight: Radius.circular(50),
                                            )),
                                          ),
                                          body: Center(
                                            child: Container(
                                              width: 320,
                                              child: ListView(
                                                children: [
                                                  SizedBox(
                                                    height: 30,
                                                  ),
                                                  buildCard(
                                                      "حدد مستواك العلمي",
                                                      0,
                                                      "المستوى العلمي",
                                                      8,
                                                      widget.user),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  buildCard(
                                                      "أختر",
                                                      0,
                                                      "المستوى الوظيفي",
                                                      9,
                                                      widget.user),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  buildCard(
                                                      "أختر",
                                                      0,
                                                      "عدد سنوات خبرتك",
                                                      11,
                                                      widget.user),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  buildCard(
                                                      widget.user.Skills ==
                                                              "null"
                                                          ? "true"
                                                          : "false",
                                                      4,
                                                      "المهارات (اختياري) ",
                                                      0,
                                                      widget.user),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  buildCard(
                                                      widget.user.language
                                                                  .length ==
                                                              0
                                                          ? "true"
                                                          : "false",
                                                      2,
                                                      "اللغات ",
                                                      10,
                                                      widget.user),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Center(
                                                    child: Container(
                                                      width: 140,
                                                      height: 40,
                                                      child: RaisedButton(
                                                        color: ThemeNotifier
                                                                .mode
                                                            ? Colors
                                                                .pink.shade900
                                                            : Colors.black87,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                new BorderRadius
                                                                        .circular(
                                                                    30.0)),
                                                        child: Text(
                                                          "تعديل",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 18),
                                                        ),
                                                        onPressed: () async {
                                                          await updateData_seintific(
                                                              context);
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 40,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )));
                              }));
                            },
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(flex: 1, child: Text("")),
                          Expanded(flex: 3, child: Divider()),
                          Expanded(flex: 1, child: Text("")),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 35.0),
                        child: Text(
                          "- " + " " + "${widget.user.selectedEdu}",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 35.0),
                        child: Row(
                          children: [
                            Text(
                              "-  المهارات :  ",
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                                widget.user.Skills == ""
                                    ? "لا يوجد"
                                    : "${widget.user.Skills}",
                                style: TextStyle(fontSize: 16))
                            //     AutoSizeText("-  المهارات :  " +  widget.user.Skills == "" ? "لا يوجد": "${widget.user.Skills}"  , style: TextStyle(fontSize: 16), maxLines: 3,)
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Card(
                  color: ThemeNotifier.mode == true
                      ? Colors.grey.shade100
                      : Colors.grey.shade500,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "معلومات التواصل ",
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            child: Icon(Icons.edit),
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return Form(
                                    key: formstate2,
                                    child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: Scaffold(
                                          appBar: AppBar(
                                            toolbarHeight: 80,
                                            title: Text(
                                              "تعديل معلومات التواصل",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            ),
                                            backgroundColor: ThemeNotifier.mode
                                                ? Colors.pink.shade900
                                                : Colors.black87,
                                            centerTitle: true,
                                            leading: InkWell(
                                              child: Icon(Icons.arrow_back),
                                              onTap: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(50),
                                              bottomRight: Radius.circular(50),
                                            )),
                                          ),
                                          body: Center(
                                            child: Container(
                                              width: 320,
                                              child: ListView(
                                                children: [
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  buildCard(
                                                      'false',
                                                      3,
                                                      "البريد الالكتروني*",
                                                      0,
                                                      widget.user),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  buildCard(
                                                      widget.user.phone ==
                                                              "null"
                                                          ? "true"
                                                          : "false",
                                                      7,
                                                      "رقم الهاتف (اختياري) ",
                                                      0,
                                                      widget.user),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Center(
                                                    child: Container(
                                                      width: 140,
                                                      height: 40,
                                                      child: RaisedButton(
                                                        color: ThemeNotifier
                                                                .mode
                                                            ? Colors
                                                                .pink.shade900
                                                            : Colors.black87,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                new BorderRadius
                                                                        .circular(
                                                                    30.0)),
                                                        child: Text(
                                                          "تعديل",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 18),
                                                        ),
                                                        onPressed: () async {
                                                          await updateData_contact(
                                                              context);
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 40,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        )));
                              }));
                            },
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(flex: 1, child: Text("")),
                          Expanded(flex: 3, child: Divider()),
                          Expanded(flex: 1, child: Text("")),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 35.0),
                        child: Row(
                          children: [
                            Icon(Icons.email),
                            Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "البريد الالكتروني ",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text("${widget.user.mygmail}")
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 35.0),
                        child: Row(
                          children: [
                            Icon(Icons.call),
                            Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "رقم الهاتف ",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(widget.user.phone,
                                      style: TextStyle(fontSize: 16))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        )));
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(10, 100),
        Offset(450, 100),
        ThemeNotifier.mode == true
            ? [Colors.pink.shade900, Colors.grey.shade900]
            : [Colors.grey.shade900, Colors.grey.shade600],
      );
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 250, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
