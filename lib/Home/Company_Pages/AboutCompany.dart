import 'package:flutter/material.dart';

class aboutCompany extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      color: Colors.pink.shade50,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              buildContainer(" حجم الشركة : ", "10 - 20 موظف"),
              buildContainer(" موقع الشركة : ", "المنطقة الفلانية"),
              buildContainer(" التخصص : ", "تكنولوجيا المعلومات "),
              buildContainer(" التخصص : ", "تكنولوجيا المعلومات "),
              buildContainer(" حجم الشركة : ", "10 - 20 موظف"),
              buildContainer(" موقع الشركة : ", "المنطقة الفلانية"),
              buildContainer(" التخصص : ", "تكنولوجيا المعلومات "),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildContainer(String text1, String text2) {
    return Container(
      margin: EdgeInsets.only(top: 30, right: 30),
      child: Row(
        children: [
          Text(
            text1,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(
            width: 20,
          ),
          Text(text2, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
