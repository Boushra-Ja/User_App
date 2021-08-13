import 'package:b/Home/show.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../Info_Job.dart';

class notificationPage extends StatefulWidget{
  final user_Id , user_name ;

  const notificationPage({Key key, this.user_Id , this.user_name}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return notificationPageState();
  }
}

class notificationPageState extends State<notificationPage>{

  Info_Job IJ = new Info_Job();
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

  @override
  Widget build(BuildContext context) {
    CollectionReference N_user =
    FirebaseFirestore.instance.collection("users").doc(widget.user_Id).collection("notifcation");

    return Directionality(textDirection: TextDirection.rtl, child: Scaffold(
      appBar: AppBar(
        title: Text("الاشعارات"),
        centerTitle: true,
        backgroundColor: Colors.pink.shade900,
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
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, i) {
                      return Column(
                        children: [
                          ListTile(
                            onTap: ()async{
                             await get_Info(snapshot.data.docs[i]['id_company'] , snapshot.data.docs[i]["id_chance"]);
                             Navigator.of(context).push(MaterialPageRoute(builder: (context){
                               return show(IJ, widget.user_Id);
                             }));
                            },
                            title: Text("${snapshot.data.docs[i]['id_company']}"),
                            subtitle: Text("${snapshot.data.docs[i]["id_chance"]}"),
                            leading: Icon(Icons.work),
                          ),
                          Divider()
                        ],
                      );
                    });
              }
              return Text("loading");
            }),
      ),
    ));
  }
}