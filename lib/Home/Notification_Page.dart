import 'package:b/Home/Leatest_New/build_Card_Post.dart';
import 'package:b/Home/ThemeManager.dart';
import 'package:b/Home/show.dart';
import 'package:b/component/Loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../Info_Job.dart';
import '../postInformation.dart';
import '../temp_ForPost.dart';

class notificationPage extends StatefulWidget{
  final user_Id , user_name ;

  const notificationPage({Key key, this.user_Id , this.user_name}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return notificationPageState();
  }
}

class notificationPageState extends State<notificationPage>{
  bool load = true ;
  Info_Job IJ = new Info_Job();
  temp_ForPost tem = new temp_ForPost() ;

  get_Info(comapny_Id , chance_Id)async{
    IJ = new Info_Job();
    IJ.user_name = widget.user_name;
    await FirebaseFirestore.instance.collection("companies").doc(comapny_Id).get().then((value) {
      IJ.company_Info = value.data();
      IJ.company_Id = comapny_Id;
    });

    await FirebaseFirestore.instance.collection("companies").doc(comapny_Id).collection("chance").doc(chance_Id).get().then((value) {
      IJ.job_Info = value.data();
    }) ;
  }

  get_Info_Post(comapny_Id , post_Id)async{
    tem = new temp_ForPost() ;
    await FirebaseFirestore.instance.collection('companies').doc(comapny_Id).get().then((value) {
      tem.company_Id = comapny_Id ;
      tem.company_name = value.data()['company'];
      tem.token = value.data()['token'];
      tem.picture = value.data()['link_image'];
      tem.num_follwers = value.data()['followers'].length;
    });
    await FirebaseFirestore.instance.collection('companies').doc(comapny_Id).collection("Post").doc(post_Id).get().then((value) {
      tem.companies_post = new postInformation();
      tem.companies_post.post_Id = value.data()['id'];
      tem.companies_post.my_post = value.data()['myPost'];
      tem.companies_post.title = value.data()['title'];
      tem.companies_post.date = value.data()['date_publication'];
    });
    if(this.mounted)
      {
        setState(() {
          load = false;
        });
      }

  }

  @override
  Widget build(BuildContext context) {
    CollectionReference N_user =
    FirebaseFirestore.instance.collection("users").doc(widget.user_Id).collection("notifcation");

    return Directionality(textDirection: TextDirection.rtl, child: Scaffold(
      appBar: AppBar(
        title: Text("الاشعارات" , style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: ThemeNotifier.mode ? Colors.pink.shade900 : Colors.black87,
        toolbarHeight: 80,
      ),
      body: Container(
        child: StreamBuilder(
            stream: N_user.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("Error");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: SpinKitCircle(
                  color: Colors.pink.shade300,
                  size: 50,
                ),);
              }
              if (snapshot.hasData) {
                return ListView.builder(
                  padding: EdgeInsets.only(bottom: 20 , top : 20),
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, i) {
                      return (snapshot.data.docs[i]['date_publication']['year'] == DateTime.now().year &&
                          snapshot.data.docs[i]['date_publication']['month'] == DateTime.now().month &&
                          snapshot.data.docs[i]['date_publication']['day'] >= (DateTime.now().day - 7)) ||

                          snapshot.data.docs[i]['date_publication']['year'] == DateTime.now().year &&
                              snapshot.data.docs[i]['date_publication']['month'] == (DateTime.now().month - 1)&&
                              snapshot.data.docs[i]['date_publication']['day'] <= ((DateTime.now().day + 7)%10) ?
                        Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10 ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: ThemeNotifier.mode ? (snapshot.data.docs[i]["num"] == 2 ? Colors.pink.shade100.withOpacity(0.6) : Colors.amber.shade100.withOpacity(0.6)) : Colors.grey.shade500,
                            ),
                            child: ListTile(
                              onTap: ()async{
                                if(snapshot.data.docs[i]["num"] == 2)
                                  {
                                    await get_Info(snapshot.data.docs[i]['id_company'] , snapshot.data.docs[i]["id"]);
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                      return show(IJ, widget.user_Id);
                                    }));
                                  }else{
                                  await get_Info_Post(snapshot.data.docs[i]['id_company'] , snapshot.data.docs[i]["id"]);
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                    return load ? Loading() : Directionality(textDirection: TextDirection.rtl, child: Scaffold(
                                      appBar: AppBar(backgroundColor: Colors.pink.shade900,),
                                      body: build_post(post_Info: tem,user_Id: widget.user_Id,user_name: widget.user_name),
                                    ));
                                  }));
                                }

                              },
                              title: Text("${snapshot.data.docs[i]["title"] }") ,
                              subtitle: Text("${snapshot.data.docs[i]["body"] }"),
                              leading: snapshot.data.docs[i]["num"] == 2  ? Icon(Icons.work) : Icon(Icons.markunread_sharp),
                            ),
                          ),
                          Divider(),
                          SizedBox(height: 10,)
                        ],
                      ) : Text("" , style: TextStyle(fontSize: 1),);
                    });
              }
              return Text("loading");
            }),
      ),
    ));
  }
}