import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:b/Home/Company_Pages/buildCardForCompany.dart';
import 'package:b/Home/ThemeManager.dart';
import 'package:b/component/Loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'Quiz_Page/quizPage.dart';
import 'package:http/http.dart' as http;


class show extends StatefulWidget{
  var job , docid;
  show(job , Id) {
    this.job=job;
    this.docid = Id ;
  }

  @override
  State<StatefulWidget> createState() {
    return showState();
  }
}

class showState extends State<show> {
  bool check_P = false, loading = true ;
  var title , body ;

  sendNotify()async {
    title =  'تقديم طلب';
    body =  ("تم التقدم على فرصة " + "${widget.job.job_Info['title']}"+ " من قبل المستخدم " + " ${widget.job.user_name}");
    var serverToken = "AAAAUnOn5ZE:APA91bGSkIL6DLpOfbulM_K3Yp5W1mlcp8F0IWu2mcKWloc4eQcF8C230XaHhXBfBYphuyp2P92dc_Js19rBEuU6UqPBGYOSjJfXsBJVmIu9TsLe44jaSOLDAovPTspwePb1gw7-1GNZ";
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': body ,
            'title': title
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          'to': widget.job.company_Info['token'],
        },
      ),
    );


  }

  getMessage()async{
    FirebaseMessaging.onMessage.listen((event) {
      print("++++++++++++++++++++++++++++++");
      print(event.notification.title);
      print(event.notification.body);
    });
  }

  storage_notificatio()async{

    await FirebaseFirestore.instance.collection("companies").doc(widget.job.company_Id).collection("notification").add({
      'body' : body,
      'title' : title ,
      'user_Id' : widget.docid
    });
  }

  check_Presentation()async{
    print(widget.job.job_Info['id']);
    print( widget.docid);
    await FirebaseFirestore.instance.collection("companies").doc(widget.job.company_Id).collection('chance').doc(widget.job.job_Info['id']).get().then((value) async {
      for(int i=0; i < value.data()['Presenting_A_Job'].length ; i++)
        {
          if(value.data()['Presenting_A_Job'][i] == widget.docid)
            {
              setState(() {
                check_P = true ;
              });
              break;
            }
          else{
            setState(() {
              check_P = false ;
            });
          }
        }
      await FirebaseFirestore.instance.collection('users').doc(widget.docid).collection('chance_saved').get().then((doc) {
        if(doc.docs.isNotEmpty){
          for(int j =0 ; j < doc.docs.length ; j++){
            if(doc.docs[j].data()['chance_Id'] == value.data()['id'])
            {
              setState(() {
                widget.job.check_save = true ;
              });
              break;
            }
            else{
              setState(() {
                widget.job.check_save = false ;
              });
            }
          }
        }else{
          setState(() {
            widget.job.check_save = false ;
          });
        }
      });
    });
    setState(() {
      loading = false ;
    });
    }

  @override
  void initState() {
    ()async{
      await check_Presentation();
    }();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    CollectionReference chance_saved = FirebaseFirestore.instance
        .collection("users")
        .doc(widget.docid)
        .collection('chance_saved');
    DocumentReference chance = FirebaseFirestore.instance.collection('companies').doc(widget.job.company_Id).collection('chance').doc(widget.job.job_Info['id']);
    onPressed_Button()async{
      if(check_P == false){

        await chance.get().then((value) async {
          if(value.data()['quiz'] == 0 )
          {
            setState(() {
              check_P = true ;
            });
            await sendNotify();
            storage_notificatio();
            await getMessage();
            chance.update({
              'Presenting_A_Job' : FieldValue.arrayUnion([widget.docid])
            }).then((value) {
              print('Sucsess');
            }).catchError((e) {
              AwesomeDialog(
                  context: context,
                  title: "Error",
                  body: Text('Error'))
                ..show();
            });
          }
          else {
            if(value.data()['quiz_result'].containsKey('${widget.docid}'))
            {
              setState(() {
                check_P = true ;
              });
              await sendNotify();
              storage_notificatio();
              await getMessage();
              chance.update({
                'Presenting_A_Job' : FieldValue.arrayUnion([widget.docid])
              }).then((value) {
                print('Sucsess');
              }).catchError((e) {
                AwesomeDialog(
                    context: context,
                    title: "Error",
                    body: Text('Error'))
                  ..show();
              });


            }else{
              Navigator.of(context).push(MaterialPageRoute(builder: (context){
                return quizPage(company_Id: widget.job.company_Id , chance_Id:widget.job.job_Info['id'] , company_name : widget.job.company_Info['company'] , user_Id : widget.docid );
              }));

            }

          }
        });
      }
      else{
        setState(() {
          check_P = false ;
        });
        await chance.get().then((value) {
          for(int i=0; i < value.data()['Presenting_A_Job'].length ; i++){
            if(value.data()['Presenting_A_Job'][i] == widget.docid)
            {
              var val = []; //blank list for add elements which you want to delete
              val.add('${value.data()['Presenting_A_Job'][i]}');
              chance.update({
                "Presenting_A_Job":
                FieldValue
                    .arrayRemove(
                    val)
              }).then((value) {
                print('Sucsess');
              }).catchError((e) {
                AwesomeDialog(
                    context:
                    context,
                    title: "Error",
                    body: Text(
                        'Error'))
                  ..show();
              });
            }

          }
        });
      }
    }

    return loading ? Loading() : Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: ListView(
            children: [
              Stack(
                children: [

                  Container(
                    width: MediaQuery.of(context).size.width,
                    height:MediaQuery.of(context).size.height/2 - 50,
                    decoration: BoxDecoration(
                      color: ThemeNotifier.mode == true ? Colors.white : Colors.black87,
                    ),
                  ),
                  Positioned(
                    bottom: 2,
                    //left: 1,
                    child: Container(
                      width: MediaQuery.of(context).size.width + 40,
                      height:MediaQuery.of(context).size.height / 2 ,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top : MediaQuery.of(context).size.height / 6 , left: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //Icon(Icons.work_outline , size: 16,color: Colors.white,),
                                //SizedBox(width: 5,),
                                Column(
                                  children: [
                                    Text(widget.job.job_Info['title'] , style: TextStyle(color: Colors.white , fontSize: 20),),
                                    Text("kkk" ,  style: TextStyle(color: Colors.yellow.shade300 , fontSize: 14))
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 30,),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [

                                  Container(
                                    width: 150,
                                    height: 40,
                                    child: Center(child: Text("عدد المتقدمين")),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      color: Colors.grey.shade50
                                    ),
                                  ),
                                 SizedBox(width: 40,),
                                 InkWell(
                                   onTap: (){
                                     onPressed_Button();
                                   },
                                   child: Container(
                                      width: 150,
                                      height: 40,
                                      child: Center(child: Text(check_P == false ? 'تقديم' : "الغاء التقديم")),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(40),
                                          color: Colors.grey.shade50
                                      ),

                                ),
                                 )
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                          Divider(color: Colors.white,),
                          Container(
                            margin: EdgeInsets.only(top : 10),
                            child: Row(
                              children: [
                                Expanded(flex:  1, child : Text("")),
                                Expanded(flex : 4 , child: InkWell(
                                  onTap: (){

                                  },
                                  child: Column(
                                    children: [
                                      Icon(Icons.message , size: 30, color: Colors.white,),
                                      Text("مراسلة" , style: TextStyle(color: Colors.white , fontSize: 12),)
                                    ],
                                  ),
                                ),) ,
                                Expanded(flex : 4 , child: InkWell(
                                  onTap: ()async{
                                    if(widget.job.check_save == false) {
                                      setState(() {
                                        widget.job.check_save = true ;
                                      });
                                      await chance_saved
                                          .add({
                                        'company_Id': widget.job.company_Id,
                                        'chance_Id': widget.job.job_Info['id']
                                      }).then((value) {
                                        print('Sucsess');
                                      }).catchError((e) {
                                        AwesomeDialog(
                                            context:
                                            context,
                                            title: "Error",
                                            body: Text(
                                                'Error'))
                                          ..show();
                                      });
                                    }else{
                                      setState(() {
                                        widget.job.check_save = false ;
                                      });
                                      ////////
                                      await chance_saved.get().then((value) async {
                                        if (value.docs.isNotEmpty) {
                                          for (int j = 0; j < value.docs.length; j++) {

                                            if (value.docs[j].data()['chance_Id'] ==
                                                widget.job.job_Info['id']) {
                                              await chance_saved
                                                  .doc( value.docs[j].id)
                                                  .delete()
                                                  .then((value) {
                                                print("Success!");
                                              });
                                            }
                                          }
                                        }
                                      });
                                    }
                                  },
                                  child: Column(
                                    children: [
                                      Icon(Icons.save , size: 30,color:widget.job.check_save == false? Colors.white : Colors.yellow.shade300,),
                                      Text(widget.job.check_save == false ? "حفظ" : "الغاء الحفظ" , style: TextStyle(color: Colors.white , fontSize: 12),)
                                    ],
                                  ),
                                ), ),
                                Expanded(flex : 4 , child: InkWell(
                                  onTap: (){
                                    share(context);
                                  },
                                  child: Column(
                                    children: [
                                      Icon(Icons.share ,size: 30,color: Colors.white,),
                                      Text("مشاركة" , style: TextStyle(color: Colors.white , fontSize: 12),)

                                    ],
                                  ),
                                ),),
                                Expanded(flex:  1, child : Text("")),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )


                ],
              ),
              SizedBox(height: 20,),

                 Card(
                   shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(20)),
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  shadowColor: Colors.black,
                  elevation: 4,
                  color: ThemeNotifier.mode == true ? Colors.grey.shade50 : Colors.grey.shade300,
                  child: Container(
                    margin: EdgeInsets.only(right: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20,),
                        Center(child: Text("عن الفرصة" , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.w600),)),
                        Row(
                          children: [
                            Expanded(child: Text("") , flex : 1 ),
                        Expanded(child: Divider(color: ThemeNotifier.mode == true ? Colors.grey : Colors.white,) , flex : 5 ),
                   Expanded(child: Text("") , flex : 1 ),

                          ],
                        ),

                        SizedBox(height: 10,),
                        Text("عدد سنوات الخبرة :  " + "${widget.job.job_Info['age']}", style: TextStyle(fontSize: 16)),
                        SizedBox(height: 10,),
                        Text("المستوى العلمي :  " + "${widget.job.job_Info['degree']}", style: TextStyle(fontSize: 16)),
                        SizedBox(height: 10,),
                        Text("عدد ساعات العمل : " + "${widget.job.job_Info['workTime']}" , style: TextStyle(fontSize: 16)),
                        SizedBox(height: 10,),
                        Text("الجنس : " + "${widget.job.job_Info['gender']}", style: TextStyle(fontSize: 16)),
                        SizedBox(height: 20,),

                      ],
                    ),
                  ),
                ),
              SizedBox(height: 40,),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                margin: EdgeInsets.symmetric(horizontal: 10),
                shadowColor: Colors.black,
                elevation: 4,
                color: ThemeNotifier.mode == true ? Colors.grey.shade50 : Colors.grey.shade300,
                child: Container(
                  margin: EdgeInsets.only(right: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20,),
                      Center(child: Text("المهارات المطلوبة" , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.w600),)),
                      Row(
                        children: [
                          Expanded(child: Text("") , flex : 1 ),
                          Expanded(child: Divider(color: ThemeNotifier.mode == true ? Colors.grey : Colors.white,) , flex : 5 ),
                          Expanded(child: Text("") , flex : 1 ),

                        ],
                      ),

                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: AutoSizeText("${widget.job.job_Info['skillNum']} " , style: TextStyle(fontSize: 16)),
                      ),
                      SizedBox(height: 20,),

                    ],
                  ),
                ),
              ),
              SizedBox(height: 40,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(child: Text("معلومات عن الشركة" , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.w600),)),
                  Row(
                    children: [
                      Expanded(child: Text("") , flex : 1 ),
                      Expanded(child: Divider(color: ThemeNotifier.mode == true ? Colors.grey : Colors.white,) , flex : 5 ),
                      Expanded(child: Text("") , flex : 1 ),

                    ],
                  ),
                ],
              ),
              buildCardCompany(list: widget.job.company_Info,company_Id: widget.job.company_Id,user_id: widget.docid,),
              SizedBox(height: 40,),
              Center(
                child:  ElevatedButton(
                      onPressed: () async{
                        onPressed_Button();
                      },
                      child: Text(check_P == false ? 'تقديم' : "الغاء التقديم" , style: TextStyle(fontSize: 18 , color: Colors.white , fontWeight: FontWeight.w600),),
                      style: ElevatedButton.styleFrom(
                        elevation: 4,
                        minimumSize: Size(150.0, 50.0),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        primary: Colors.pink.shade900,
                        onPrimary: Colors.grey,
                        shadowColor: Colors.black,
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(12)
                        ),

                      ),
                    ),
              ),
              SizedBox(height: 40,),

            ],
          )
        ));
  }

  void share(BuildContext context ){
    String txt = "شاغر جديد في تطبيق BR_Jobs" +"\n" + "فرصة خاصة بمجال  " +"${widget.job.job_Info['specialties']}" + "\n"+
        "عدد سنوات الخبرة :  " + "${widget.job.job_Info['age']}"+"\n"+
        "المستوى العلمي :  " + "${widget.job.job_Info['degree']}" + "\n" +
        "عدد ساعات العمل : " + "${widget.job.job_Info['workTime']}" +'\n';
    final RenderBox box = context.findRenderObject();
    final String text = txt;
    Share.share(text ,
      subject: "معلومات الفرصة",
      sharePositionOrigin: box.localToGlobal(Offset.zero)&box.size,
    );
  }
}
