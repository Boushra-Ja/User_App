import 'package:b/Home/Leatest_New/build_Card_Post.dart';
import 'package:b/component/Loading.dart';
import 'package:b/postInformation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../temp_ForPost.dart';

class savedPosts extends StatefulWidget {
  final user_Id;
  const savedPosts({Key key, this.user_Id}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return savedPostState();
  }
}

class savedPostState extends State<savedPosts> {
  temp_ForPost tem = new temp_ForPost();
  var posts_list = [] , user_name;
  bool loading = true;


  get_posts() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.user_Id)
        .collection("posts_saved")
        .get()
        .then((value) async {
      if (value.docs.isNotEmpty) {
        for (int i = 0; i < value.docs.length; i++) {
          await FirebaseFirestore.instance
              .collection("companies").doc(value.docs[i].data()['company_Id']).collection("Post").get().then((val) async {
                if(val.docs.isNotEmpty){
                  for(int k = 0; k < val.docs.length ; k++)
                    {
                      if(value.docs[i].data()['post_Id'] == val.docs[k].id)
                        {
                          print(val.docs[k].id);
                          print(value.docs[i].data()['post_Id'] );
                          tem = new temp_ForPost();
                          tem.companies_post = new postInformation();
                          tem.check_save = true;
                          tem.companies_post.my_post = val.docs[k].data()['myPost'];
                          tem.companies_post.post_Id = value.docs[i].data()['post_Id'];
                          tem.companies_post.title = val.docs[k].data()['title'];
                          tem.companies_post.date = val.docs[k].data()['date_publication'];

                          await FirebaseFirestore.instance
                              .collection("companies").doc(value.docs[i].data()['company_Id']).get().then((comp){
                                tem.company_name = comp.data()['company'];
                                tem.company_Id = comp.id;
                                tem.token =comp.data()['token'];
                                tem.picture = comp.data()['link_image'];
                                tem.num_follwers = comp.data()['followers'].length;

                          });

                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(widget.user_Id).get().then((t) {
                                if(this.mounted){
                                  setState(() {
                                    user_name = (t.data()['firstname'] + " " + t.data()['endname']);
                                  });
                                }
                            if(t.data()['Interaction_log'].containsKey("${value.docs[i].data()['post_Id']}")){
                              if(this.mounted) {
                                if (t.data()['Interaction_log']["${value.docs[i]
                                    .data()['post_Id']}"] == 'like') {
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

                          posts_list.add(tem);
                        }
                    }
                }
          });
        }
      }
    });
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    () async {
      await get_posts();
    }();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
                body: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.pink.shade50.withOpacity(0.4),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: posts_list.length,
                  itemBuilder: (context, index) {
                    return build_post(
                        post_Info: posts_list[index] , user_Id: widget.user_Id , user_name: user_name) ;
                  },
                )
              ],
            )));
  }
}
