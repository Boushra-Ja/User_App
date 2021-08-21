import 'package:flutter/material.dart';
import '../ThemeManager.dart';

class EmployeProfile extends StatelessWidget{
  var employe ;
  EmployeProfile({this.employe});
  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl, child: Scaffold(
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height /4,
            width: MediaQuery.of(context).size.width,
            child :Stack(
            children: [
              Positioned(
                child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors:ThemeNotifier.mode == true ? <Color>[
                            Colors.pink.shade900, Colors.grey.shade800
                          ] : <Color>[
                            Colors.grey.shade600,
                            Colors.black87
                          ]
                      ),
                    ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/6
                ),
              ),
              Positioned(
                top: 40,
                right: 20,
                child: CircleAvatar(
                  backgroundColor: employe.imageurl == 'not' ?  Colors.grey.shade600 : null,
                  backgroundImage:employe.imageurl != 'not' ? NetworkImage( employe.imageurl ) : null,
                  radius: 60,
                  child: employe.imageurl == 'not' ? Icon(Icons.person , size: 50,color: Colors.white,) : null,)),

            ],
          ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(right : 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${employe.firstName}"+" " +"${employe.endName}" , style: TextStyle(fontSize: 22),),
                Text("${employe.selectedCountry}" + " , " + "${employe.selectedCity}" , style: TextStyle(fontSize: 16)),
                Text("     ${employe.selectedDay}" + '/'+"${employe.selectedMonth}"+'/'+"${employe.selectedYear}", style: TextStyle(fontSize: 12))
              ],
            ),
          ),
          SizedBox(height: 30,) ,
          Card(
            elevation: 3,
            shadowColor: Colors.black87,
            margin: EdgeInsets.symmetric(horizontal: 20),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30 , horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.school , color: Colors.grey.shade700,size: 20,),
                      SizedBox(width: 5,),
                      Flexible(child: Text("المستوى العلمي : " + " ${employe.selectedEdu}" , style: TextStyle(fontSize: 16))),
                    ],
                  ),
                  SizedBox(height: 30,),
                  Row(
                    children: [
                      Icon(Icons.work , color: Colors.grey.shade700,size: 20),
                      SizedBox(width: 5,),
                      Flexible(child: Text("المستوى الوظيفي : " + " ${employe.selectedFun}" ,style: TextStyle(fontSize: 16))),
                    ],
                  ),
                  SizedBox(height: 30,),
                  Row(
                    children: [
                      Icon(Icons.work , color: Colors.grey.shade700,size: 20),
                      SizedBox(width: 5,),
                      Flexible(child: Text("مجالات العمل : " + " ${employe.selectedjob}" , style: TextStyle(fontSize: 16))),
                    ],
                  ),
                  SizedBox(height: 30,),
                  Row(
                    children: [
                      Icon(Icons.language ,color: Colors.grey.shade700,size: 20),
                      SizedBox(width: 5,),
                      Flexible(child: Text("اللغات : " + "${employe.language}" ,style: TextStyle(fontSize: 16))),
                    ],
                  ),
                  SizedBox(height: 30,),
                  Row(
                    children: [
                      Icon(Icons.favorite ,color: Colors.grey.shade700,size: 20),
                      SizedBox(width: 5,),
                      Flexible(child: Text("المهارات : " + " ${employe.Skills}" , style: TextStyle(fontSize: 16))),
                    ],
                  )

                ],
              ),
            ),
          ),
          SizedBox(height: 30,),
          Card(
            elevation: 3,
            shadowColor: Colors.black87,
            margin: EdgeInsets.symmetric(horizontal: 20),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30 , horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.email , color: Colors.grey.shade700,size: 20,),
                      SizedBox(width: 10,),
                      Flexible(child:Text("البريد الالكتروني : " + "${employe.mygmail}" , style: TextStyle(fontSize: 16)),
                      )
                    ],
                  ),

                ],
              ),
            ),
          ),
          SizedBox(height: 50,),

        ],
      )
    ));
  }
}

