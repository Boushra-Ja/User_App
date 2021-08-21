import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:b/component/Loading.dart';
import 'package:b/cv_page/PersonalPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:b/component/alart.dart';
import 'login.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

class signUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return signupState();
  }
}

class signupState extends State<signUp> {
  TapGestureRecognizer changesign;
  bool showSignIn = true , loading = true;
  var myemail, mypassword, myconfirmPassword;
  GlobalKey<FormState> formeState = new GlobalKey<FormState>();
  var city = {} , country = [];

  get_LocationList()async{
    await FirebaseFirestore.instance.collection("location").doc("Pju9ofIYjWDZF86czL75").get().then((value) {
      country = value.data()['array'];
      print(country);
    });
    await FirebaseFirestore.instance.collection("location").doc("zgmM6DkhtzXh1S4F4Atd").get().then((value) {
      city = value.data()['map'];
      print(city);
    });
  }

  SignUp() async {
    UserCredential userCredential;

    var formdata = formeState.currentState;

    if (formdata.validate()) {
      formdata.save();
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: myemail, password: mypassword);
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          AwesomeDialog(
              context: context,
              title: "Error",
              body: Text('The password provided is too weak.'))
            ..show();
        } else if (e.code == 'email-already-in-use') {
          AwesomeDialog(
              context: context,
              title: "Error",
              body: Text('The account already exists for that email.'))
            ..show();
        }
      } catch (e) {
        AwesomeDialog(context: context, title: "Error", body: Text('Error'))
          ..show();
      }
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    changesign = new TapGestureRecognizer()
      ..onTap = () {
        setState(() {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) {
            return Login();
          }));
        });
      };
    ()async{
      await get_LocationList();
    }();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mdw = MediaQuery.of(context).size.width;

    return Directionality(
      textDirection: TextDirection.rtl,
      child:  Scaffold(
          body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
          ),
          buildPosinted(mdw, -175, 410 , 0),
          buildPosinted(mdw, 0, -220 , 1),
          buildPosinted(100, 60, 200 , 2),
          buildCircularAvatar(mdw),
          Container(
              child: SingleChildScrollView(
                  child: Column(
            children: [

              SizedBox(
                height: 190,
              ),
              buildFormSignUp(mdw),
              SizedBox(
                height: 20,
              ),
              buildRaisedButton(),
              Container(
                margin: EdgeInsets.only(top: 8),
                child: RichText(
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: "لتسجيل الدخول  ",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w600)),
                    TextSpan(
                        recognizer: changesign,
                        text: " اضغط هنا",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.pink,
                            fontWeight: FontWeight.w600)),
                  ]),
                ),
              )
            ],
          ))),
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
            return "لا يمكن أن يكون أكثر من 50 حرف";
          }
          if (val.length == 0) {
            return "يجب تعبئة الحقل";
          }
        } else if (valid_num == 1) {
          if (val.length == 0) {
            return "يجب تعبئة الحقل";
          }
          if (val.length < 6) {
            return "لا يمكن أن تكون كلمة السر أقل من 6 أحرف";
          }
        } else if (valid_num == 2) {
          if (val.length == 0)
            return "يجب تعبئة الحقل";
          else if (val.length < 6) {
            return "لا يمكن أن تكون كلمة السر أقل من 6 أحرف";
          }
        }
        return null;
      },
      onSaved: (val) {
        if (valid_num == 0) {
          myemail = val;
        } else if (valid_num == 1) {
          mypassword = val;
        } else if (valid_num == 2) {
          myconfirmPassword = val;
        }
      },
      decoration: InputDecoration(
        hintText: myHintText,
        filled: true,
        fillColor: Colors.grey.shade50,
        hintStyle: TextStyle(
            fontSize: 14, color: Colors.grey.shade700, fontWeight: FontWeight.w300),
        contentPadding: EdgeInsets.all(5),
      ),
    );
  }

  Positioned buildPosinted(double mdw, double offset_x, double offset_y , index) {
    return Positioned(
        child: Transform.scale(
      scale: 1.4,
      child: Transform.translate(
        offset: Offset(offset_x, offset_y),
        child: Container(
          height: mdw,
          width: mdw,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(mdw),
              gradient: LinearGradient(
                  begin: index == 0 ? Alignment.topRight : index == 1 ?  Alignment.bottomRight : Alignment.topLeft,
                  end: index == 0 ? Alignment.topCenter :index == 1 ? Alignment.bottomLeft :  Alignment.bottomLeft,
                  colors: [
                    Colors.pink.shade900 , Colors.grey.shade900
                  ])),
        ),
      ),
    ));
  }

  Positioned buildCircularAvatar(double mdw) {
    return Positioned(
      right: mdw / 2 - 50,
      top: 75,
      child: Container(
        child: Icon(Icons.person , size: 50 , color: Colors.white,),
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.grey.shade800, Colors.grey.shade500]),
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Center buildFormSignUp(double mdw) {
    return Center(
      child: Container(
          height: 300,
          width: mdw / 1.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
              color: Colors.white, boxShadow: [
            BoxShadow(blurRadius: 2, spreadRadius: 0.1, offset: Offset(1, 1)),
          ]),
          child: Form(
              key: formeState,
              child: Container(
                padding: EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildText("البريد الالكتروني "),
                      buildTextFormAll(false, "  ادخل هنا  ", 0),
                      buildText("كلمة المرور "),
                      buildTextFormAll(true, "  ***********   ", 1),
                      buildText(" تأكيد كلمة المرور"),
                      buildTextFormAll(true, "  ***********   ", 2),
                    ],
                  ),
                ),
              ))),
    );
  }

  GradientButton buildRaisedButton() {
    return GradientButton(
        increaseWidthBy: 90,
        increaseHeightBy: 15,
        elevation: 10,
        child: Text(
          "انشاء الحساب",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        callback: ()async {
          var response = await SignUp();
          if (response != null) {
             Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return personalPage(country : country , city : city);
            }));
          }
        },
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.grey.shade800, Colors.grey.shade500]),
    );

  }

  Container buildText(text) {
    return Container(
        padding: EdgeInsets.all(2),
        child: Text(
          text,
          style: TextStyle(fontSize: 18, color: Colors.pink.shade900),
        ));
  }
}
