import 'package:b/Home/homepage.dart';
import 'package:b/authintication/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:b/component/alart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return loginState();
  }
}

class loginState extends State<Login> {
  var myemail, mypassword;
  TapGestureRecognizer changesign;
  bool showSignIn = true;
  GlobalKey<FormState> formeState = new GlobalKey<FormState>();

  SignIn() async {
    UserCredential userCredential;
    var formdata = formeState.currentState;

    if (formdata.validate()) {
      formdata.save();

      try {
        userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: myemail, password: mypassword);
        showLoading(context);
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          AwesomeDialog(
              context: context,
              title: "Error",
              body: Text('No user found for that email.'))
            ..show();
        } else if (e.code == 'wrong-password') {
          AwesomeDialog(
              context: context,
              title: "Error",
              body: Text('Wrong password provided for that user.'))
            ..show();
        }
      }
    }
  }

  Future<UserCredential> SignInWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  void initState() {

    changesign = new TapGestureRecognizer()
      ..onTap = () {
        setState(() {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) {
            return signUp();
          }));
        });
      };

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: Stack(
            children: [
              ClipPath(
                clipper: WaveClipperOne(),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.topLeft,
                          colors: [
                        Colors.grey.shade900,
                        Colors.pink.shade900
                      ])),
                  height: 160,
                  child: Center(
                      child: Icon(
                    Icons.supervised_user_circle,
                    size: 80,
                    color: Colors.white,
                  )),
                ),
              ),
              Positioned(
                  child: Transform.scale(
                      scale: 1.4,
                      child: Transform.translate(
                          offset: Offset(0, 410),
                          child: ClipPath(
                            clipper: WaveClipperTwo(
                              reverse: true,
                            ),
                            child: Container(
                              height: 120,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.center,
                                      colors: [
                                        Colors.grey.shade900,
                                        Colors.pink.shade900
                                  ])),
                            ),
                          )))),
              buildPositionedShape(400.0, 50.0, 440.0, 200, 200),
              Container(
                child: Form(
                    key: formeState,
                    child: ListView(
                      children: [
                        SizedBox(height: 180),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: buildTextFormAll(
                              false, "اسم المستخدم", 0, Colors.grey.shade100),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: buildTextFormAll(
                              true, "كلمة المرور", 1, Colors.grey.shade100),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: buildRaisedButton(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Center(
                            child: Container(
                              child: RichText(
                                text: TextSpan(children: <TextSpan>[
                                  TextSpan(
                                      text: "مستخدم جديد للتطبيق ؟ ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600)),
                                  TextSpan(
                                      recognizer: changesign,
                                      text: " انضم الآن   ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.pink,
                                          fontWeight: FontWeight.w600)),
                                ]),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 4,
                                  child: Divider(
                                    thickness: 1,
                                  )),
                              Expanded(flex: 1, child: Text("   أو  ")),
                              Expanded(
                                  flex: 4,
                                  child: Divider(
                                    thickness: 1,
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Center(
                          child: InkWell(
                            child: CircleAvatar(
                              backgroundColor: Colors.grey.shade200,
                              radius: 25,
                              backgroundImage: AssetImage(
                                "images/google.jpg",
                              ),
                            ),
                            onTap: () async {
                              showLoading(context);
                              var response = await SignInWithGoogle();
                              if (response != null) {
                                print("***********");
                                Navigator.of(context).pushNamed("homepage");
                              } else {
                                print('dsdssd');
                              }
                            },
                          ),
                        )
                      ],
                    )),
              ),
            ],
          ),
        ));
  }

  Positioned buildPositionedShape(double mdw, double offset_x, double offset_y,
      double height_, double width_) {
    return Positioned(
        child: Transform.scale(
      scale: 1.4,
      child: Transform.translate(
        offset: Offset(offset_x, offset_y),
        child: Container(
          height: height_,
          width: width_,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topCenter,
                colors: [
                  Colors.pink.shade900 , Colors.grey.shade900]),
            borderRadius: BorderRadius.circular(mdw / 4),
          ),
        ),
      ),
    ));
  }

  TextFormField buildTextFormAll(
      bool visible, String myHintText, valid_num, var color) {
    return TextFormField(
      validator: (val) {
        if (valid_num == 0) {
          if (val.length > 50) {
            return "الاسم طويل جدا :(";
          }
          if (val.length == 0) {
            return "هذا الحقل مطلوب";
          }
        } else {
          if (val.length == 0) return "هذا الحقل مطلوب";
        }
        return null;
      },
      onSaved: (val) {
        if (valid_num == 0) {
          myemail = val;
        } else if (valid_num == 1) {
          mypassword = val;
        }
      },
      obscureText: visible,
      decoration: InputDecoration(
        hintText: myHintText,
        filled: true,
        fillColor: color,
        hintStyle: TextStyle(
          fontSize: 18,
          color: Colors.grey.shade800,
          fontWeight: FontWeight.w300,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        contentPadding: EdgeInsets.fromLTRB(40.0, 0.01, 40.0, 0.01),
      ),
    );
  }

  GradientButton buildRaisedButton() {
    return GradientButton(
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
    );

  }

}
