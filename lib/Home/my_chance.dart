import 'package:b/Home/show.dart';
import 'package:b/myDrawer/Drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'show.dart';



class my_chance extends StatelessWidget {
  List m_jobs=[];

  my_chance(List my_jobs){
    m_jobs=my_jobs;
    //print(jobs);
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: ListView.builder(
        itemCount: m_jobs.length,
        /////// loop
        itemBuilder: (context, i) {
          return GestureDetector(
              onTap: () {
                Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context) => show(m_jobs[i])),
                );
              },
              child: Card(
                  color: Colors.purple[200],
                  margin: EdgeInsets.all(10),
                  child: Text(" NAME :" +
                      " ${m_jobs[i]["name_job"]} \n" +
                      " PRICE :" +
                      " ${m_jobs[i]["price"]} \n" +
                      " SKILL :" +
                      " ${m_jobs[i]["skill"]} \n")));
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
