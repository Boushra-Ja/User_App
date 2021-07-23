import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:b/Home/Company_Pages/buildCardForCompany.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    CollectionReference chance_saved = FirebaseFirestore.instance
        .collection("users")
        .doc(widget.docid)
        .collection('chance_saved');

    return Directionality(
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
                      color: Colors.white,
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
                            colors: [Colors.pink.shade900, Colors.grey.shade800]),
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
                                    Text(widget.job.job_Info['dateOfPublication'] ,  style: TextStyle(color: Colors.yellow.shade300 , fontSize: 14))
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
                                 Container(
                                    width: 150,
                                    height: 40,
                                    child: Center(child: Text("تقديم")),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        color: Colors.grey.shade50
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

                                      await chance_saved.get().then((value) async {
                                        if (value.docs.isNotEmpty) {
                                          for (int j = 0; j < value.docs.length; j++) {
                                            if (value.docs[j].data()['chance_Id'] ==
                                                widget.job.job_Info['id']) {
                                              chance_saved
                                                  .where("chance_Id",
                                                  isEqualTo: widget.job.job_Info['id'])
                                                  .get()
                                                  .then((value) {
                                                value.docs.forEach((element) {
                                                  chance_saved
                                                      .doc(element.id)
                                                      .delete()
                                                      .then((value) {
                                                    print("Success!");
                                                  });
                                                });
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
                  color: Colors.grey.shade50,
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
                        Expanded(child: Divider() , flex : 5 ),
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
                color: Colors.grey.shade50,
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
                          Expanded(child: Divider() , flex : 5 ),
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
                      Expanded(child: Divider() , flex : 5 ),
                      Expanded(child: Text("") , flex : 1 ),

                    ],
                  ),
                ],
              ),
              buildCardCompany(list: widget.job.company_Info,company_Id: widget.job.company_Id,user_id: widget.docid,),
              SizedBox(height: 40,),
              Center(
                child:  ElevatedButton(
                      onPressed: () {},
                      child: Text('تقديم' , style: TextStyle(fontSize: 18 , color: Colors.white , fontWeight: FontWeight.w600),),
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
}