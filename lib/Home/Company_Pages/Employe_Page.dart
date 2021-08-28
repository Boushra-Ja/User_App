import 'package:b/Home/ThemeManager.dart';
import 'package:b/component/notFoundPage.dart';
import 'package:flutter/material.dart';
import 'Employe_Profile.dart';

class employePage extends StatelessWidget{
  var employe_List ;
  employePage({this.employe_List});

  @override
  Widget build(BuildContext context) {
    return employe_List.length == 0 ? notFound(text : "موظفين" ,num : 0) : Container(
         margin: EdgeInsets.all(10),
        child: GridView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
          itemCount: employe_List.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2 , crossAxisSpacing: 20 , mainAxisSpacing: 20 , ),
          itemBuilder: (context , i ){
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color:ThemeNotifier.mode==true ? Colors.white : Colors.grey.shade700,

              ),
              child: ListTile(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return EmployeProfile(employe : employe_List[i]);
                  }));
                },
                subtitle: Padding(
                  padding: const EdgeInsets.only(bottom : 8.0),
                  child: Column(
                    children: [
                      Text("${employe_List[i].firstName}" + " ${employe_List[i].endName}" , textAlign: TextAlign.center,style: TextStyle(fontSize: 16 , fontWeight: FontWeight.w600 , color: ThemeNotifier.mode == true ?Colors.black : Colors.white)),
                      Text("${employe_List[i].selectedCountry}" + " , " + "${employe_List[i].selectedCity}",style: TextStyle(fontSize: 12),)
                    ],
                  ),
                ),
                title:  Container(
                  margin: EdgeInsets.all(10),
                    child: CircleAvatar(
                      backgroundColor: employe_List[i].imageurl == 'not' ?  Colors.grey.shade500 : null,
                      backgroundImage:employe_List[i].imageurl != 'not' ? NetworkImage( employe_List[i].imageurl ) : null,
                      radius: 40,
                      child: employe_List[i].imageurl == 'not' ? Icon(Icons.person , size: 50,color: Colors.white,) : null,)),
              ),
            );
          }

        ),
      );}
}