import 'package:b/Home/all_chance.dart';
import 'package:b/component/Loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";

import '../Info_Job.dart';

class get_All_chance extends StatefulWidget{
  final user_Id ;
  var temp_list;
   get_All_chance({Key key,this.temp_list,this.user_Id}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return get_All_chanceState();
  }
}
class get_All_chanceState extends State<get_All_chance>
{
  CollectionReference jobsref = FirebaseFirestore.instance.collection("companies");
  Info_Job IJ = new Info_Job();
  List All_jobs = [];
  bool loading = true ;

  get_All_data() async {
    var name ;
    await FirebaseFirestore.instance.collection("users").doc(widget.user_Id).get().then((value) {
      if (this.mounted) {
        setState(() {
          name = value.data()['firstname'] + " " + value.data()['endname'];
        });
      }
    });
    await jobsref.get().then((v) async {
      if(v.docs.isNotEmpty){
        ///////for companies
        for(int p =0 ; p <v.docs.length ; p++)
        {
          await jobsref.doc(v.docs[p].id).collection("chance").get().then((value) async {
            if(value.docs.isNotEmpty) {
              /////////for chance
              for(int k = 0 ; k <value.docs.length ; k++) {
                IJ = new Info_Job();
                IJ.company_Info = v.docs[p].data();
                IJ.job_Info = value.docs[k].data();
                IJ.company_Id = v.docs[p].id ;
                IJ.user_name = name ;
                if (this.mounted) {
                  setState(() {
                    All_jobs.add(IJ);
                  });
                }
              }
            }});

        }
      }
    });
    if(this.mounted)
    {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
        ()async{
      await get_All_data() ;
    }();
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : all_chance(All_jobs,widget.temp_list, widget.user_Id ,true);
  }
}