import 'package:flutter/material.dart';

class notFound extends StatelessWidget{
  var text , num ;
  notFound({this.text ,this.num});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            width: 3*(MediaQuery.of(context).size.width/4),
            height: MediaQuery.of(context).size.height/3,
            decoration: new BoxDecoration(
              color: Colors.white,
                image: new DecorationImage(
                  image: num == 0 ? new AssetImage("images/img.png") : new AssetImage('images/img2.jpg'),
                  fit: BoxFit.contain,
                )
            )

        ),
        SizedBox(height: 5,),
        Text("لا يوجد "  + text, style: TextStyle(fontSize: 18 , fontWeight: FontWeight.w600),),
        SizedBox(height: 100,),

      ],
    );
  }
}