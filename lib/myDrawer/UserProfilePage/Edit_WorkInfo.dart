import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:b/component/alart.dart';
import 'package:b/helpFunction/buildCard.dart';
import 'package:b/helpFunction/buildDropdownButton.dart';
import 'package:b/helpFunction/buildText.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Edit_WorkInfo extends StatelessWidget{

  CollectionReference userRef = FirebaseFirestore.instance.collection("users");
  GlobalKey<FormState>formstate = new GlobalKey<FormState>();
  var user , docid , country;
  Edit_WorkInfo({this.user , this.docid , this.country});

  @override
  Widget build(BuildContext context) {

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
        SizedBox(height: 30 ,) ,
        buildCard(user.selectedjob.length == 0 ? "true" :"false" , 1 , "ماهي مجالات عملك", 10 , user ),
        SizedBox(height: 20,),
        buildCard("أختر" , 0, "ما نوع العمل الذي ترغب فيه", 12 , user ),
        SizedBox(height: 20,),
        buildCard("اختر", 0, "نوع الفرص التي تبحث عنها", 15, user),
        SizedBox(height: 20,),
        Center(
          child: Container(
              width: MediaQuery.of(context).size.width - 50 ,
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Colors.grey.shade100 ,
                  child : Column(
                    children: [
                      buildText("حدد موقع العمل المطلوب" , 0 ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Expanded(flex : 1 , child: buildText("" , 0)),
                          buildDropdownButton(5, "المدينة"  , 13 , user , country , []),
                          Expanded(flex : 1 , child: buildText("" , 0)),
                        ],
                      ),
                      SizedBox(height: 40,)
                    ],
                  ))),
        ),
       // buildCard( , 5, "حدد موقع العمل المطلوب", 13 , user ),
        SizedBox(height: 20,),
        buildCard(user.salary == "null" ? "true" :"false" , 6, "حدد الراتب الذي ترغب فيه", 0, user  ),
        SizedBox(height: 20,),
        Container(
            height: 70,
            width: MediaQuery.of(context).size.width - 50 ,
            child:  Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.grey.shade100,
                child: Row(
                  children: [
                    Container(padding : EdgeInsets.only(right: 20 ),child: Text("هل سبق أن عملت بشركة" , style: TextStyle(fontSize: 14),)) ,
                    Radio(value: 'yes', groupValue: user.previous_job ,onChanged: (val){
                      user.set_previous_job(val) ;
                    }) ,
                    Text("نعم" ,style: TextStyle(fontSize: 14 )) ,
                    Radio(value: 'no', groupValue:  user.previous_job, onChanged: (val){
                      user.set_previous_job(val) ;
                    }) ,
                    Text("لا" ,style: TextStyle(fontSize: 14 ))
                  ],
                )
            )
        ) ,
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

    ))))

    ));
  }

  updateData(context)async{
    var formdata = formstate.currentState;
    if (formdata.validate()) {
      showLoading(context);
      formdata.save();
      await userRef.doc(docid).update({
        'type_work' : user.selectedTypeJob ,
        'worksite' : user.workSite ,
        'salary' : user.salary,
        'work_field' : user.selectedjob ,
        'previous_job' : user.previous_job ,
        'typechance' : user.typechance

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