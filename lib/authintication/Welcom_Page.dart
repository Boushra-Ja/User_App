import 'package:b/authintication/login.dart';
import 'package:b/authintication/signup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
  addLocation()async{
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
  }
  @override
  Widget build(BuildContext context) {

    return Directionality(textDirection: TextDirection.rtl, child: Scaffold(

        body: Center(
          child: Container(
            width: 200,
            child: ListView(
              children: [
                SizedBox(height: 260,),
                Container(
                  height: 50,
                  width: 170,
                  child:
                  RaisedButton(
                      color: Colors.pink.shade800,
                      child: Text("تسجيل الدخول" , textAlign: TextAlign.center,),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context){
                          return Login();
                        }));
                      }) ,),
                SizedBox(height: 40,),
                Container(
                  height: 50,
                  width: 170,
                  child: RaisedButton(
                      color: Colors.pink.shade50,
                      child: Text("انشاء حساب" , textAlign: TextAlign.center,),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context){
                          return signUp();
                        }));
                      }),
                ),
                SizedBox(height: 100,),


              ],
            ),
          ),
        )
    ));
  }
}