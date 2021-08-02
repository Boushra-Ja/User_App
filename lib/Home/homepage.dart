import 'package:b/Home/roadmaps.dart';
import 'package:b/UserInfo.dart';
import 'package:b/component/Loading.dart';
import 'package:b/myDrawer/Drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  List aaa=[];
  bool loading = true;
  CollectionReference jobsref = FirebaseFirestore.instance.collection("companies");
  CollectionReference jobsre ;
  /////////////////////////////get all data
  get_All_data() async {
    QuerySnapshot respon = await jobsref.get();
    respon.docs.forEach((element) async {
      if (this.mounted) {
        setState(() async {
          // get_over(element.id);
          jobsre =FirebaseFirestore.instance.collection('companies').doc(element.id).collection('chance');
          QuerySnapshot respo = await jobsre.get();
          respo.docs.forEach((element) {
            setState(() {
              if (this.mounted) {
                aaa.add(element.data());
                All_jobs.add(element.data());
                print("all tt "+"${All_jobs.length}");

              }
            });
          }

          );
          print("all data "+"${aaa.length}");

          //  print ("oo//////////////////////ooooo");
          //  print(aaa);



        }
        );

      }


    });

    //print(All_jobs.length);
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
    setState(() {
      loading = false;
    });
  }

  //////////////////////////get maps

  CollectionReference mapref = FirebaseFirestore.instance.collection("roadmaps");

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
  }

  ///////////////////////user Info
  getId() async {
    await FirebaseFirestore.instance
        .collection('users')
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
            //  user.privecy = doc.data()['privecy'];
            //   user.notify = doc.data()['notify'];
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

    print(user.firstName);
  }

  @override
  void initState() {

      () async {
        await getId();
        await get_All_data();
        await get_My_data();
        await get_All_maps();
      }();


    print("&&&&&&&&&&&");
    print(user.selectedjob);
    print(user.mygmail);
    print(user.phone);

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
                                all_chance(aaa,All_jobs,docid),
                                my_chance(My_jobs, user, docid),
                                companyPage(user_id: docid),
                                Refrech_Posts(docid: docid),
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