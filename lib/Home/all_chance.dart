import 'package:b/Home/show.dart';
import 'package:b/component/notFoundPage.dart';
import 'package:b/cv_page/Work_Information.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'ThemeManager.dart';
import 'show.dart';

// ignore: must_be_immutable
class all_chance extends StatefulWidget {
  var docid, check;
  List jobs = [];
  List temp = [];

  all_chance(this.jobs, this.temp, this.docid, this.check);

  @override
  State<StatefulWidget> createState() {
    return chance();
  }
}

class chance extends State<all_chance> {
  int kk=0;
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: widget.check == true
            ? Column(children: <Widget>[
          Container(
            color: ThemeNotifier.mode == true ? Colors.grey.shade300 : Colors.grey.shade800,
            height: 60,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  Container(
                    margin: EdgeInsets.all(5),
                    width: 160,
                    height: 40,
                    child: Center(
                        child: InkWell(
                          child: Text('الكل' ,style: TextStyle(color: ThemeNotifier.mode==true ? Colors.grey.shade700 : Colors.white),),
                          onTap: () =>  setState(() {
                            widget.jobs.clear();
                            for (int i = 0; i < widget.temp.length; i++) {
                              widget.jobs.add(widget.temp[i]);
                            }
                          }),)
                    ),
                    decoration: BoxDecoration(
                        color: ThemeNotifier.mode == true ? Colors.white : Colors.grey,
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    width: 160,
                    height: 40,
                    child: Center(
                      child: DropdownButton<String>(
                        hint: Text('حسب نوع العمل ' , style: TextStyle(color: ThemeNotifier.mode==true ? Colors.grey.shade700 : Colors.white),),
                        items: <String>[
                          'دوام كامل',
                          'دوام جزئي',
                          'تدريب',
                          'تطوع'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                        onChanged: (String valu) {
                          setState(() {
                            widget.jobs.clear();
                            for (int i = 0; i < widget.temp.length; i++) {
                              if (widget.temp[i].job_Info['workTime'] ==
                                  valu) {
                                widget.jobs.add(widget.temp[i]);
                              }
                            }
                          });
                        },
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: ThemeNotifier.mode == true ? Colors.white : Colors.grey,
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    width: 200,
                    height: 40,
                    child: Center(
                      child: DropdownButton<String>(
                        hint: Text('حسب المرتب' , style: TextStyle(color: ThemeNotifier.mode==true ? Colors.grey.shade700 : Colors.white),),
                        items: <String>[
                          'أقل من 100000', "100000 - 300000", "300000 - 500000", "500000 - 700000", "700000 - 1000000", "1000000 - 1500000", "1500000 - 2000000", "أكبر من ذلك"
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                        onChanged: (String valu) {
                          setState(() {
                            widget.jobs.clear();
                            for (int i = 0; i < widget.temp.length; i++) {
                              if (widget.temp[i].job_Info['salary'] ==
                                  valu) {
                                widget.jobs.add(widget.temp[i]);
                              }
                            }
                          });
                        },
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: ThemeNotifier.mode == true ? Colors.white : Colors.grey,
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    width: 160,
                    height: 40,
                    child: Center(
                      child: DropdownButton<String>(
                        hint: Text('حسب الجنس' ,style: TextStyle(color: ThemeNotifier.mode==true ? Colors.grey.shade700 : Colors.white),),
                        items:
                        <String>['ذكر', 'أنثى','لا يهم'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                        onChanged: (String valu) {
                          setState(() {
                            widget.jobs.clear();
                            for (int i = 0; i < widget.temp.length; i++) {
                              if (widget.temp[i].job_Info['gender'] ==
                                  valu) {
                                widget.jobs.add(widget.temp[i]);
                              }
                            }
                          });
                        },
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: ThemeNotifier.mode == true ? Colors.white : Colors.grey,
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    width: 160,
                    height: 40,
                    child: Center(
                      child: DropdownButton<String>(
                        hint: Text('حسب سنوات الخبرة' , style: TextStyle(color: ThemeNotifier.mode==true ? Colors.grey.shade700 : Colors.white),),
                        items: <String>[ '1',
                          '2',
                          '3',
                          '4',
                          '5',
                          '6',
                          '7',
                          '8',
                          'اكثر من ذلك'].map((String valu) {
                          return DropdownMenuItem<String>(
                            value: valu,
                            child: new Text("$valu "),
                          );
                        }).toList(),
                        onChanged: (String valu) {
                          setState(() {
                            widget.jobs.clear();
                            for (int i = 0; i < widget.temp.length; i++) {
                              if (widget.temp[i].job_Info['expir'] ==
                                  valu) {
                                widget.jobs.add(widget.temp[i]);
                              }}});
                        },
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: ThemeNotifier.mode == true ? Colors.white : Colors.grey,
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    width: 180,
                    height: 40,
                    child: Center(
                      child: DropdownButton<String>(
                        hint: Text('حسب مستوى التعليم' , style: TextStyle(color: ThemeNotifier.mode==true ? Colors.grey.shade700 : Colors.white),),
                        items: <String>[
                          'تعليم ابتدائي',
                          'تعليم اعدادي',
                          'تعليم ثانوي',
                          'شهادة جامعية',
                          'شهادة دبلوم',
                          'شهادة ماجستير',
                          'شهادة دكتوراه',
                          'لا يهم'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                        onChanged: (String valu) {
                          setState(() {
                            widget.jobs.clear();
                            for (int i = 0; i < widget.temp.length; i++) {
                              if (widget.temp[i].job_Info['degree'] ==
                                  valu) {
                                widget.jobs.add(widget.temp[i]);
                              }
                            }
                          });
                        },
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: ThemeNotifier.mode == true ? Colors.white : Colors.grey,
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    width: 180,
                    height: 40,
                    child: Center(
                      child: DropdownButton<String>(
                        hint: Text('حسب الخبرة العملية' , style: TextStyle(color: ThemeNotifier.mode==true ? Colors.grey.shade700 : Colors.white),),
                        items: <String>[
                          'مبتدأ',
                          'متمرس',
                          'خبير'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                        onChanged: (String valu) {
                          setState(() {
                            widget.jobs.clear();
                            for (int i = 0; i < widget.temp.length; i++) {
                              if (widget.temp[i].job_Info['level'] ==
                                  valu) {
                                widget.jobs.add(widget.temp[i]);
                              }
                            }
                          });
                        },




                      ),
                    ),
                    decoration: BoxDecoration(
                        color: ThemeNotifier.mode == true ? Colors.white : Colors.grey,
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    width: 160,
                    height: 40,
                    child: Center(
                      child: DropdownButton<String>(
                        hint: Text('حسب نوع الفرص' , style: TextStyle(color: ThemeNotifier.mode==true ? Colors.grey.shade700 : Colors.white),),
                        items: <String>[
                          'فرص عادية',
                          'فرص تطوعية',
                          'فرص تدريب',
                        ].map((String valu) {
                          return DropdownMenuItem<String>(
                            value: valu,
                            child: new Text("$valu "),
                          );
                        }).toList(),
                        onChanged: (String valu) {
                          setState(() {
                            widget.jobs.clear();
                            for (int i = 0; i < widget.temp.length; i++) {
                              if (widget.temp[i].job_Info['chanceId'] == 0 && valu =='فرص عادية') {
                                widget.jobs.add(widget.temp[i]);
                              }
                              if (widget.temp[i].job_Info['chanceId'] == 1 && valu =='فرص تطوعية') {
                                widget.jobs.add(widget.temp[i]);
                              }
                              if (widget.temp[i].job_Info['chanceId'] == 2 && valu =='فرص تدريبية') {
                                widget.jobs.add(widget.temp[i]);
                              }
                            }});
                        },
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: ThemeNotifier.mode == true ? Colors.white : Colors.grey,
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ],
              ),
            ),
          ),
          Expanded(child: widget.jobs.length == 0 ? Container(
              width: MediaQuery.of(context).size.width,
              color: ThemeNotifier.mode ? Colors.white : Colors.grey.shade800,
              child: notFound(text : "فرص بهذه الشروط" , num : 0)) : buildListView())

        ])
            : widget.jobs.length == 0
            ? Container(child: notFound(text : "فرص متاحة" , num : 0),
            width: MediaQuery.of(context).size.width,
            color: ThemeNotifier.mode ? Colors.white : Colors.grey.shade800,
        )
            : buildListView());
  }

  buildListView(){
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: widget.jobs.length,
      /////// loop
      itemBuilder: (context, i) {
        return widget.jobs.length != 0 ? GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        show(widget.jobs[i], widget.docid)),
              );
            },
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15 , vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors:ThemeNotifier.mode ?<Color>[Colors.black26, Colors.pink.shade800] : <Color>[Colors.black26, Colors.grey.shade600])),
                child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
                    child: Column(children: [
                      Row(children: [
                        Icon(
                          Icons.location_on,
                          size: 20,
                        ),
                        Text(
                          "${widget.jobs[i].company_Info['region']}",
                        ),
                      ]),
                      Card(
                        margin: EdgeInsets.only(bottom: 20),
                          color: ThemeNotifier.mode == true ? (widget.jobs[i].job_Info["chanceId"] == 0 ? Colors.white70 : Colors.grey.shade100).withOpacity(0.7) : Colors.grey.shade400,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(20)),
                          child: Column(children: [
                            Row(children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    20, 10, 20, 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10,),
                                    Text("المسمى الوظيفي : " +
                                        " ${widget.jobs[i].job_Info["title"]} "),
                                    widget.jobs[i].job_Info["chanceId"] == 0 ? Text('نوع الفرصة : فرصة عادية ' ) : widget.jobs[i].job_Info["chanceId"] == 1 ? Text('نوع الفرصة : فرصة تطوعية') : Text('نوع الفرصة : فرصة تدريب')
                                       ,
                                       Text("ساعات العمل : " + "${widget.jobs[i].job_Info["workTime"]}"),
                                       SizedBox(height: 10,)
                                  ],
                                ),
                              )
                            ]),
                          ])),
                    ])))) : Container(
          width: MediaQuery.of(context).size.width,
          color: ThemeNotifier.mode ? Colors.white : Colors.grey.shade800,
          child: notFound(text: "فرص بهذه الشروط",),
        );
      },
    );
  }

}

/*
UpdateData(var token) async {
    await userRef.doc(widget.docid).update({
      'notify' : notify,
      'token': token
    }).then((value) {
      print('Sucsess');
    }).catchError((e) {
      AwesomeDialog(context: context, title: "Error", body: Text('Error'))
        ..show();
    });
  }
  UpdateData2() async {
    await userRef.doc(widget.docid).update({
      'privecy' :previcy ,
    }).then((value) {
      print('Sucsess');
    }).catchError((e) {
      AwesomeDialog(context: context, title: "Error", body: Text('Error'))
        ..show();
    });
  }
 */