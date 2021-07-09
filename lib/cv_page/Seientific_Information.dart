import 'package:b/helpFunction/buildCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../UserInfo.dart';

class seientificInformation extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<userInfo>(context) ;

    return Column(
      children: [
        SizedBox(height: 10,),
        buildCard( "حدد مستواك العلمي", 0 ,"المستوى العلمي" , 8 , bloc , 'sign'),
        SizedBox(height: 20,),
        buildCard("أختر" , 0, "المستوى الوظيفي", 9 , bloc , 'sign'),
        SizedBox(height: 20,),
        buildCard(bloc.selectedjob.length == 0 ? "true" :"false" , 0, "ماهي مجالات عملك", 10 , bloc ,'sign'),
        SizedBox(height: 20,),
        buildCard("أختر" , 0, "عدد سنوات خبرتك", 11 , bloc , 'sign'),
        SizedBox(height: 20,),
        buildCard(bloc.Skills == "null" ? "true" :"false"  , 4, "المهارات (اختياري) ", 0  , bloc , 'sign'),
        SizedBox(height: 20,),
      ],
    );
  }
}