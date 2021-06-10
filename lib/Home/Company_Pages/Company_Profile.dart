import 'package:flutter/material.dart';

class companyProfile extends StatefulWidget{

  final list ;

  const companyProfile({Key key, this.list}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return profileState();
  }
}

class profileState extends State<companyProfile>{

  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl, child: Scaffold(

      body: Center(child: Text("${widget.list['name_job']}")),
    ));
  }
}