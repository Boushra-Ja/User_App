import 'package:b/component/Loading.dart';
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
  List companies_follow_Id = [], company_name = [], num_follwers = [];
  var companies_post = [];
  temp t = new temp();

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
            await company.doc(companies_follow_Id[i]).get().then((value) {
              company_name.add(value.data()['company']);
              num_follwers.add(value.data()['followers'].length);
            });
            t = new temp();
            await FirebaseFirestore.instance
                .collection('users')
                .doc(widget.docid)
                .collection('posts_saved')
                .get()
                .then((doc) {
              if (doc.docs.isNotEmpty) {
                for (int k = 0; k < doc.docs.length; k++) {
                  if (doc.docs[k].data()['post_Id'] ==
                      value.docs[j].data()['post_Id']) {
                    setState(() {
                      t.check_save = true;
                    });
                    break;
                  } else {
                    setState(() {
                      t.check_save = false;
                    });
                  }
                }
              } else {
                t.check_save = false;
              }
              t.post_Id = value.docs[j].data()['post_Id'];
              t.my_post = value.docs[j].data()['myPost'];
              companies_post.add(t);
            });
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
            post: companies_post,
            company_name: company_name,
            num_follwers: num_follwers,
            user_Id: widget.docid);
  }
}

class temp {
  var post_Id, check_save, my_post;
}
