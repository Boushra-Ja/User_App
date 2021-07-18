import 'package:b/helpFunction/buildCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../UserInfo.dart';

class contactInformation extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<userInfo>(context) ;

    return Column(
      children: [
        SizedBox(height: 10,),
        buildCard(bloc.mygmail == "null" ? "true" :"false",  3 , "البريد الالكتروني*" , 0  ,bloc ),
        SizedBox(height: 20,),
        buildCard(bloc.phone == "null" ? "true" :"false",  7 , "رقم الهاتف (اختياري) " , 0 ,bloc ),
        SizedBox(height: 20,),

      ],
    );
  }
}