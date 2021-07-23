import 'package:b/Home/Leatest_New/build_Card_Post.dart';
import 'package:b/component/Loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class savedPosts extends StatefulWidget {
  final user_Id;
  const savedPosts({Key key, this.user_Id}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return savedPostState();
  }
}

class savedPostState extends State<savedPosts> {
  temp_ t = new temp_();
  var posts_list = [];
  bool loading = true;

  get_posts() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.user_Id)
        .collection("posts_saved")
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (int i = 0; i < value.docs.length; i++) {
          t = new temp_();
          t.check_save = true;
          t.my_post = value.docs[i].data()['myPost'];
          t.post_Id = value.docs[i].data()['post_Id'];
          t.company_name = value.docs[i].data()['company_name'];
          t.num_followers = value.docs[i].data()['num_followers'];
          posts_list.add(t);
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
                        post: posts_list[index],
                        company_name: posts_list[index].company_name,
                        num_follwers: posts_list[index].num_followers,
                        user_Id: widget.user_Id);
                  },
                )
              ],
            )));
  }
}

class temp_ {
  var post_Id, check_save, my_post, company_name, num_followers;
}
