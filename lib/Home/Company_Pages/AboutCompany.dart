import 'package:b/Home/ThemeManager.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class aboutCompany extends StatelessWidget {
  final list;

  const aboutCompany({Key key, this.list}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        color: ThemeNotifier.mode == true ? Colors.pink.shade50 : Colors.grey.shade800,
        height: 500,
        child: Card(
          color: ThemeNotifier.mode == true ? Colors.white : Colors.grey.shade600,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                buildContainer(
                    " حجم الشركة : ", "${list['size_company']}", context),
                buildContainer(" موقع الشركة : ",
                    "${list['region']} ، ${list['city']}", context),
                buildContainer(
                    " التخصص : ", "${list['specialization']}", context),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: buildContainer(" الوصف : ", "${list['description']} ", context),
                ),
                buildContainer(" رقم الشركة : ", "${list['phone']}", context),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ));
  }

  Container buildContainer(String text1, String text2, context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 30, right: 30),
      child: AutoSizeText(
       text1 + " : " + text2,
          style: TextStyle(fontSize: 16),)
    );
  }
}
