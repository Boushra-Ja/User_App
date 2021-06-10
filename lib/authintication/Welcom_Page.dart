import 'package:b/authintication/login.dart';
import 'package:b/authintication/signup.dart';
import 'package:flutter/material.dart';

class Welcom extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return WelcomState();
  }
}

class WelcomState extends State<Welcom>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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