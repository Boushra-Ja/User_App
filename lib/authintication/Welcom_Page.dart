import 'package:b/authintication/login.dart';
import 'package:b/authintication/signup.dart';
import 'package:b/helpFunction/ClipPainter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

class Welcom extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return WelcomState();
  }
}

class WelcomState extends State<Welcom>{
  CollectionReference userRef = FirebaseFirestore.instance.collection("location");

  @override
  void initState() {
    super.initState();
  //  addLocation();
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
          ),
          Positioned(
              top: -height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer()),
          Positioned(
              top: height / 4 - 10,
              right: MediaQuery.of(context).size.width - 320,
              child: Container(
                  child: Image.asset(
                    'images/welcom_photo.jpg',
                    width: 285.0,
                    height: 240.0,
                    fit: BoxFit.cover,
                  ))),
          Positioned(
              top: 2*(MediaQuery.of(context).size.height / 3),
              left: 55,
              child: Center(
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        height: 40,
                        width: 250,
                        child: GradientButton(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.pink.shade900, Colors.grey.shade800]),
                            increaseWidthBy: 240,
                            increaseHeightBy: 12,
                            elevation: 10,
                            child: Text(
                              "تسجيل الدخول",
                              textAlign: TextAlign.center,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                            callback: (){
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return Login();
                            },

                            ));
                            }),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        height: 40,
                        width: 250,
                        child: RaisedButton(
                            color: Colors.grey.shade100,
                            child: Text(
                              "انشاء حساب",
                              textAlign: TextAlign.center,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return signUp();
                              }));
                            }),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
              )),
          Positioned(
              top: height - 70,
              right: 280,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.pink.shade900 , Colors.grey.shade900]),
                  shape: BoxShape.circle,
                ),
              ))
        ],
      ),
    );
  }
}

/* addLocation()async{
    await userRef.add(
        {
          'location': {
            'سوريا': {
              '1': "دمشق",
              '2': "حلب",
              '3': "حماة",
              '4': "الحسكة",
              '5': "حمص",
              '6': "دير الزور",
              '7': "درعا",
              '8': "غير ذدلك",
            },
            'العراق': {
              '1': "بغداد",
              '2': "البصرة",
              '3': "القادسية",
              '4': "أربيل",
              '5': "	كربلاء",
              '6': "غير ذدلك",
            },
            'الأردن': {
              '1': "عمان",
              '2': "إربد",
              '3': "البلقاء",
              '4': "مادبا",
              '5': "العقبة",
              '6': "عجلون",
              '7': "غير ذدلك",
            },

          }
        }
    ).then((value) {
      print("sad");
    }).catchError((e){
      print('sd');
    });
  }*/

////marks_as_unr
///lightblub
//////castfor edu
///work
/////busniess
//star
//favorite border
/*GradientCircularProgressIndicator(
  gradient: Gradients.aliHussien,
);*/


/*
GradientButton(
      increaseWidthBy: 240,
      increaseHeightBy: 12,
      elevation: 10,
      child: Text(
        "تسجيل الدخول",
        style: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(30.0),
      ),
      callback: ()async {
        var response = await SignIn();
        if (response != null) {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) {
            return MyHomePage();
          }));
        }
      },
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.pink.shade900, Colors.grey.shade800]),
    )
 */