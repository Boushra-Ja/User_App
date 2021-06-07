import 'package:b/Home/show.dart';
import 'package:b/myDrawer/Drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'show.dart';



class all_chance extends StatelessWidget {
  List jobs=[];

  all_chance(List all_jobs){
    jobs=all_jobs;
    //print(jobs);
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: ListView.builder(
        itemCount: jobs.length,
        /////// loop
        itemBuilder: (context, i) {
          return GestureDetector(
              onTap: () {
                Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context) => show(jobs[i])),
                );
              },
              child: Card(
                  color: Colors.purple[200],
                  margin: EdgeInsets.all(10),
                  child: Text(" NAME :" +
                      " ${jobs[i]["name_job"]} \n" +
                      " PRICE :" +
                      " ${jobs[i]["price"]} \n" +
                      " SKILL :" +
                      " ${jobs[i]["skill"]} \n")));
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
