import 'package:b/component/Loading.dart';
import 'package:b/postInformation.dart';
import 'package:b/temp_ForPost.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Company_Publication.dart';

class Refrech_Posts extends StatefulWidget {
  var docid;
  Refrech_Posts({this.docid});
  @override
  State<StatefulWidget> createState() {
    return RefrechPostsState();
  }
}

class RefrechPostsState extends State<Refrech_Posts> {
  bool loading = true;
  List companies_follow_Id = [];
  temp_ForPost tem = new temp_ForPost() ;
  var post_Info = [] ;

  CollectionReference company =
      FirebaseFirestore.instance.collection('companies');

  get_Post() async {
    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc['uid'] == FirebaseAuth.instance.currentUser.uid) {
          //////////The numbers of the companies that the user follows
          companies_follow_Id = doc.data()['companies_follow'];
        }
      });
    });

    for (int i = 0; i < companies_follow_Id.length; i++) {
      await FirebaseFirestore.instance
          .collection('companies')
          .doc(companies_follow_Id[i])
          .collection('Post')
          .get()
          .then((value) async {
        if (value.docs.isNotEmpty) {
          for (int j = 0; j < value.docs.length; j++) {
            tem = new temp_ForPost();
            //////////////get company Info
            await company.doc(companies_follow_Id[i]).get().then((val) {
              tem.company_Id = val.id ;
              tem.company_name = val.data()['company'];
              tem.num_follwers = val.data()['followers'].length;
            });
            ///////////////check about save
            await FirebaseFirestore.instance
                .collection('users')
                .doc(widget.docid)
                .collection('posts_saved').where("post_Id" , isEqualTo: value.docs[j].id).get().then((v) {
                  if(v.docs.isNotEmpty)
                    {
                      setState(() {
                        tem.check_save = true;
                      });
                    }
                  else{
                    setState(() {
                      tem.check_save = false;
                    });
                  }
            });
            //////check interaction
            await FirebaseFirestore.instance
                .collection('users')
                .doc(widget.docid).get().then((t) {
                  if(t.data()['Interaction_log'].containsKey("${value.docs[j].data()['id']}")){
                    if(t.data()['Interaction_log']["${value.docs[j].data()['id']}"] == 'like'){
                      setState(() {
                        tem.check_like = true;
                        tem.check_dislike = false;

                      });
                    }else{
                      setState(() {
                        tem.check_like = false;
                        tem.check_dislike = true;

                      });
                    }
                  }
            });
            tem.companies_post = new postInformation();
            tem.companies_post.post_Id = value.docs[j].data()['id'];
            tem.companies_post.my_post = value.docs[j].data()['myPost'];
            tem.companies_post.title = value.docs[j].data()['title'];
            tem.companies_post.date = value.docs[j].data()['dateOfPublication'];
            post_Info.add(tem);
          }
        }
      });
    }
    setState(() {
      loading = false;
    });

  }

  @override
  void initState() {
    () async {
      await get_Post();
    }();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : company_Publication(
            post_Info : post_Info , user_Id: widget.docid,);
  }
}
