import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:b/component/alart.dart';
import 'package:b/helpFunction/buildCard.dart';
import 'package:b/helpFunction/buildDropdownButton.dart';
import 'package:b/helpFunction/buildText.dart';
import 'package:b/myDrawer/UserProfilePage/ProfilePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Edit_PersonalInfo extends StatelessWidget{

  var user , docid ;
  Edit_PersonalInfo({this.user , this.docid});
  CollectionReference userRef = FirebaseFirestore.instance.collection("users");

  GlobalKey<FormState>formstate = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Directionality(textDirection: TextDirection.rtl, child: Scaffold(

      appBar: AppBar(
        toolbarHeight: 80,
        title : Text("تعديل المعلومات االشخصية " , style: TextStyle(fontSize: 18 , color: Colors.white),),
        backgroundColor: Colors.pink.shade900,
        centerTitle: true,
        leading: InkWell(child: Icon(Icons.arrow_back ) , onTap: (){
          Navigator.of(context).pop();
        },),
      ),
      body: Center(
        child: Container(
          width: 320,
          child: Form(
            key: formstate,
              child: ListView(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  buildCard( 'false', 1 ," الاسم الاول*" , 0 , user , 'profile'),
                  SizedBox(height: 20,),
                  buildCard('false',  2 ," الاسم الأخير*" , 0  , user , 'profile'),
                  SizedBox(height: 20,),
                  buildCard( "اختر", 0 , "الجنس*" , 4 , user , 'profile'),
                  SizedBox(height: 20,),
                  buildCard('اختر', 0, 'تاريخ الميلاد', 5 , user , 'profile'),
                  SizedBox(height: 30,),
                  Card(
                    margin: EdgeInsets.only(bottom: 30 , top: 10),
                    color: Colors.grey.shade100,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          children: [
                            buildText( "الجنسية*" , 2),
                            buildDropdownButton(3, 'اختر', 5 , user ),
                            buildText( " " , 1),
                          ],
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        Row(
                          children: [
                            buildText("بلد الإقامة*", 2),
                            buildDropdownButton(3, "البلد", 6 ,user),
                            buildText("", 1),
                          ],
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        Row(
                          children: [
                            buildText("المدينة*", 2),
                            buildDropdownButton(3, "المدينة", 7 ,user),
                            buildText("", 1),
                          ],
                        ),
                        SizedBox(height: 40,)
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 100,
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
      )
    );
  }
  updateData(context)async{
    var formdata = formstate.currentState;
    if (formdata.validate()) {
      showLoading(context);
      formdata.save();
      await userRef.doc(docid).update({
        'firstname': user.firstName,
        'endname': user.endName,
        'gender': user.selectedGender,
        'date': {
          'day': user.selectedDay,
          'month': user.selectedMonth,
          'year': user.selectedYear
        },
        'Nationality': user.selectedNationality,
        'originalhome': user.selectedCountry,
        'placerecident': user.selectedCity,

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