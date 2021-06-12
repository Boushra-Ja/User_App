import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:b/SettingPage/updatePassword.dart';
import 'package:b/myDrawer/Drawer.dart';

class settingPage extends StatefulWidget {

  final list , docid ;
  const settingPage({Key key, this.list, this.docid}) : super(key: key);

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
    notify = widget.list['notify'] ;
    previcy = widget.list['privecy'] ;
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
      drawer: mydrawer(userInfo: widget.list,docid: widget.docid,),
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
                      return updatePassword(list: widget.list , docid: widget.docid,) ;
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
                SizedBox(height: 40,),

              ],
            ),

          ),
        ],
      ),
    ));
  }
}
