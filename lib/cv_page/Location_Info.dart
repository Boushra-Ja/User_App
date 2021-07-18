import 'package:b/helpFunction/buildDropdownButton.dart';
import 'package:b/helpFunction/buildText.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../UserInfo.dart';

class LocationInfo extends StatelessWidget{

  final country , city ;
  const LocationInfo({Key key, this.country, this.city}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final bloc = Provider.of<userInfo>(context) ;

    return Card(
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
              buildDropdownButton(3, 'اختر', 5 , bloc , country , city),
              buildText( " " , 1),
            ],
          ),
          SizedBox(
            height: 35,
          ),
          Row(
            children: [
              buildText("بلد الإقامة*", 2),
              buildDropdownButton(3, "البلد", 6 ,bloc , country ,city),
              buildText("", 1),
            ],
          ),
          SizedBox(
            height: 35,
          ),
          Row(
            children: [
              buildText("المدينة*", 2),
              buildDropdownButton(3, "المدينة", 7 ,bloc , country , city ),
              buildText("", 1),
            ],
          ),
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}