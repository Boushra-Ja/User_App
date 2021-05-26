import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:b/Home/homepage.dart';

import 'SettingPage/setting_page.dart';
import 'authintication/login.dart';
import 'authintication/signup.dart';
import 'cv_page/EditProfile.dart';
import 'cv_page/personal_information.dart';
import 'cv_page/scientific_information.dart';
import 'mainpage.dart';

bool islogin ;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  var user = FirebaseAuth.instance.currentUser ;
  if(user == null)
  {
    islogin = false;
  }else
  {
    islogin = true ;
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Lato' ),
      title: 'Jobs',
      debugShowCheckedModeBanner: false,

      routes:{

        "login": (context) => Login(),
        "homepage" : (context) => MyHomePage() ,
        "signup" : (context) => signUp() ,
        "information"  : (context) => informationPage() ,
        "informationscientific" : (context) => informationScientificPage()

      } ,
      home:  islogin == false ? Login() : MyHomePage() ,
    );
  }
}

