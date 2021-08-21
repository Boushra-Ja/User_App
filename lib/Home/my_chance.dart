import 'package:b/Home/ThemeManager.dart';
import 'package:b/Home/show.dart';
import 'package:b/UserInfo.dart';
import 'package:flutter/material.dart';
import 'show.dart';

class my_chance extends StatelessWidget {
  List m_jobs=[];
  userInfo user ;
  var docid,check;

  my_chance(List my_jobs , userInfo user , docid){
    m_jobs=my_jobs;
    this.user = user;
    this.docid = docid;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child:
        Scaffold(
          body: ListView.builder(
            itemCount: m_jobs.length,
            /////// loop
            itemBuilder: (context, i) {
              return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => show(m_jobs[i] , docid )),
                    );
                  },

                  child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 15 , vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: ThemeNotifier.mode ? <Color>[Colors.black26, Colors.pink.shade800] : <Color>[Colors.black26, Colors.grey.shade600])),
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
                          child: Column(children: [
                            Row(children: [
                              Icon(Icons.account_circle,size: 30,),
                              Text(" ${m_jobs[i].company_Info['region']} ",),
                            ]),

                            Card(
                                margin: EdgeInsets.only(bottom: 20),
                                color: ThemeNotifier.mode == true ? (m_jobs[i].job_Info["chanceId"] == 0 ? Colors.white70 : Colors.grey.shade100).withOpacity(0.7) : Colors.grey.shade400,
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
                                              " ${m_jobs[i].job_Info["title"]} "),
                                          m_jobs[i].job_Info["chanceId"] == 0 ? Text('نوع الفرصة : فرصة عادية ' ) : m_jobs[i].job_Info["chanceId"] == 1 ? Text('نوع الفرصة : فرصة تطوعية') : Text('نوع الفرصة : فرصة تدريب')
                                          ,
                                          Text("ساعات العمل : " + "${m_jobs[i].job_Info["workTime"]}"),
                                          SizedBox(height: 10,)
                                        ],
                                      ),
                                    )
                                  ]),
                                ])),
                          ]))));
            },
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}