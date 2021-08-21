import 'package:b/Home/ThemeManager.dart';
import 'package:b/helpFunction/showDialoge_photo.dart';
import 'package:b/myDrawer/UserProfilePage/Edit_SeientificInfo.dart';
import 'package:b/myDrawer/UserProfilePage/Edit_WorkInfo.dart';
import 'package:flutter/material.dart';
import '../../UserInfo.dart';
import 'Edit_ContactInfo.dart';
import 'Edit_PersonalInfo.dart';
import 'dart:ui' as ui;

class userProfile extends StatefulWidget {
  final docid , country , city;
  final userInfo user ;

  const userProfile({Key key, this.user ,this.docid ,this.country , this.city}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return userProfileState();
  }
}

class userProfileState extends State<userProfile> {
  bool check1 = true, check2 = false, check3 = false, check4 = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl, child: Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            Container(
              height:250 ,
              child: Stack(
                children: [
                  CustomPaint(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                    ),
                    painter: HeaderCurvedContainer(),
                  ),
                 Container(
                   margin: EdgeInsets.all(15),
                     child:
                     InkWell(child: Icon(Icons.arrow_back , size: 25, color: Colors.white, ) , onTap: (){
                       Navigator.of(context).pop();
                     },)
                 ),
                  Positioned(
                    top : 5 ,
                      right: MediaQuery.of(context).size.width - 100,
                      child:
                      Row(
                        children: [
                          IconButton(icon : Icon(Icons.edit , size: 25) , color: Colors.white, onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context){
                                return Edit_PersonalInfo(user : widget.user , docid : widget.docid , country : widget.country , city : widget.city);
                              })
                            );
                          },),
                          IconButton(icon: Icon(Icons.share , size: 25, color: Colors.white), onPressed: (){})
                        ],
                      )
                  ),
                Positioned(
                  top: 100,
                  right: MediaQuery.of(context).size.width/2 - 70 ,
                  child: showDialog_Photo(user: widget.user, docid: widget.docid , num : 0)
                  ,
                )
                ],
              )
            ),
            Container(
              child: Column(
                children: [
                  Center(child: Text("${widget.user.firstName }" + " " +"${widget.user.endName}", style: TextStyle(fontSize: 20),)),
                  Center(child: Text("-----" , style: TextStyle(fontSize: 16),)),
                  Center(child: Text( "${widget.user.selectedCountry }" + " ، " + "${widget.user.selectedCity }", style: TextStyle(fontSize: 16),)),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Container(
              height: 150,
              child: Card(
                color:ThemeNotifier.mode == true ? Colors.grey.shade100 : Colors.grey.shade500,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                child: Center(
                  child: InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        return Edit_WorkInfo(user : widget.user , docid: widget.docid , country : widget.country);
                      }));
                    },
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.only(right :15.0 ,  top : 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("جاهز للعمل في مجال :" ),
                           Divider(),
                           SizedBox(height: 5,),
                           Flexible(child: Text("${widget.user.selectedjob}" , overflow: TextOverflow.fade))
                       ],
                          ),

                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.only(top : 50),
                        child: Icon(Icons.arrow_forward_ios)

                      ),
                    ),
                  ),
                ),
              )
            ),
            SizedBox(height: 20,),
            Container(
             child: Card(
               color: ThemeNotifier.mode == true ? Colors.grey.shade100 : Colors.grey.shade500,
               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     SizedBox(height: 20,),
                     Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Text("التعليم " , style: TextStyle(fontSize: 16),),
                           SizedBox(width: 20,),
                           InkWell(child: Icon(Icons.edit) , onTap: (){
                             Navigator.of(context).push(MaterialPageRoute(builder: (context){
                               return Edit_SeientificInfo(user : widget.user , docid: widget.docid);
                             }));
                           },)
                         ],
                       ),
                     Row(
                       children: [
                         Expanded(flex : 1 , child: Text("")),
                         Expanded(flex : 3 , child: Divider()),
                         Expanded(flex : 1 , child: Text("")),

                       ],
                     ),
                     SizedBox(height: 20,),
                     Padding(
                       padding: const EdgeInsets.only(right : 35.0),
                       child: Text("- " + " " + "${widget.user.selectedEdu}" , style: TextStyle(fontSize: 16),),
                     ),
                     SizedBox(height: 10,),
                     Padding(
                       padding: const EdgeInsets.only(right : 35.0),
                       child: Row(
                         children: [
                           Text("-  المهارات :  " , style: TextStyle(fontSize: 16),),
                           Text(widget.user.Skills == "" ? "لا يوجد": "${widget.user.Skills}" , style: TextStyle(fontSize: 16))
                           //     AutoSizeText("-  المهارات :  " +  widget.user.Skills == "" ? "لا يوجد": "${widget.user.Skills}"  , style: TextStyle(fontSize: 16), maxLines: 3,)
                         ],
                       ),
                     ),
                     SizedBox(height: 30,),


                   ],
               ),
             ),
            ),
            SizedBox(height: 20,),
            Container(
              child: Card(
                color: ThemeNotifier.mode == true ? Colors.grey.shade100 : Colors.grey.shade500,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("معلومات التواصل " , style: TextStyle(fontSize: 16),),
                        SizedBox(width: 20,),
                        InkWell(child: Icon(Icons.edit) , onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context){
                            return Edit_ContactInfo(user : widget.user , docid: widget.docid);
                          }));
                        },)
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(flex : 1 , child: Text("")),
                        Expanded(flex : 3 , child: Divider()),
                        Expanded(flex : 1 , child: Text("")),

                      ],
                    ),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.only(right : 35.0),
                      child: Row(
                        children: [
                          Icon(Icons.email) ,
                          Padding(
                            padding: const EdgeInsets.only(right : 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("البريد الالكتروني " , style: TextStyle(fontSize: 16),),
                                Text("${widget.user.mygmail}")
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.only(right : 35.0),
                      child: Row(
                        children: [
                          Icon(Icons.call) ,
                          Padding(
                            padding: const EdgeInsets.only(right : 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("رقم الهاتف " , style: TextStyle(fontSize: 16),),
                                Text(widget.user.phone , style: TextStyle(fontSize: 16))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30,),


                  ],
                ),
              ),
            ),
            SizedBox(height: 30,),

          ],
        ),
      )

    ));
  }
}
class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint().. shader = ui.Gradient.linear(
      Offset(10 , 100),
      Offset(450 , 100),
      ThemeNotifier.mode == true ? [
        Colors.pink.shade900 ,Colors.grey.shade900
      ] : [
        Colors.grey.shade900 ,Colors.grey.shade600
      ],
    )
    ;
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 250, size.width  , 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
