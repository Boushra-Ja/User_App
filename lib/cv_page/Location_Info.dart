import 'package:b/helpFunction/buildDropdownButton.dart';
import 'package:b/helpFunction/buildText.dart';
import 'package:flutter/material.dart';

class LocationInfo extends StatelessWidget{

  GlobalKey<FormState>formState = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 30 , top: 10),
      color: Colors.yellow.shade50,
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
              buildDropdownButton(3, 'اختر', 5 ),
              buildText( " " , 1),
            ],
          ),
          SizedBox(
            height: 35,
          ),
          Row(
            children: [
              buildText("بلد الإقامة*", 2),
              buildDropdownButton(3, "البلد", 6 ),
              buildText("", 1),
            ],
          ),
          SizedBox(
            height: 35,
          ),
          Row(
            children: [
              buildText("المدينة*", 2),
              buildDropdownButton(3, "المدينة", 7 ),
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