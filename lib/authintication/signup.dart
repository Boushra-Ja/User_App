import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:b/cv_page/PersonalPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:b/component/alart.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'login.dart';

class signUp extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return signupState() ;
  }
}

class signupState extends State<signUp>{

  TapGestureRecognizer changesign ;
  bool showSignIn  = true;
  var myemail , mypassword , myconfirmPassword;
  GlobalKey <FormState> formeState = new GlobalKey<FormState>() ;

  SignUp()async{

    UserCredential userCredential;

    var formdata = formeState.currentState ;

    if(formdata.validate())
    {
      formdata.save();
      try {
        showLoading(context);

        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: myemail,
            password: mypassword);

        return userCredential;

      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Navigator.of(context).pop();
          AwesomeDialog(context: context , title : "Error" , body : Text('The password provided is too weak.'))..show();

        } else if (e.code == 'email-already-in-use') {
          Navigator.of(context).pop();
          AwesomeDialog(context: context , title : "Error" , body : Text('The account already exists for that email.'))..show();
        }
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  void initState() {

    changesign = new TapGestureRecognizer()..onTap = (){
      setState(() {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
          return Login();
        }));
      });
    };

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mdw = MediaQuery.of(context).size.width;

    return   Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          body: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
              ),
              buildPosinted(mdw , -150, 410) ,
              buildPosinted(mdw , 0 , -220) ,
              buildPosinted(100 , 60 , 200) ,
              buildCircularAvatar(mdw) ,
              Container(
                  child: SingleChildScrollView(

                      child: Column(
                        children: [
                          Center(
                            child: Container(
                              margin: EdgeInsets.all(20),
                              child: Text(
                                "",
                                style: TextStyle(
                                    fontSize: 28,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ) ,
                          SizedBox(height: 100,) ,
                          buildFormSignUp(mdw)  ,
                          SizedBox(height: 15,) ,
                          buildRaisedButton() ,
                          Container(margin: EdgeInsets.only(top : 8 ) , child: RichText(
                            text : TextSpan(children: <TextSpan>[
                              TextSpan(text: "لتسجيل الدخول  " , style: TextStyle(fontSize :14 , color: Colors.pink.shade900 , fontWeight: FontWeight.w600)) ,
                              TextSpan(recognizer: changesign , text: " اضغط هنا" , style: TextStyle(fontSize :14 , color: Colors.black , fontWeight: FontWeight.w600)) ,

                            ]

                            ),
                          ),)

                        ],
                      )
                  )),
            ],
          )),
    );
  }

  TextFormField buildTextFormAll(bool visible, String myHintText , valid_num ,) {
    return TextFormField(
      obscureText: visible,
      validator: (val) {
        if(valid_num == 0 )
        {
          if (val.length > 50) {
            return "لا يمكن أن يكون أكثر من 50 حرف";
          }
          if (val.length ==0) {
            return "يجب تعبئة الحقل";
          }
        }
        else if(valid_num == 1)
        {
          if (val.length == 0) {
            return "يجب تعبئة الحقل";
          }
          if (val.length < 6) {
            return "لا يمكن أن تكون كلمة السر أقل من 6 أحرف";
          }
        }
        else if(valid_num == 2)
        {
          if(val.length == 0)
            return "يجب تعبئة الحقل";
          else  if (val.length < 6) {
            return "لا يمكن أن تكون كلمة السر أقل من 6 أحرف";
          }

        }
        return null;

      },
      onSaved: (val) {
        if(valid_num == 0 ){
          myemail = val ;
        }
        else if(valid_num == 1){
          mypassword = val ;
        }
        else if(valid_num == 2)
        {
          myconfirmPassword = val ;
        }
      },
      decoration: InputDecoration(
        hintText: myHintText,
        filled: true,
        fillColor: Colors.deepPurple.shade100.withOpacity(0.1),
        hintStyle: TextStyle(
            fontSize: 16, color: Colors.black, fontWeight: FontWeight.w300),
        contentPadding: EdgeInsets.all(5),
      ),
    );
  }

  Positioned buildPosinted(double mdw , double offset_x , double offset_y )
  {
    return  Positioned(
        child: Transform.scale(
          scale: 1.4,
          child: Transform.translate(
            offset: Offset(offset_x , offset_y),
            child: Container(
              height: mdw,
              width: mdw,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(mdw),
                  color:Colors.pink.shade900
              ),
            ),
          ),
        ));
  }

  Positioned buildCircularAvatar(double mdw)
  {
    return  Positioned(
      right: mdw/2 - 40,
      top : 75,
      child: Container(
        child : CircleAvatar(
            child: Icon(Icons.person , size: 50,color: Colors.white,),
            maxRadius: 40,
            backgroundColor: Colors.grey.shade700
        ),
      ),
    ) ;
  }

  Center buildFormSignUp(double mdw) {
    return Center(
      child: Container(
          height: 300,
          width: mdw / 1.2,
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(blurRadius: 2, spreadRadius: 0.1, offset: Offset(1, 1)),
          ]) ,
          child: Form(
              key: formeState,
              child: Container(
                padding: EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildText("البريد الالكتروني ") ,
                      buildTextFormAll(false, "  ادخل هنا  " , 0 ),
                      buildText( "كلمة المرور ") ,
                      buildTextFormAll(true, "  ***********   " , 1),
                      buildText( " تأكيد كلمة المرور") ,
                      buildTextFormAll(true, "  ***********   " , 2),
                    ],
                  ),
                ),
              ))
      ),
    ) ;
  }

  Container buildRaisedButton(){

    return Container(
      height: 50,
      width: 170,
      child:
      RaisedButton(
        onPressed: ()async {
          var response =  await SignUp() ;
          if(response != null)
          {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
              return personalPage();
            })) ;
          }
          else{
            print('ds');
          }
        },
        elevation: 10,
        child: Text(
          "انشاء الحساب",
          style: TextStyle(
              color: Colors.white, fontSize: 20 ,fontWeight: FontWeight.w600),

        ),
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        color: Colors.grey.shade700,
      ),

    );
  }

  Container buildText(text){
    return  Container(
        padding: EdgeInsets.all(2),
        child: Text( text,
          style: TextStyle(
              fontSize: 20,color:Colors.pink.shade900
          ),
        ));
  }

}

