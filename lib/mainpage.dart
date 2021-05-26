import 'package:flutter/material.dart';

class mainPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return mainState();
  }
}

class mainState extends State<mainPage>{

  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl, child: Scaffold(

      appBar: AppBar(title: Text("Jobs ", ) ,
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),

      body: Center(
        child: Column(

          children: [
            SizedBox(height: 20 ,) ,
            Text("أهلا بك في تطبيقنا ^_^" , style: TextStyle(fontSize: 25 , fontWeight: FontWeight.w600  ),) ,
            SizedBox(height: 20,) ,
            Text("هل تود الدخول الى التبيق ك ") ,
            SizedBox(height: 40,) ,
            Row(
              children: [
                Container(
                  margin:EdgeInsets.only(right: 40),
                  child: RaisedButton(onPressed: (){
                    Navigator.of(context).pushNamed("login") ;
                  },
                      child : Text("مستخدم")
                  ),
                ) ,
                SizedBox(width: 50,) ,
                Container(
                  margin:EdgeInsets.only(right: 40),
                  child: RaisedButton(onPressed: (){},
                      child : Text("شركة")
                  ),
                ) ,

              ],
            )
          ],
        ),
      ),
    )) ;
  }

}