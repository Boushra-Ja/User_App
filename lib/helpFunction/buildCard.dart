import 'package:b/Home/ThemeManager.dart';
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
  buildCard(hinttext_ , num_ , text_ , selected_ , user_ ){
    this.hinttext = hinttext_;
    this.num = num_;
    this.text = text_;
    this._selected = selected_;
    this.user = user_;
    print("}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}");
    print(this.num);
  }
  @override
  Widget build(BuildContext context) {

    return Container(
      width: MediaQuery.of(context).size.width - 50,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        color: ThemeNotifier.mode ? Colors.grey.shade100 : Colors.grey.shade500,
        child : Column(
          children: [
            buildText(text , 0 ),
            SizedBox(height: 10,),
            _selected == 0  ? Row(
              children: [
                Expanded(flex : 1 ,child: buildText("" , 0) ),
                buildTextFormAll(5 , hinttext , num ,user) ,
                Expanded(flex : 1 ,child: buildText("" , 0)),
              ],
            ) : _selected == 5 ? Row(
              children: [
                buildDropdownButton(1, "اليوم", 1 ,user ,[] , []),
                buildDropdownButton(1, "الشهر", 2 ,user , [] , []),
                buildDropdownButton(1,"السنة", 3 ,user , [] , []),
              ],
            ) :
                _selected == 10 ?
                Row(
                  children: [
                    Expanded(flex : 1 ,child: buildText("" , 0)),
                    build_MultiSelect(8 , hinttext , num , user),
                    Expanded(flex : 1 ,child: buildText("" , 0)),
                  ],
                ):

            Row(
              children: [
                Expanded(flex : 1 , child: buildText("" , 0)),
                buildDropdownButton(5, hinttext, _selected , user , [] , []),
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