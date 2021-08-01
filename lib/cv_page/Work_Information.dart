import 'package:b/helpFunction/buildCard.dart';
import 'package:b/helpFunction/buildDropdownButton.dart';
import 'package:b/helpFunction/buildText.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../UserInfo.dart';

class workInformation extends StatelessWidget{
  var country , city ;
  workInformation({this.country , this.city});

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<userInfo>(context) ;

    return Column(
      children: [
        SizedBox(height: 10 ,) ,
        buildCard("أختر" , 0, "ما نوع العمل الذي ترغب فيه", 12 , bloc ),
        SizedBox(height: 20,),
        buildCard("اختر", 0, "نوع الفرص التي تبحث عنها", 15, bloc),
        SizedBox(height: 20,),
        buildCard(bloc.selectedjob.length == 0 ? "true" :"false" , 1, "ماهي مجالات عملك", 10 , bloc ),
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
                  buildDropdownButton(5, "اختر" , 13 , bloc , country , []),
                  Expanded(flex : 1 , child: buildText("" , 0)),
                ],
              ),
              SizedBox(height: 40,)
            ],
          ))),
        ),
        SizedBox(height: 20,),
        buildCard("اختر" , 0, "حدد الراتب الذي ترغب فيه", 14, bloc ),
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
                    Radio(value: 'yes', groupValue: bloc.previous_job ,onChanged: (val){
                      bloc.set_previous_job(val) ;
                    }) ,
                    Text("نعم" ,style: TextStyle(fontSize: 14 )) ,
                    Radio(value: 'no', groupValue:  bloc.previous_job, onChanged: (val){
                      bloc.set_previous_job(val) ;
                    }) ,
                    Text("لا" ,style: TextStyle(fontSize: 14 ))
                  ],
                )
            )
        ) ,
      ],
    );
  }
}