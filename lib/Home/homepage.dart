import 'package:b/Home/Leatest_New/build_Card_Post.dart';
import 'package:b/Home/get_AllChance.dart';
import 'package:b/Home/roadmaps.dart';
import 'package:b/Home/show.dart';
import 'package:b/Info_Job.dart';
import 'package:b/UserInfo.dart';
import 'package:b/chat_p/chats.dart';
import 'package:b/component/Loading.dart';
import 'package:b/myDrawer/Drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../UserInfo.dart';
import '../postInformation.dart';
import '../temp_ForPost.dart';
import 'Company_Pages/Company_Page.dart';
import 'Leatest_New/Refrech_Posts.dart';
import 'ThemeManager.dart';
import 'my_chance.dart';
import 'package:b/Home/appbar.dart';
import 'package:b/chat_p/chat.dart';

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
  bool loading = true , load = true;
  CollectionReference jobsref = FirebaseFirestore.instance.collection("companies");
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference mapref = FirebaseFirestore.instance.collection("roadmaps");
  CollectionReference jobsre ;
  Info_Job IJ = new Info_Job();
  temp_ForPost tem = new temp_ForPost() ;
  Info_Job chance = new Info_Job();
  List<dynamic> temp=
  [
    'تكنولوجيا المعلومات',
    'علوم طبيعية',
    'تدريس',
    'ترجمة ',
    'تصيم غرافيكي وتحريك',
    "سكرتاريا",
    "صحافة",
    "مدير مشاريع",
    "محاسبة",
    "كيمياء ومخابر",
    "طبيب",
    "صيدلة وأدوية",
    "غير ذلك"
  ];
  /////////////////////////////get all data
  get_All_data() async {
    var name ;
    await FirebaseFirestore.instance.collection("users").doc(docid).get().then((value) {
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
                    aaa.add(IJ);
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

  /////////////////////////////get my chance
  get_My_data(){
    setState(() {
      for(int i=0;i<All_jobs.length;i++){
        if(All_jobs[i].job_Info['workTime'] == user.selectedTypeJob){
          My_jobs.add(All_jobs[i]);
        }
      }
    });

  }

  //////////////////////////get maps
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
    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc['uid'] == FirebaseAuth.instance.currentUser.uid) {
          if(this.mounted) {
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
              user.language = doc.data()['language'];
              user.typechance = doc.data()['typechance'];
            });
          }
        }
      });

    });
    print(user.firstName);
  }

  token_storage()async{
    var token ;
    await FirebaseMessaging.instance.getToken().then((value) {
      token = value;
    });

    await users.doc(docid).update({
      'token' : token
    }).then((value) {
      print("sucess");
    }).catchError((e){
      print("errror");
    });
  }

  get_Info_Job(var event)async{
    await FirebaseFirestore.instance.collection("companies").doc(event.data['id_company']).get().then((value) {
      if(this.mounted){
        setState(() {
          chance.company_Info = value.data();
          chance.company_Id = event.data['id_company'];
          chance.user_name = user.firstName + " " + user.endName;
          chance.check_save = false;
        });
      }

    });
    await FirebaseFirestore.instance.collection("companies").doc(event.data['id_company']).collection('chance').doc(event.data['id']).get().then((value) {
      if(this.mounted) {
        setState(() {
          chance.job_Info = value.data();
        });
      } });

  }

  get_Info_Post(event)async{

    await FirebaseFirestore.instance.collection("companies").doc(event.data['id_company']).get().then((value) {
      tem.num_follwers = value.data()['followers'].length;
      tem.company_name = value.data()['company'];
      tem.picture = value.data()['link_image'];
      tem.token = value.data()['token'];
      tem.company_Id = value.id ;
      tem.check_save = false;

    });
    await FirebaseFirestore.instance.collection("companies").doc(event.data['id_company']).collection('Post').doc(event.data['id']).get().then((value) {
      tem.companies_post = new postInformation();
      tem.companies_post.post_Id = value.data()['id'];
      tem.companies_post.my_post = value.data()['myPost'];
      tem.companies_post.title = value.data()['title'];
      tem.companies_post.date = value.data()['date_publication']['day'];
    });
    if(this.mounted)
    {
      setState(() {
        load = false;
      });
    }
  }

  @override
  void initState() {

        () async {
      await getId();
       token_storage();
      await FirebaseMessaging.onMessageOpenedApp.listen((event) async {
        print(event.data);
        if(event.data['num'] == '2')
        {
          await get_Info_Job(event);
          Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return show(chance, docid);
          }));
        }
        else{
          await get_Info_Post(event);
          Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return load ? Loading()  :Directionality(textDirection: TextDirection.rtl, child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.pink.shade900,
                toolbarHeight: 80,
              ),
              body: build_post(post_Info: tem , user_Id: docid ,user_name: user.firstName,),
            ));
          }));

        }

      });

      var message = await FirebaseMessaging.instance.getInitialMessage();
      if(message != null)
      {
        await get_Info_Job(message);
        Navigator.of(context).push(MaterialPageRoute(builder: (context){
          return show(chance, docid);
        }));
      }
      await get_All_data();
      await get_My_data();
      await get_All_maps();

    }();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading ?loading_page():Directionality(
        textDirection: TextDirection.rtl,
        child: Consumer<ThemeNotifier>(
            builder: (context, theme, _){
              return  MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: theme.getTheme(),
                  home: DefaultTabController(
                      length: 5,
                      child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Scaffold(
                            appBar: myappbar(chance_List : All_jobs , user_Id: docid , specialization_list : temp , user_name : user.firstName),
                            drawer: mydrawer(
                                user: user,
                                docid: docid,
                                theme :theme
                            ),
                            body: loading
                                ? Loading()
                                : TabBarView(
                              children: [
                                get_All_chance(temp_list : All_jobs,user_Id: docid,),
                                my_chance(My_jobs, user, docid),
                                companyPage(user_id: docid , user_name: (user.firstName + " " +  user.endName)),
                                Refrech_Posts(docid: docid , user_name: (user.firstName + " " +  user.endName)),
                                roadmaps(all_map)
                              ],

                            ),
                            floatingActionButton: FloatingActionButton(
                              backgroundColor: Colors.pink.shade900,
                               child:Icon(Icons.add_comment),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                  return Chats(user_id : docid);
                                }));
                              }

                            ),
                          )))
              );

            })
    );
  }
}

class loading_page extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.grey.shade100,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,

        ),
        Center(
          child: SpinKitFadingCircle(
            itemBuilder: (BuildContext context, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: index.isEven ? Colors.pink : Colors.grey,
                ),
              );
            },
          ),
        )
      ],
    );
  }
}


//   flutter run -d chrome --web-renderer html