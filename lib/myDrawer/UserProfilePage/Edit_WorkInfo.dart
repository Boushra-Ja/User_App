import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:b/component/alart.dart';
import 'package:b/helpFunction/buildCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'ProfilePage.dart';

class Edit_WorkInfo extends StatelessWidget{

  CollectionReference userRef = FirebaseFirestore.instance.collection("users");
  GlobalKey<FormState>formstate = new GlobalKey<FormState>();
  var user , docid ;
  Edit_WorkInfo({this.user , this.docid});

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
        buildCard(user.selectedjob.length == 0 ? "true" :"false" , 0, "ماهي مجالات عملك", 10 , user , 'profile'),
        SizedBox(height: 20,),
        buildCard("أختر" , 0, "ما نوع العمل الذي ترغب فيه", 12 , user , 'profile'),
        SizedBox(height: 20,),
        buildCard(user.workSite == "null" ? "true" :"false"  , 5, "حدد موقع العمل المطلوب", 0 , user , 'profile'),
        SizedBox(height: 20,),
        buildCard(user.salary == "null" ? "true" :"false" , 6, "حدد الراتب الذي ترغب فيه", 0, user , 'profile' ),
        SizedBox(height: 20,),
        Container(
            height: 70,
            width: 400,
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