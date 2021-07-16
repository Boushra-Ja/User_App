import 'package:b/UserInfo.dart';
import 'package:b/myDrawer/Drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../UserInfo.dart';
import 'Company_Pages/Company_Page.dart';
import 'Leatest_New/Company_Publication.dart';
import 'my_chance.dart';
import 'all_chance.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var docid;
  userInfo user = new userInfo();
  List All_jobs = [];
  List My_jobs = [];
  List companies_follow_Id = [],
      companies_post = [],
      company_name = [],
      num_follwers = [];

  CollectionReference jobsref = FirebaseFirestore.instance.collection("jobs");

  CollectionReference company =
      FirebaseFirestore.instance.collection('companies');

  /////////////////////////////get all data
  get_All_data() async {
    QuerySnapshot respon = await jobsref.get();
    respon.docs.forEach((element) {
      if (this.mounted) {
        setState(() {
          All_jobs.add(element.data());
        });
      }
    });
    print(All_jobs.length);
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

  get_Post() async {
    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc['uid'] == FirebaseAuth.instance.currentUser.uid) {
          companies_follow_Id = doc.data()['companies_follow'];
        }
      });
    });
    print(companies_follow_Id);
    for (int i = 0; i < companies_follow_Id.length; i++) {
      await FirebaseFirestore.instance
          .collection('companies')
          .doc(companies_follow_Id[i])
          .collection('Post')
          .get()
          .then((value) async {
        if (value.docs.isNotEmpty) {
          for (int j = 0; j < value.docs.length; j++) {
            companies_post.add(value.docs[j].data());

            await company.doc(companies_follow_Id[i]).get().then((value) {
              company_name.add(value.data()['company']);
              num_follwers.add(value.data()['followers'].length);
            });
          }
        }
      });
    }

    print(companies_post);
    print(company_name);
    print(num_follwers);
  }

  @override
  void initState() {

    setState(() {
      getId();
      get_All_data();
      get_My_data();
      get_Post();
    });

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
                      appBar: AppBar(
                        flexibleSpace: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: <Color>[
                                Colors.pink.shade900,
                                Colors.grey.shade800
                              ])),
                        ),
                        toolbarHeight: 150,
                        /* shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                          //  topRight: Radius.circular(10),
                          //  topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(100),
                          bottomRight: Radius.circular(70),
                        )),*/

                        bottom: TabBar(
                          indicatorColor: Colors.white,
                          indicator: UnderlineTabIndicator(
                              //  borderSide: BorderSide(width: 10.0),
                              insets: EdgeInsets.symmetric(
                            horizontal: 60.0,
                          )),
                          tabs: [
                            Tab(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Icon(Icons.work),
                              ),
                            ),
                            Tab(
                              child: Icon(Icons.favorite),
                            ),
                            Tab(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Icon(Icons.business),
                              ),
                            ),
                            Tab(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Icon(Icons.markunread_sharp),
                              ),
                            ),
                            Tab(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Icon(Icons.lightbulb),
                              ),
                            )
                          ],
                        ),
                        title: TextField(
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(0.1, 0.1, 20, 0.1),
                              filled: true,
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 3.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.pink.shade800,
                                  width: 1.0,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                              ),
                              hintText: "البحث ",
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                icon: Icon(Icons.search),
                                onPressed: () {},
                              )),
                          style: TextStyle(color: Colors.white, fontSize: 14.0),
                        ),
                        iconTheme: IconThemeData(color: Colors.white),

                        //backgroundColor: Colors.white,
                        actions: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.notifications_active,
                              color: Colors.amberAccent,
                            ),
                            onPressed: () {
                              //do some things to show notifications
                            },
                          ),
                        ],
                      ),
                      drawer: mydrawer(
                        user: user,
                        docid: docid,
                      ),
                      body: TabBarView(
                        children: [
                          all_chance(All_jobs, user, docid),
                          my_chance(My_jobs, user, docid),
                          companyPage(user_id: docid),
                          company_Publication(
                              post: companies_post,
                              company_name: company_name,
                              num_follwers: num_follwers),
                          ////////////// Rama add roadmaps ^_^
                          my_chance(My_jobs, user, docid),
                        ],
                      ),
                    )))));
  }
}
