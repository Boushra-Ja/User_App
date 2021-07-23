import 'package:b/Home/show.dart';
import 'package:flutter/material.dart';
import 'show.dart';

class all_chance extends StatelessWidget {
  var jobs = [] , user_Id;
  all_chance(var all_jobs , docid) {
    jobs = all_jobs;
    user_Id = docid ;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: ListView.builder(
            itemCount: jobs.length,
            /////// loop
            itemBuilder: (context, i) {
              return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => show(jobs[i] , user_Id)),
                    );
                  },
                  child: Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [Colors.black26, Colors.pink.shade800])),
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
                          child: Column(children: [
                            Row(children: [
                              Icon(
                                Icons.account_circle,
                                size: 30,
                              ),
                              Text(
                                " العنوان ",
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
                                          "${jobs[i].job_Info['title']} \n" +
                                          " الراتب :" +
                                          " ${jobs[i].job_Info['salary']} \n" +
                                          " المهارات :" +
                                          " ${jobs[i].job_Info['skillNum']} \n"),
                                    )
                                  ]),
                                ])),
                          ]))));
            },
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}
