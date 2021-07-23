import 'package:flutter/material.dart';

showLoading(context){

  return showDialog(context: context, builder: (context){
    return AlertDialog(
      title: Center(child: Text("جاري التحميل")),
      titleTextStyle: TextStyle(fontSize: 14 , color: Colors.pink.shade900),
      contentPadding: EdgeInsets.all(10),
      content :
      Container(
          height : 40 ,width : 5 ,child: Center(child: CircularProgressIndicator(backgroundColor: Colors.pink.shade800, strokeWidth: 4,))),
    ) ;
  });
}
