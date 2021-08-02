import 'package:b/Home/all_chance.dart';
import 'package:b/component/Loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../Info_Job.dart';

class savedJobs extends StatefulWidget {
  var user_Id,temp_list;
  savedJobs({this.user_Id,this.temp_list});

  @override
  State<StatefulWidget> createState() {
    return savedJobsState();
  }
}

class savedJobsState extends State<savedJobs> {
  CollectionReference company =
      FirebaseFirestore.instance.collection('companies');
  bool loading = true;
  Info_Job IJ = new Info_Job();
  var chance_list = [];

  get_chance() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.user_Id)
        .collection("chance_saved")
        .get()
        .then((value) async {
      if (value.docs.isNotEmpty) {
        for (int i = 0; i < value.docs.length; i++) {
          IJ = new Info_Job();
          //////////////get company_Info
          await company
            .doc(value.docs[i].data()['company_Id']).get().then((doc) async {
              IJ.company_Info = doc.data();
              IJ.company_Id = value.docs[i].data()['company_Id'];
              ////////////////get chance Info
              await company
                  .doc(value.docs[i].data()['company_Id'])
                  .collection('chance')
                  .get()
                  .then((val) {
                if (val.docs.isNotEmpty) {
                  for (int k = 0; k < val.docs.length; k++) {
                    if (val.docs[k].id == value.docs[i].data()['chance_Id']) {
                      IJ.job_Info = val.docs[k].data();
                      IJ.check_save = true;
                      setState(() {
                        chance_list.add(IJ);
                      });
                    }
                  }
                }
              });
            });
        }
      }
    });

    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    () async {
      await get_chance();
    }();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : all_chance(chance_list ,widget.temp_list, widget.user_Id ,false);
  }
}
