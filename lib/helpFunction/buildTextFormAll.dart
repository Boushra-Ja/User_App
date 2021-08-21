import 'package:b/Home/ThemeManager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../UserInfo.dart';

class buildTextFormAll extends StatelessWidget{

  int flex_ , valid_num ;
  String hintText;
  userInfo bloc ;
  buildTextFormAll(this.flex_ , this.hintText , this.valid_num , this.bloc);
  @override
  Widget build(BuildContext context) {

    return  Expanded(
      flex : flex_  ,
      child: TextFormField(
        keyboardType: valid_num == 3
            ? TextInputType.emailAddress
            : TextInputType.text,
        validator: (val) {
          if (valid_num == 1 || valid_num == 2) {
            if (val.length == 0) return "يجب تعبئة الحقل";
          } else if (valid_num == 3) {
            if (val.length < 11) return "الرجاء ادخال ايميل صحيح";
          }else if(valid_num == 5){
            if(val.length == 0) return "هذا الحقل مطلوب";
          }
          else if(valid_num == 6){
            if(val.length == 0) return "هذا الحقل مطلوب";
          }

          return null;
        },
        onSaved: (val) {
          if (valid_num == 1)
            bloc.set_firstname(val) ;
          else if (valid_num == 2)
            bloc.set_lastname(val);
          else if (valid_num == 3)
            bloc.set_mygmail(val);
          else if(valid_num == 4){
            bloc.set_Skills(val) ;
          }
          else if(valid_num == 5){
            bloc.set_workSite(val) ;
          }
          else if(valid_num == 6){
            bloc.set_salary(val) ;
          }
          else if(valid_num == 7){
            bloc.set_phone(val) ;
          }
        },
        initialValue: this.hintText == "false" ?
        valid_num == 1 ?  bloc.firstName : valid_num == 2 ? bloc.endName : valid_num == 3  ? bloc.mygmail : valid_num == 4 ? bloc.Skills : valid_num == 5 ? bloc.workSite : valid_num == 6 ? bloc.salary : bloc.phone
            : null ,style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            hintText: hintText == "true" ? 'ادخل هنا' : null ,
            hintStyle: TextStyle(
                fontSize: 14, color:Colors.black, fontWeight: FontWeight.w300),
            contentPadding: EdgeInsets.fromLTRB(10.0, 0.01, 20.0, 0.01),
            filled: true,
            fillColor: Colors.white),
      ),
    );
  }

}