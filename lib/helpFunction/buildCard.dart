import 'package:b/helpFunction/buildDropdownButton.dart';
import 'package:b/helpFunction/buildText.dart';
import 'package:b/helpFunction/buildTextFormAll.dart';
import 'package:flutter/material.dart';

class buildCard extends StatelessWidget{

  String hinttext , text ;
  int num , _selected;
  buildCard(this.hinttext , this.num , this.text , this._selected) ;
  @override
  Widget build(BuildContext context) {

    return Container(
      height: 150,
      width: 440,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        color: Colors.yellow.shade50,
        child : Column(
          children: [
            buildText(text , 0 ),
            SizedBox(height: 10,),
            _selected == 0  ? Row(
              children: [
                Expanded(flex : 1 ,child: buildText("" , 0)),
                buildTextFormAll(5 , hinttext , num),
                Expanded(flex : 1 ,child: buildText("" , 0)),
              ],
            ) : _selected == 5 ? Row(
              children: [
                buildDropdownButton(1, "اليوم", 1),
                buildDropdownButton(1, "الشهر", 2),
                buildDropdownButton(1,"السنة", 3),
              ],
            ) :
            Row(
              children: [
                Expanded(flex : 1 , child: buildText("" , 0)),
                buildDropdownButton(5, hinttext, _selected ),
                Expanded(flex : 1 , child: buildText("" , 0)),
              ],
            )
          ],
        ),
      ),
    );
  }
}