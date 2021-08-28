import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:b/Home/ThemeManager.dart';
import 'package:b/authintication/Welcom_Page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:b/SettingPage/updatePassword.dart';
import 'package:b/myDrawer/Drawer.dart';
import '../UserInfo.dart';
import 'package:http/http.dart' as http;


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
  String choice ,owner_token ;
  CollectionReference userRef = FirebaseFirestore.instance.collection("users");
  CollectionReference company = FirebaseFirestore.instance.collection('companies');

  UpdateData() async {
    await userRef.doc(widget.docid).update({
      'privecy' :previcy ,
      'notify' : notify,
    }).then((value) {
      print('Sucsess');
    }).catchError((e) {
      AwesomeDialog(context: context, title: "Error", body: Text('Error'))
        ..show();
    });
  }

  @override
  void initState() {
    ()async{
      await FirebaseFirestore.instance.collection('oner').doc('DPi7T09bNPJGI0lBRqx4').get().then((value) {
        owner_token = value.data()['token'];
      });
    }();
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
        backgroundColor:ThemeNotifier.mode ?  Colors.pink.shade900 : Colors.black87,
      ),
      drawer: mydrawer(user: widget.user,docid: widget.docid,),
      body: Stack(
        children: [
          Container(
              width: double.infinity,
              color: Colors.deepPurple.shade200.withOpacity(0.1) ),
          Container(
            color:ThemeNotifier.mode ?  Colors.white : Colors.grey.shade600,
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
                  activeColor: Colors.blue,

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
                  activeColor: Colors.blue,

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
                    Radio(activeColor: Colors.blue,value: 'yes', groupValue: choice ,onChanged: (val){
                      setState(() {
                        choice = val ;
                      });
                    }) ,
                    Text("عربي" ,style: TextStyle(fontSize: 14 )) ,
                    SizedBox(width: 30,),
                    Radio(activeColor: Colors.blue ,value: 'no', groupValue: choice, onChanged: (val){
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
                        FirebaseFirestore.instance.collection('users').doc(widget.docid).collection('companies_saved').get().then((snapshot) {
                          for (DocumentSnapshot ds in snapshot.docs){
                            ds.reference.delete();
                          }
                        });
                        FirebaseFirestore.instance.collection('users').doc(widget.docid).collection('companies_saved').get().then((snapshot) {
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
                        sendNotify('اشعار حذف' ,   "قام المستخدم " + "${widget.user.firstName} " + "${widget.user.endName}  " +" بحذف الحساب الخاص به");
                        storage_notificatio('اشعار حذف', "قام المستخدم " + "${widget.user.firstName} " + "${widget.user.endName}  " +" بحذف الحساب الخاص به");
                        delete_user(widget.docid);
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
                Center(child: Text("^_^ BR_Jobs" , style: TextStyle(fontSize: 16 , color: ThemeNotifier.mode ? Colors.pink.shade900 : Colors.black87),),),
                SizedBox(height: 10,),

              ],
            ),

          ),
        ],
      ),
    ));
  }
  sendNotify(String title , String body)async {

    var serverToken = "AAAAUnOn5ZE:APA91bGSkIL6DLpOfbulM_K3Yp5W1mlcp8F0IWu2mcKWloc4eQcF8C230XaHhXBfBYphuyp2P92dc_Js19rBEuU6UqPBGYOSjJfXsBJVmIu9TsLe44jaSOLDAovPTspwePb1gw7-1GNZ";
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': body,
            'title': title
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'num' : "1",
            'id' : widget.docid,
            'type' : "1"

          },
          'to':await owner_token  ,
        },
      ),
    );


  }

  storage_notificatio(String title , String body)async{

    await FirebaseFirestore.instance.collection('oner').doc("DPi7T09bNPJGI0lBRqx4").collection("reports").add({
      'body' : body,
      'title' : title ,
      'id' : widget.docid,
      'date_publication' : {
        'day' : DateTime.now().day,
        'month' : DateTime.now().month,
        'year' : DateTime.now().year,
        'hour' :  DateTime.now().hour
      },
      'num': 1 ,
      "date": Timestamp.now(),
      'type' : 1
    });
  }

  delete_user(var user_Id)async{
    //////delete user from chance
    var num_Presenting_A_Job , accept , all_accept;
    List comp_id = [];
    await company
        .get()
        .then((value) {
      if(value.docs.isNotEmpty){
        value.docs.forEach((element) {
          comp_id.add(element.id);
        });
      }
    });
    for(int j = 0 ; j < comp_id.length ; j++)
    {
      //all_accepted
      ///////////////////////////////
      await company.doc(comp_id[j]).get().then((value) {
        all_accept = value.data()['all_accepted'].length;

        for (int i = 0;
        i < all_accept;
        i++) {
          if (value.data()[
          'all_accepted']
          [i] ==
              user_Id) {
            var val =
            []; //blank list for add elements which you want to delete
            val.add(
                '${value.data()['all_accepted'][i]}');
            company
                .doc(comp_id[j])
                .update({
              "all_accepted":
              FieldValue
                  .arrayRemove(
                  val)
            }).then((value) {
              print('Sucsess');
            }).catchError((e) {
              print("errroee");
            });
          }

        }
      });
      ///////////////////////////////////////
      await company.doc(comp_id[j]).collection('chance').get().then((value) {
        if(value.docs.isNotEmpty){
          for(int k =0 ; k < value.docs.length ; k++)
          {
            num_Presenting_A_Job = value.docs[k]
                .data()['Presenting_A_Job']
                .length;

            for (int i = 0;
            i < num_Presenting_A_Job;
            i++) {
              if (value.docs[k].data()[
              'Presenting_A_Job']
              [i] ==
                  user_Id) {
                var val =
                []; //blank list for add elements which you want to delete
                val.add(
                    '${value.docs[k].data()['Presenting_A_Job'][i]}');
                company
                    .doc(comp_id[j]).collection('chance').doc(value.docs[k].id)
                    .update({
                  "Presenting_A_Job":
                  FieldValue
                      .arrayRemove(
                      val)
                }).then((value) {
                  print('Sucsess');
                }).catchError((e) {
                  print("errroee");
                });
              }

            }
            /////////////////////////////////////
            accept = value.docs[k]
                .data()['accepted']
                .length;

            for (int i = 0;
            i < accept;
            i++){
              if (value.docs[k].data()[
              'accepted'][i] ==
                  user_Id){
                var val2 =
                []; //blank list for add elements which you want to delete
                val2.add(
                    '${value.docs[k].data()['accepted'][i]}');
                company
                    .doc(comp_id[j]).collection('chance').doc(value.docs[k].id)
                    .update({
                  "accepted":
                  FieldValue
                      .arrayRemove(
                      val2)
                }).then((value) {
                  print('Sucsess');
                }).catchError((e) {
                  print("errroee");
                });
              }
            }

          }
        }
      });
    }
  }

}
