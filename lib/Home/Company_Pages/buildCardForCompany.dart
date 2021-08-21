import 'package:b/Home/Company_Pages/Company_Profile.dart';
import 'package:b/UserInfo.dart';
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
  List All_jobs = [] , employe = [] ;
  List<userInfo> employe_List = [];
  var com_Info;
  bool loading = true ;
  userInfo user = new userInfo();

  get_employe()async{
    await FirebaseFirestore.instance.collection('companies').doc(widget.company_Id).get().then((value) {
      employe = value.data()['all_accepted'];
      print(value.data()['all_accepted']);
    });

   if(employe.isNotEmpty){
     employe.forEach((element) async {
       await  FirebaseFirestore.instance.collection('users').doc(element).get().then((value) {
         user = new userInfo();
         user.firstName = value.data()['firstname'];
         user.endName = value.data()['endname'];
         user.selectedCountry = value.data()['originalhome'];
         user.selectedCity = value.data()['placerecident'];
         user.selectedDay = value.data()['date']['day'];
         user.selectedMonth = value.data()['date']['month'];
         user.selectedYear = value.data()['date']['year'];
         user.selectedEdu = value.data()['scientific_level'];
         user.selectedFun = value.data()['carrer_level'];
         user.selectedjob = value.data()['work_field'];
         user.language =  value.data()['language'];
         user.Skills =  value.data()['skill'];
         user.mygmail = value.data()['gmail'];
         user.imageurl = value.data()['imageurl'];
         if(this.mounted){
           employe_List.add(user);
         }
       });
       });

   }

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
        if(this.mounted)
        {
          setState(() {
            check_followers = false;
          });
        }
      } else {
        for (int i = 0; i < num_followers; i++) {
          if (value.data()['followers'][i] == widget.user_id) {
            if(this.mounted)
              {
                setState(() {
                  check_followers = true;
                });
              }
            break;
          } else {
            if(this.mounted)
              {
                setState(() {
                  check_followers = false;
                });
              }
          }
        }
      }
    });
  }

  get_Post() async {
    await FirebaseFirestore.instance
        .collection('companies')
        .doc(widget.company_Id)
        .collection('Post').orderBy('date_publication' , descending: true).
        get()
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
            tem.companies_post.date = docs.docs[i].data()['date_publication'];
            tem.company_Id = widget.company_Id;
            tem.company_name = widget.list['company'];
            tem.token = widget.list['token'];
            tem.picture = widget.list['link_image'];
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
      await get_employe();
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
              child: widget.list['link_image'] == "not" ? Icon(
                Icons.business,
                color: Colors.black,
              ) : null,
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
          chance_list: All_jobs ,
          employe_List : employe_List);
        }));
      },
    );
  }
}
