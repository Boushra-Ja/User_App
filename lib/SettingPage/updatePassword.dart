import 'package:b/Home/ThemeManager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:b/SettingPage/setting_page.dart';

import '../UserInfo.dart';

class updatePassword extends StatefulWidget {
  final docid;
  final userInfo user;
  const updatePassword({Key key, this.user, this.docid}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return updateState();
  }
}

class updateState extends State<updatePassword> {

  var pass_old , pass_new ;
  GlobalKey<FormState> formeState = new GlobalKey<FormState>();


  void _changePassword(String password) async{
    User user = await FirebaseAuth.instance.currentUser;
    user.updatePassword(password).then((_){
      print("Successfully changed password");
    }).catchError((error){
      print("Password can't be changed" + error.toString());
      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: ThemeNotifier.mode ? Colors.pink.shade900 : Colors.black87,
            leading: InkWell(
              child: Icon(
                Icons.arrow_back_ios,
                size: 20,
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return settingPage(
                    user: widget.user,
                    docid: widget.docid,
                  );
                }));
              },
            ),
          ),
          body: Container(
              margin: EdgeInsets.all(20),
              child: Form(
                key: formeState,
                child: Column(
                  children: [
                    buildTextForm("كلمة المرور القديمة", 0),
                    SizedBox(
                      height: 20,
                    ),
                    buildTextForm("كلمة المرور ألجديدة", 1),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 150,
                      child: RaisedButton(
                          onPressed: () async {
                            var formdata = formeState.currentState;
                            formdata.save();
                            _changePassword(pass_new);

                          },
                          elevation: 10,
                          child: Text(
                            "تغيير",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0)),
                          color: ThemeNotifier.mode ? Colors.pink.shade900.withOpacity(0.8) : Colors.black87),
                    )
                  ],
                ),
              )),
        ));
  }

  TextFormField buildTextForm(hintText, num) {
    return TextFormField(
      onSaved: (val){
        if(num == 0)
          pass_old = val;
        else
          pass_new = val ;
      },
      decoration: InputDecoration(
        prefixIcon: num == 1 ? Icon(Icons.lock) : Icon(Icons.vpn_key_outlined),
        hintText: hintText,
        hintStyle: TextStyle(
            fontSize: 18,
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w300),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),

      ),
    );
  }
}
