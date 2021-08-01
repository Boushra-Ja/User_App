import 'package:flutter/material.dart';

class employePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
         margin: EdgeInsets.all(10),
        child: GridView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
          itemCount: 10,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2 , crossAxisSpacing: 20 , mainAxisSpacing: 20 , ),
          itemBuilder: (context , i ){
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,

              ),
              child: ListTile(
                subtitle: Padding(
                  padding: const EdgeInsets.only(bottom : 8.0),
                  child: Column(
                    children: [
                      Text("بشرى أبوحمزة" , textAlign: TextAlign.center,style: TextStyle(fontSize: 16 , fontWeight: FontWeight.w600 , color: Colors.black)),
                      Text("سوريا ، دمشق" ,style: TextStyle(fontSize: 12),)
                    ],
                  ),
                ),
                title:  Container(
                  margin: EdgeInsets.all(10),
                    child: CircleAvatar(backgroundColor: Colors.grey.shade500,radius: 40,child: Icon(Icons.person , size: 50,color: Colors.white,),)),
              ),
            );
          }

        ),
      );}
}