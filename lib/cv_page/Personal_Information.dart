import 'package:b/helpFunction/buildCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../UserInfo.dart';

class PersonalInfo extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<userInfo>(context) ;

    return  Column(
      children: [
        SizedBox(
          height: 10,
        ),
        buildCard( bloc.firstName == "null" ? "true" :"false" , 1 ," الاسم الاول*" , 0 , bloc),
        SizedBox(height: 20,),
        buildCard(bloc.endName == "null" ? "true" :"false",  2 ," الاسم الأخير*" , 0  , bloc),
        SizedBox(height: 20,),
        buildCard( "اختر", 0 , "الجنس*" , 4  , bloc),
        SizedBox(height: 20,),
        buildCard('اختر', 0, 'تاريخ الميلاد', 5 , bloc),
        SizedBox(height: 20,)
      ],
    );
  }

}