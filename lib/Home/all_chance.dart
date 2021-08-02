import 'package:b/Home/show.dart';
import 'package:b/UserInfo.dart';
import 'package:b/myDrawer/Drawer.dart';
import 'package:flutter/material.dart';
import 'show.dart';

class all_chance extends StatefulWidget {
  userInfo user;
  var docid;
  List jobs = [];
  List temp=[];

  all_chance(this.jobs,this.temp, this.docid,);

  @override
  State<StatefulWidget> createState() {
    return chance();
  }
}


class chance extends State<all_chance> {
  @override
  Widget build(BuildContext context) {

    print(widget.temp);
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Column(children: <Widget>[
          Container(
            //margin: EdgeInsets.all(5),
            color: Colors.black26,
            height: 60,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  Container( margin: EdgeInsets.all(5),
                    width: 160,
                    height: 40,
                    child: Center(
                      child: DropdownButton<String>(
                        hint: Text('حسب نوع العمل '),
                        items: <String>['دوام كامل', 'دوام جزئي', 'تدريب', 'تطوع'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                        onChanged: (String valu) {
                          setState(() {
                            widget.jobs.clear();
                            for (int i = 0; i < widget.temp.length; i++) {
                              if(widget.temp[i].job_Info['workTime']==valu){
                                widget.jobs.add(widget.temp[i]);   }}});
                        },),),
                    decoration: BoxDecoration(
                        color: Colors.white, borderRadius: BorderRadius.circular(30)),
                  ),
                  ////////////  unfinished
                  Container( margin: EdgeInsets.all(5),
                    width: 160,
                    height: 40,
                    child: Center(
                      child: DropdownButton<String>(
                        hint: Text('حسب المرتب'),
                        items: <String>['أكثر من 1000', 'أكثر من 10000', 'أكثر من 100000', 'أكثر من 1000000'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                        onChanged: (String valu) {
                          setState(() {
                            widget.jobs.clear();
                            for (int i = 0; i < widget.temp.length; i++) {
                              if(widget.temp[i].job_Info['workTime']==valu){
                                widget.jobs.add(widget.temp[i]);   }}});
                        },
                      ),),
                    decoration: BoxDecoration(
                        color: Colors.white, borderRadius: BorderRadius.circular(30)),
                  ),
                  Container( margin: EdgeInsets.all(5),
                    width: 160,
                    height: 40,
                    child: Center(
                      child: DropdownButton<String>(
                        hint: Text('حسب الجنس'),
                        //value: rr,
                        items: <String>['ذكر', 'أنثى'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                        onChanged: (String valu) {
                          setState(() {
                            widget.jobs.clear();
                            for (int i = 0; i < widget.temp.length; i++) {
                              if(widget.temp[i].job_Info['gender']==valu){
                                widget.jobs.add(widget.temp[i]);   }}});
                        },
                        //  value : 1,
                      ),),
                    decoration: BoxDecoration(
                        color: Colors.white, borderRadius: BorderRadius.circular(30)),
                  ),
                  Container( margin: EdgeInsets.all(5),
                    width: 160,
                    height: 40,
                    child: Center(
                      child: DropdownButton<String>(
                        hint: Text('حسب الخبرة'),
                        items: <int>[1, 2, 3, 4].map((int valu) {
                          return DropdownMenuItem<String>(
                            //value: value,
                            child: new Text("$valu ") ,
                          );
                        }).toList(),
                        onChanged: (String valu) {
                          setState(() {
                            widget.jobs.clear();
                            for (int i = 0; i < widget.temp.length; i++) {
                              if(widget.temp[i].job_Info['expir']==valu){
                                widget.jobs.add(widget.temp[i]);   }}});
                        },),),
                    decoration: BoxDecoration(
                        color: Colors.white, borderRadius: BorderRadius.circular(30)),
                  ),
                  Container( margin: EdgeInsets.all(5),
                    width: 180,
                    height: 40,
                    child: Center(
                      child: DropdownButton<String>(
                        hint: Text('حسب مستوى التعليم'),
                        items: <String>[
                          'تعليم ابتدائي',
                          'تعليم اعدادي',
                          'تعليم ثانوي',
                          'شهادة جامعية',
                          'شهادة دبلوم',
                          'شهادة ماجستير',
                          'شهادة دكتوراه',
                          'لا يهم'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                        onChanged: (String valu) {
                          setState(() {
                            widget.jobs.clear();
                            for (int i = 0; i < widget.temp.length; i++) {
                              if(widget.temp[i].job_Info['degree']==valu){
                                widget.jobs.add(widget.temp[i]);   }}});
                        },
                      ),),
                    decoration: BoxDecoration(
                        color: Colors.white, borderRadius: BorderRadius.circular(30)),
                  ),
                  Container( margin: EdgeInsets.all(5),
                    width: 180,
                    height: 40,
                    child: Center(
                      child: DropdownButton<String>(
                        hint: Text('حسب الإختصاص'),
                        items: <String>[
                          'تكنولوجيا المعلومات',
                          'علوم طبيعية',
                          'تدريس',
                          'ترجمة',
                          'تصيم غرافيكي وتحريك',
                          "سكرتاريا",
                          "صحافة",
                          "مديرمشاريع",
                          "محاسبة",
                          "كيمياء ومخابر",
                          "طبيب",
                          "صيدلة وأدوية",
                          "غير ذلك"].map((String value) {
                          return DropdownMenuItem<String>(
                            //value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                        onChanged: (String valu) {
                          setState(() {
                            widget.jobs.clear();
                            for (int i = 0; i < widget.temp.length; i++) {
                              if(widget.temp[i].job_Info['specialties']==valu){
                                widget.jobs.add(widget.temp[i]);   }}});
                        },
                      ),),
                    decoration: BoxDecoration(
                        color: Colors.white, borderRadius: BorderRadius.circular(30)),
                  ),
                ],
              ),
            ),),
          Expanded(
            child: ListView.builder(
              itemCount: widget.jobs.length,
              /////// loop
              itemBuilder: (context, i) {
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => show(
                                widget.jobs[i], widget.docid,)),
                      );
                    },
                    child: Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Colors.black26,
                                  Colors.pink.shade800
                                ])),
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
                            child: Column(children: [
                              Row(children: [
                                Icon(
                                  Icons.account_circle,
                                  size: 30,
                                ),
                                Text(
                                  " ${widget.jobs[i].company_Info['region']} \n",style: new TextStyle(fontWeight: FontWeight.bold,),
                                ),
                              ]),
                              Card(
                                  color: Colors.white70,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(children: [
                                    Row(children: [
                                      Padding(
                                        padding:
                                        EdgeInsets.fromLTRB(20, 10, 20, 5),
                                        child: Text(" الأسم :" +
                                            "${widget.jobs[i].job_Info['title']} \n" +
                                            " الراتب :" +
                                            " ${widget.jobs[i].job_Info['salary']} \n" +
                                            " المهارات :" +
                                            " ${widget.jobs[i].job_Info['skillNum']} \n"),
                                      )
                                    ]),
                                  ])),
                            ]))));
              },
            ), // This trailing comma makes auto-formatting nicer for build methods.
          )
        ]));
  }
}



//  ramayag@gmail.com

//   flutter run -d chrome --web-renderer html
