import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:b/authintication/Welcom_Page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:b/SettingPage/updatePassword.dart';
import 'package:b/myDrawer/Drawer.dart';
import '../UserInfo.dart';

class settingPage extends StatefulWidget {

  final  docid ;
  final userInfo user ;
  const settingPage({Key key, this.user, this.docid}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SettingState();
  }
}

class SettingState extends State<settingPage>{
  bool notify , previcy ;

  String choice ;
  CollectionReference userRef = FirebaseFirestore.instance.collection("users");

  UpdateData() async {
    await userRef.doc(widget.docid).update({
      'privecy' :previcy ,
      'notify' : notify
    }).then((value) {
      print('Sucsess');
    }).catchError((e) {
      AwesomeDialog(context: context, title: "Error", body: Text('Error'))
        ..show();
    });
  }
  @override
  void initState() {
    notify = widget.user.notify;
    previcy = widget.user.privecy ;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Directionality(textDirection: TextDirection.rtl, child: Scaffold(

      appBar: AppBar(
        title: Text('الاعدادات' , style: TextStyle(fontSize: 20 , color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.pink.shade900,
      ),
      drawer: mydrawer(user: widget.user,docid: widget.docid,),
      body: Stack(
        children: [
          Container(
              width: double.infinity,
              color: Colors.deepPurple.shade200.withOpacity(0.1) ),
          Container(
            color: Colors.white ,
            margin: EdgeInsets.only(right: 20 , left: 20 , top: 20),
            child: ListView(
              children: [
                Container(padding : EdgeInsets.all(20),child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person_pin) ,
                    Padding(
                      padding: const EdgeInsets.only(right : 8.0),
                      child: Text("خصوصية الصفحة الشخصية" , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.w600),),
                    ),

                  ],
                )) ,

                SwitchListTile(value: previcy, onChanged: (val){
                  setState(() {
                    previcy= val ;
                    UpdateData() ;
                    print(previcy) ;
                  });
                } ,
                  title: Text("هل ترغب أن تطلع الشركات على ملفك الشخصي ؟ "),
                  subtitle: Text("يتيح لك عروض من قبل الشركة" , style: TextStyle(fontSize: 13),),

                ) ,
                SizedBox(height: 10,) ,
                Divider(thickness: 1,) ,
                SwitchListTile(value: notify, onChanged: (val){
                  setState(() {
                    notify = val ;
                    UpdateData() ;
                    print(notify) ;

                  });
                } ,
                  title: Text("تلقي الاشعارات من BR_jobs"),
                  subtitle: Text("يتيح لك معرفة الفرص الجديدة" , style: TextStyle(fontSize: 13),),

                ) ,
                SizedBox(height: 10,) ,
                Divider(thickness: 1,) ,
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                      return updatePassword(user: widget.user , docid: widget.docid,) ;
                    })) ;
                  },
                  child: ListTile(
                    title: Text("تغيير كلمة المرور"),
                    trailing: Icon(Icons.arrow_forward),
                  ),
                ),
                SizedBox(height: 10,) ,
                Divider(thickness: 1,) ,
                Container(
                  margin: EdgeInsets.only(right: 40),
                  child: ListTile(
                    title: Text("اختر لغة التطبيق" ),
                    leading: Icon(Icons.language),

                  ),
                ),
                Row(
                  children: [
                    SizedBox(width: 50,),
                    Radio(value: 'yes', groupValue: choice ,onChanged: (val){
                      setState(() {
                        choice = val ;
                      });
                    }) ,
                    Text("عربي" ,style: TextStyle(fontSize: 14 )) ,
                    SizedBox(width: 30,),
                    Radio(value: 'no', groupValue: choice, onChanged: (val){
                      setState(() {
                        choice = val ;
                      });
                    }) ,
                    Text("انجليزي" ,style: TextStyle(fontSize: 14 )) ,

                  ],
                ),
                SizedBox(height: 10,) ,
                Divider(thickness: 1,) ,
                InkWell(
                  onTap: ()async {
                    AwesomeDialog(
                        useRootNavigator: true,
                      context: context,
                      dialogType: DialogType.QUESTION,
                      animType: AnimType.BOTTOMSLIDE,
                      title: "تأكيد الحذف",
                      desc: "هل أنت متأكد من حذف الحساب ؟ ",
                      btnCancelOnPress: (){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                          return settingPage(user: widget.user,docid: widget.docid);
                        }));
                      },
                        btnCancelColor: Colors.amber.shade200,
                        btnOkColor: Colors.pink.shade800,
                        btnOkText:"تأكيد" ,
                        btnCancelText: "تراجع",
                        buttonsTextStyle: TextStyle(color: Colors.black),

                      btnOkOnPress: ()async{
                        FirebaseFirestore.instance.collection('users').doc(widget.docid).collection('posts_saved').get().then((snapshot) {
                          for (DocumentSnapshot ds in snapshot.docs){
                            ds.reference.delete();
                          }
                        });
                        FirebaseFirestore.instance.collection('users').doc(widget.docid).collection('companies_saved').get().then((snapshot) {
                          for (DocumentSnapshot ds in snapshot.docs){
                            ds.reference.delete();
                          }
                        });
                        await FirebaseFirestore.instance.collection("users").doc(
                            widget.docid).delete();
                        await FirebaseAuth.instance.currentUser.delete();
                        await FirebaseAuth.instance.signOut();
                        Navigator.of(context)
                            .pushReplacement(MaterialPageRoute(builder: (context) {
                          return Welcom();
                        }));
                      }
                    )..show();


                  },
                  child: Container(child: ListTile(
                      title : Text("حذف الحساب"),
                    trailing: Icon(Icons.arrow_forward),
                  ), padding : EdgeInsets.only(right : 10)),
                ),
                Divider(thickness: 1,) ,
                SizedBox(height: 10,),
                Center(child: Text("^_^ BR_Jobs" , style: TextStyle(fontSize: 16 , color: Colors.pink.shade900),),),
                SizedBox(height: 10,),


              ],
            ),

          ),
        ],
      ),
    ));
  }
}
