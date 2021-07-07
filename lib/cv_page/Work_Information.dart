import 'package:b/helpFunction/buildCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../UserInfo.dart';

class workInformation extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<userInfo>(context) ;

    return Column(
      children: [
        SizedBox(height: 10 ,) ,
        buildCard("أختر" , 0, "ما نوع العمل الذي ترغب فيه", 12 , bloc),
        SizedBox(height: 20,),
        buildCard(bloc.workSite == "null" ? "true" :"false"  , 5, "حدد موقع العمل المطلوب", 0 , bloc),
        SizedBox(height: 20,),
        buildCard(bloc.salary == "null" ? "true" :"false" , 6, "حدد الراتب الذي ترغب فيه", 0, bloc ),
        SizedBox(height: 20,),
        Container(
            height: 70,
            width: 400,
            child:  Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.yellow.shade50,
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