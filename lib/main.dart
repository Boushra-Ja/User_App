import 'package:b/authintication/Welcom_Page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:b/Home/homepage.dart';
import 'package:load/load.dart';
import 'package:provider/provider.dart';
import 'UserInfo.dart';
import 'authintication/login.dart';
import 'authintication/signup.dart';

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
  runApp(
      new Directionality(textDirection: TextDirection.rtl, child: MyApp())
  );}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> userInfo()),

      ],
      child: MaterialApp(
          theme: ThemeData(fontFamily: 'Lato' ),
          title: 'Jobs',
          debugShowCheckedModeBanner: false,

          routes:{
            "login": (context) => Login(),
            "homepage" : (context) => MyHomePage() ,
            "signup" : (context) => signUp() ,
          } ,
          home:// islogin == false ? Login() : MyHomePage() ,
          LoadingProvider(
              themeData: LoadingThemeData(),
              loadingWidgetBuilder: (ctx, data) {
                return Center(
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: Container(
                      child: CupertinoActivityIndicator(),
                      color: Colors.pink,
                    ),
                  ),
                );
              },
              child: islogin == false ? Welcom() : MyHomePage()
          )
      ),
    );
  }
}

