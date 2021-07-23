import 'package:b/Home/roadmaps.dart';
import 'package:b/UserInfo.dart';
import 'package:b/authintication/Welcom_Page.dart';
import 'package:b/component/Loading.dart';
import 'package:b/myDrawer/Drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Info_Job.dart';
import '../UserInfo.dart';
import 'Company_Pages/Company_Page.dart';
import 'Leatest_New/Refrech_Posts.dart';
import 'my_chance.dart';
import 'all_chance.dart';
import 'package:b/Home/appbar.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var docid;
  userInfo user = new userInfo();
  List All_jobs = [];
  List My_jobs = [];
  List all_map=[];
  bool loading = true;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference jobsref = FirebaseFirestore.instance.collection("companies");
  CollectionReference mapref = FirebaseFirestore.instance.collection("roadmaps");
  Info_Job IJ = new Info_Job();

  /////////////////////////////get all data
  get_All_data() async {
    QuerySnapshot respon = await jobsref.get();
    respon.docs.forEach((element) async {
      if (this.mounted) {
        await jobsref.doc(element.id).collection("chance").get().then((value) async {
          if(value.docs.isNotEmpty) {
            for(int k = 0 ; k <value.docs.length ; k++) {
              IJ = new Info_Job();
              /////////////check if chance is saved
              await users.doc(docid).collection('chance_saved').get().then((doc) {
                if(doc.docs.isNotEmpty){
                  for(int i =0 ; i < doc.docs.length ; i++){
                    if(doc.docs[i].data()['chance_Id'] == value.docs[k].id)
                      {
                        setState(() {
                          IJ.check_save = true ;
                        });
                        break;
                      }
                    else{
                      setState(() {
                        IJ.check_save = false ;
                      });
                    }
                  }
                }
              });
              IJ.company_Info = element.data();
              IJ.job_Info = value.docs[k].data();
              IJ.company_Id = element.id ;
              setState(() {
                All_jobs.add(IJ);
              });
            }
          }
        });
      }
    });
  }

  /////////////////////////////get my chance
  get_My_data() async {
    await jobsref.where("degree", isEqualTo: "اعدادي").get().then((value) => {
          value.docs.forEach((element) {
            if (this.mounted) {
              setState(() {
                My_jobs.add(element.data());
              });
            }
          })
        });
    print(My_jobs.length);

  }

  //////////////////////////get maps


  /////////////////////////////get all data
  get_All_maps() async {
    QuerySnapshot respon_map = await mapref.get();
    respon_map.docs.forEach((element) {
      if (this.mounted) {
        setState(() {
          all_map.add(element.data());
        });
      }
    });
    print(all_map.length);
    setState(() {
      loading = false;
    });
  }

  ///////////////////////user Info
  getId() async {
    await users
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc['uid'] == FirebaseAuth.instance.currentUser.uid) {
          setState(() {
            user.firstName = doc.data()['firstname'];
            print("*******************");
            print(doc.data()['firstname']);
            user.endName = doc.data()['endname'];
            user.selectedGender = doc.data()['gender'];
            user.selectedDay = doc.data()['date']['day'];
            user.selectedMonth = doc.data()['date']['month'];
            user.selectedYear = doc.data()['date']['year'];
            user.selectedNationality = doc.data()['Nationality'];
            user.selectedCountry = doc.data()['originalhome'];
            user.selectedCity = doc.data()['placerecident'];
            user.imageurl = doc.data()['imageurl'];
            user.privecy = doc.data()['privecy'];
            user.notify = doc.data()['notify'];
            user.selectedEdu = doc.data()['scientific_level'];
            user.selectedFun = doc.data()['carrer_level'];
            user.selectedjob = doc.data()['work_field'];
            user.selectedExpr = doc.data()['experience_year'];
            user.previous_job = doc.data()['previous_job'];
            user.Skills = doc.data()['skill'];
            user.selectedTypeJob = doc.data()['type_work'];
            user.workSite = doc.data()['worksite'];
            user.salary = doc.data()['salary'];
            user.mygmail = doc.data()['gmail'];
            user.phone = doc.data()['phone'];
            docid = doc.id;
          });
        }
      });
    });
  }

  @override
  void initState() {

      () async {
        await getId();
        await get_All_data();
        //await get_My_data();
        await get_All_maps();
      }();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: DefaultTabController(
                length: 5,
                child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Scaffold(
                      appBar: myappbar(),
                      drawer: mydrawer(
                        user: user,
                        docid: docid,
                      ),
                      body: loading
                          ? Loading()
                          : TabBarView(
                              children: [
                                all_chance(All_jobs , docid),
                                my_chance(My_jobs, user, docid),
                                companyPage(user_id: docid),
                                Refrech_Posts(docid: docid),
                                ////////////// Rama add roadmaps ^_^      //////  done  😍
                               roadmaps(all_map),
                              ],
                            ),
                    )))));
  }
}


/*
    onTap: () {
                      GestureDetector(onTap:() async  =>{
                      await canLaunch(url) ? await launch(url) : throw 'noooo'
                  },);
                }

                var url = 'https://flutter.io';

                      },*/