import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:b/component/Loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class finish_Quiz extends StatefulWidget{
  bool res ;
  String result ;
  var company_Id , chance_Id , user_Id , success_rate , company_name , image;
  finish_Quiz({this.res , this.result , this.company_Id , this.chance_Id , this.user_Id , this.success_rate , this.company_name , this.image});
  @override
  State<StatefulWidget> createState() {
    return finish_QuizState();
  }
}

class finish_QuizState extends State<finish_Quiz>{
  bool loading = true ;
  check_result()async{
    if(widget.res == true)
      {
        await FirebaseFirestore.instance.collection("companies").doc(widget.company_Id).collection('chance').doc(widget.chance_Id).update({
          'Presenting_A_Job' : FieldValue.arrayUnion([widget.user_Id]),
          "quiz_result.${widget.user_Id}": widget.success_rate,
        }).then((value) {
          print('Sucsess');
        }).catchError((e) {
          AwesomeDialog(
              context: context,
              title: "Error",
              body: Text('Error'))
            ..show();
        });
        await FirebaseFirestore.instance
            .collection("users")
            .doc(widget.user_Id).collection('chat').add({
          'comp_id' :  widget.company_Id,
          'help' : 1 ,
          'img' : widget.image,
          'name' : widget.company_name
        });
      }else{
      await FirebaseFirestore.instance.collection("companies").doc(widget.company_Id).collection('chance').doc(widget.chance_Id).update({
        "quiz_result.${widget.user_Id}": widget.success_rate,
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

    setState(() {
      loading = false ;
    });
  }

  @override
  void initState() {
    ()async{
      await check_result();
    }();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Directionality(textDirection: TextDirection.rtl, child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade900,
        toolbarHeight: MediaQuery.of(context).size.height/7,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(70),
              bottomRight: Radius.circular(70),
            )),
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: ListView(
          children: [
            Center(child: Icon( Icons.sentiment_very_satisfied , size: 80,color: Colors.yellow.shade600,)),
            SizedBox(height: 20,),
            Center(child: Text("${widget.result}" , style: TextStyle(fontSize: 18),)),
            SizedBox(height: 20,),
            Center(child: Text(widget.res == true ? "لقد تم التقديم على الفرصة ...." : "عذرا...لم تستطع الحصول على النسبة المطلوبة..يمكنك الاطلاع على صفحة المسارات التعليمية الخاصة بنا لتنمية مهاراتك." ,  style: TextStyle(fontSize: 16))),
            SizedBox(height: 100,),

               Center(
                child: RaisedButton(onPressed: (){
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                  color: Colors.grey.shade700,
                  child: Text("العودة الى الصفحة الاساسية"),
                ),
              ),

          ],
        ),
      ),
    ));
  }
}