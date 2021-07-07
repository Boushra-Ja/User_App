import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:b/component/alart.dart';
import 'package:b/helpFunction/buildCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'ProfilePage.dart';

class Edit_SeientificInfo extends StatelessWidget{

  CollectionReference userRef = FirebaseFirestore.instance.collection("users");
  GlobalKey<FormState>formstate = new GlobalKey<FormState>();
  var user , docid ;
  Edit_SeientificInfo({this.user , this.docid});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Directionality(textDirection: TextDirection.rtl, child: Scaffold(

      appBar: AppBar(
        toolbarHeight: 80,
        title : Text("تعديل المستوى العلمي " , style: TextStyle(fontSize: 18 , color: Colors.white),),
        backgroundColor: Colors.pink.shade900,
        centerTitle: true,
        leading: InkWell(child: Icon(Icons.arrow_back ) , onTap: (){
          Navigator.of(context).pop();
        },),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),)),
      ),

      body: Center(
        child: Container(
          width: 320,
          child: Form(
            key: formstate,
            child: ListView(

              children: [
                SizedBox(height: 30,),
                buildCard( "حدد مستواك العلمي", 0 ,"المستوى العلمي" , 8 , user),
                SizedBox(height: 20,),
                buildCard("أختر" , 0, "المستوى الوظيفي", 9 , user),
                SizedBox(height: 20,),
                buildCard("أختر" , 0, "عدد سنوات خبرتك", 11 , user),
                SizedBox(height: 20,),
                buildCard(user.Skills == "null" ? "true" :"false"  , 4, "المهارات (اختياري) ", 0  , user),
                SizedBox(height: 20,),
                Center(
                  child: Container(
                    width: 140,
                    height: 40,
                    child: RaisedButton(
                      color: Colors.pink.shade900,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      child: Text("تعديل" , style: TextStyle(color : Colors.white , fontSize: 18),),
                      onPressed: ()async{
                        await updateData(context);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
  updateData(context)async{
    var formdata = formstate.currentState;
    if (formdata.validate()) {
      showLoading(context);
      formdata.save();
      await userRef.doc(docid).update({
        'scientific_level' : user.selectedEdu ,
        'carrer_level' : user.selectedFun ,
        'experience_year' : user.selectedExpr ,
        'skill' : user.Skills ,
      }).then((value) {
        print('Sucsess');
        Navigator.of(context).pop();

      }).catchError((e) {
        AwesomeDialog(context: context, title: "Error", body: Text('Error'))
          ..show();
      });
    }


  }
}