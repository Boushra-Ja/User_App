import 'package:flutter/material.dart';

showLoading(context){

  return showDialog(context: context, builder: (context){
    return AlertDialog(
      content :
      Container(height : 50 ,child: Center(child: CircularProgressIndicator())),
    ) ;
  });
}
