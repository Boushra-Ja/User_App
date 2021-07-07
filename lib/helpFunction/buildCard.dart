import 'package:b/helpFunction/buildDropdownButton.dart';
import 'package:b/helpFunction/buildText.dart';
import 'package:b/helpFunction/buildTextFormAll.dart';
import 'package:flutter/material.dart';

import '../UserInfo.dart';
import 'buildMulti_SelectForm.dart';

class buildCard extends StatelessWidget{

  String hinttext , text ;
  int num , _selected;
  userInfo user;
  buildCard(this.hinttext , this.num , this.text , this._selected , this.user) ;
  @override
  Widget build(BuildContext context) {

    return Container(
 //     height: _selected == 10 ? 300 : 150,
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
                Expanded(flex : 1 ,child: buildText("" , 0) ),
                buildTextFormAll(5 , hinttext , num ,user),
                Expanded(flex : 1 ,child: buildText("" , 0)),
              ],
            ) : _selected == 5 ? Row(
              children: [
                buildDropdownButton(1, "اليوم", 1 ,user),
                buildDropdownButton(1, "الشهر", 2 ,user),
                buildDropdownButton(1,"السنة", 3 ,user),
              ],
            ) :
                _selected == 10?
                Row(
                  children: [
                    Expanded(flex : 1 ,child: buildText("" , 0)),
                    build_MultiSelect(8 , hinttext , num),
                    Expanded(flex : 1 ,child: buildText("" , 0)),
                  ],
                ):

            Row(
              children: [
                Expanded(flex : 1 , child: buildText("" , 0)),
                buildDropdownButton(5, hinttext, _selected , user),
                Expanded(flex : 1 , child: buildText("" , 0)),
              ],
            ),
            SizedBox(height: 40,)
          ],
        ),
      ),
    );
  }
}