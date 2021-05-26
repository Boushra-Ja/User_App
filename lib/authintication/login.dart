import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:b/component/alart.dart';

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
        showLoading(context);
        print("***************");
        userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: myemail, password: mypassword);
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Navigator.of(context).pop();
          AwesomeDialog(
              context: context,
              title: "Error",
              body: Text('No user found for that email.'))
            ..show();
        } else if (e.code == 'wrong-password') {
          Navigator.of(context).pop();
          AwesomeDialog(
              context: context,
              title: "Error",
              body: Text('Wrong password provided for that user.'))
            ..show();
        }
      }
    }
  }

  @override
  void initState() {
    changesign = new TapGestureRecognizer()
      ..onTap = () {
        setState(() {
          Navigator.of(context).pushNamed("signup");
        });
      };

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var mdw = MediaQuery.of(context).size.width;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          body: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
              ),
              buildPositioned(mdw),
              Container(
                child: ListView(
                  children: [
                    Center(
                        child: Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Icon(
                              Icons.supervised_user_circle,
                              size: 90,
                              color: Colors.white,
                            ))),
                    Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 3),
                          child: Text(
                            "تسجيل الدخول ",
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        )),
                    Form(
                        key: formeState,
                        child: Container(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  padding: EdgeInsets.all(12),
                                  child: Text(
                                    "البريد الالكتروني ",
                                    style: TextStyle(
                                        fontSize: 22, color: Colors.purple[700]),
                                  )),
                              SizedBox(
                                height: 5,
                              ),
                              buildTextFormAll(false, "  ادخل هنا  ", 0),
                              Container(
                                  padding: EdgeInsets.all(12),
                                  child: Text(
                                    "كلمة المرور ",
                                    style: TextStyle(
                                        fontSize: 22, color: Colors.purple[700]),
                                  )),
                              SizedBox(
                                height: 5,
                              ),
                              buildTextFormAll(true, "  *************   ", 1),
                              SizedBox(
                                height: 15,
                              ),
                              buildRaisedButtom(changesign)
                            ],
                          ),
                        ))
                  ],
                ),
              )
            ],
          )),
    );
  }

  TextFormField buildTextFormAll(
      bool visible,
      String myHintText,
      valid_num,
      ) {
    return TextFormField(
      obscureText: visible,
      validator: (val) {
        if (valid_num == 0) {
          if (val.length > 50) {
            return "Email can't to be larger than 50 letter";
          }
          if (val.length < 2) {
            return "Email can't to be less than 2 letter";
          }
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
      decoration: InputDecoration(
        hintText: myHintText,
        filled: true,
        fillColor: Colors.grey[400].withOpacity(0.1),
        hintStyle: TextStyle(
            fontSize: 20, color: Colors.black, fontWeight: FontWeight.w300),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: EdgeInsets.all(8),
      ),
    );
  }

  Container buildRaisedButtom(TapGestureRecognizer changesign) {
    return Container(
      child: Column(
        children: [
          InkWell(
              onTap: () {},
              child: Text(
                " هل نسيت كلمة السر ؟؟",
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 18,
                    fontWeight: FontWeight.w900),
              )),
          SizedBox(
            height: 10,
          ),
          Center(
              child: Container(
                height: 50,
                width: 170,
                child: RaisedButton(
                  onPressed: () async {
                    var response = await SignIn();
                    if (response != null) {
                      Navigator.of(context).pushNamed("homepage");
                    }
                  },
                  elevation: 10,
                  child: Text(
                    "تسجيل الدخول",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  color: Colors.grey.shade500,
                ),
              )),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: RichText(
              text: TextSpan(children: <TextSpan>[
                TextSpan(
                    text: "مستخدم جديد ل BR_jobs ؟ ",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.deepPurple.shade600,
                        fontWeight: FontWeight.w600)),
                TextSpan(
                    recognizer: changesign,
                    text: " انضم الآن   ",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.red[600],
                        fontWeight: FontWeight.w600)),
              ]),
            ),
          )
        ],
      ),
    );
  }

  Positioned buildPositioned(double mdw) {
    return Positioned(
        child: Transform.scale(
          scale: 1.4,
          child: Transform.translate(
            offset: Offset(0, -190),
            child: Container(
              height: mdw,
              width: mdw,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(mdw / 3),
                  color: Colors.deepPurple.shade600),
            ),
          ),
        ));
  }
}
