import 'package:b/Home/Company_Pages/Company_Profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../Info_Job.dart';
import '../../postInformation.dart';
import '../../temp_ForPost.dart';

class buildCardCompany extends StatefulWidget {
  final list;
  final company_Id, user_id , user_name;
  const buildCardCompany({Key key, this.list, this.company_Id, this.user_id ,this.user_name})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return buildCardCompanyState();
  }
}

class buildCardCompanyState extends State<buildCardCompany> {
  int num_followers;
  bool check_followers = true;
  temp_ForPost tem = new temp_ForPost();
  CollectionReference company =
      FirebaseFirestore.instance.collection("companies");
  var posts = [];
  Info_Job IJ = new Info_Job();
  List All_jobs = [];
  var com_Info;
  bool loading = true ;

  get_employe()async{

  }

  get_chance()async{
    await company.doc(widget.company_Id).get().then((value) {
      com_Info = value.data();
    });
    company.doc(widget.company_Id).collection("chance").get().then((value) async {
      if(value.docs.isNotEmpty) {
        /////////for chance
        for(int k = 0 ; k <value.docs.length ; k++) {
          IJ = new Info_Job();

          IJ.job_Info = value.docs[k].data();
          IJ.company_Id = widget.company_Id ;
          IJ.company_Info = com_Info;

          if (this.mounted) {
            setState(() {
              All_jobs.add(IJ);
            });
          }
        }
      }

    });

  }

  check_follower() async {
    await company.doc(widget.company_Id).get().then((value) async {
      num_followers = value.data()['followers'].length;
      if (num_followers == 0) {
        setState(() {
          check_followers = false;
        });
      } else {
        for (int i = 0; i < num_followers; i++) {
          if (value.data()['followers'][i] == widget.user_id) {
            setState(() {
              check_followers = true;
            });
            break;
          } else {
            setState(() {
              check_followers = false;
            });
          }
        }
      }
    });
  }

  get_Post() async {
    await FirebaseFirestore.instance
        .collection('companies')
        .doc(widget.company_Id)
        .collection('Post')
        .get()
        .then((docs) async {
      if (docs.docs.isNotEmpty) {
        /////for to post for company
        for (int i = 0; i < docs.docs.length; i++) {
          tem = new temp_ForPost();

          await FirebaseFirestore.instance
              .collection('users')
              .doc(widget.user_id)
              .collection('posts_saved')
              .get()
              .then((value) async {
            if (value.docs.isNotEmpty) {
              ///////for to post_saved in user
              for (int j = 0; j < value.docs.length; j++) {
                if (value.docs[j].data()['post_Id'] ==
                    docs.docs[i].data()['id']) {
                  tem.check_save = true;
                  break;
                } else {
                  tem.check_save = false;
                }

              }
            } else {
              tem.check_save = false;
            }
          });

            tem.companies_post = new postInformation();
            tem.companies_post.post_Id = docs.docs[i].data()['id'];
            tem.companies_post.my_post = docs.docs[i].data()['myPost'];
            tem.companies_post.title = docs.docs[i].data()['title'];
            tem.companies_post.date = docs.docs[i].data()['dateOfPublication'];
            tem.company_Id = widget.company_Id;
            tem.company_name = widget.list['company'];
            tem.token = widget.list['token'];
            await company.doc(widget.company_Id).get().then((v) {
             tem.num_follwers = v.data()['followers'].length;
            });

            await FirebaseFirestore.instance
                .collection('users')
                .doc(widget.user_id).get().then((t) {
              if(t.data()['Interaction_log'].containsKey("${docs.docs[i].data()['id']}")){
                if(this.mounted) {
                  if (t.data()['Interaction_log']["${docs.docs[i]
                      .data()['id']}"] == 'like') {
                    setState(() {
                      tem.check_like = true;
                      tem.check_dislike = false;
                    });
                  } else {
                    setState(() {
                      tem.check_like = false;
                      tem.check_dislike = true;
                    });
                  }
                }
              }
            });
            posts.add(tem);
        }
      }
    });
  }

  @override
  void initState() {
    ()async{
      await get_Post();
      await get_chance();
    }();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        // height: 110,
        padding: EdgeInsets.only(bottom: 15),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: ListTile(
            contentPadding: EdgeInsets.fromLTRB(10, 15, 10, 15),
            title: Text(
              " ${widget.list['company']}",
              style: TextStyle(
                fontSize: 18,
              ),
              maxLines: 3,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: [
                  Icon(
                    Icons.room,
                    size: 15,
                  ),
                  Text("${widget.list['region']} ، ${widget.list['city']}"),
                ],
              ),
            ),
            trailing: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Icon(Icons.arrow_forward_ios),
            ),
            leading: CircleAvatar(
              child: Icon(
                Icons.business,
                color: Colors.black,
              ),
              radius: 40,
              backgroundImage: widget.list['link_image'] != "not"
                  ? NetworkImage(widget.list['link_image'])
                  : null,
              backgroundColor: widget.list['link_image'] == "not"
                  ? Colors.pink.shade100
                  : null,
            ),
          ),
        ),
      ),
      onTap: () async {
        await check_follower();
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return companyProfile(
              list: widget.list,
              user_id: widget.user_id,
              user_name : widget.user_name,
              check_followers: check_followers,
              company_Id : widget.company_Id,
              num_followers : num_followers,
              list_post: posts,
          chance_list: All_jobs);
        }));
      },
    );
  }
}

/*
import 'package:b/stand.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class datasearch extends SearchDelegate<String> {


  var batol;
  List<dynamic> list=new List();
  List<String> data_save;
  datasearch(this.list);
  String u;
  date(context) async {
    CollectionReference ref =FirebaseFirestore.instance.collection("companies").doc(Provider.of<MyProvider>(context, listen: false).company_id).collection("chance");

    String u;
    await ref.where("title", isEqualTo: query).get().then((value) {
      value.docs.forEach((element) {
        u = element.id;
        batol=element.data();

      });
    });
    DocumentReference d =FirebaseFirestore.instance.collection("companies").doc(Provider.of<MyProvider>(context, listen: false).company_id).collection("chance").doc(u);

    await d.get().then((value) {
      String k1 = value.data()['title'];
      String k2 = value.data()['age'];

      data_save = new List();
      data_save.add(k1);
      data_save.add(k2);

    });
  }



  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(
            Icons.clear,
          ),
          onPressed: () {
            query = "";
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.arrow_back,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {

    return Container(child:Column(children:<Widget> [

      Text(data_save[0]),
      SizedBox(height: 20,),

      Text(data_save[1]),
      SizedBox(height: 20,),
    ],));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var sl = query.isEmpty
        ? list
        : list.where((element) => element.startsWith(query)).toList();
    return ListView.builder(
        itemCount: sl.length,
        itemBuilder: (context, i) {
          return ListTile(
              leading: Icon(Icons.nature_people),
              title: Text(sl[i]),
              onTap: () {
                query = sl[i];

                bbbb(context);
              });
        });
  }
  bbbb(context)async{
    await date(context);
    showResults(context);
  }
}
 */


