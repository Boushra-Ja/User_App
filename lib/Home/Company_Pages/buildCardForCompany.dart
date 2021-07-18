import 'package:b/Home/Company_Pages/Company_Profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class buildCardCompany extends StatefulWidget {
  final list;
  final company_Id, user_id;
  const buildCardCompany({Key key, this.list, this.company_Id, this.user_id})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return buildCardCompanyState();
  }
}

class buildCardCompanyState extends State<buildCardCompany> {
  int num_followers;
  bool check_followers = true;
  CollectionReference company =
      FirebaseFirestore.instance.collection("companies");
  List<temp> posts = [];
  temp t = new temp();

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
          t = new temp();
          await FirebaseFirestore.instance
              .collection('users')
              .doc(widget.user_id)
              .collection('posts_saved')
              .get()
              .then((value) {
            if (value.docs.isNotEmpty) {
              ///////for to post_saved in user
              for (int j = 0; j < value.docs.length; j++) {
                if (value.docs[j].data()['post_Id'] ==
                    docs.docs[i].data()['post_Id']) {
                  t.check_save = true;
                  break;
                } else {
                  t.check_save = false;
                }

              }
            } else {
              t.check_save = false;
            }
            t.post_Id = docs.docs[i].data()['post_Id'];
            t.my_post = docs.docs[i].data()['myPost'];
            posts.add(t);
          });
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    () async {
      await get_Post();
    }();
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
        print("&&&&&&&&" + "$num_followers");
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return companyProfile(
              list: widget.list,
              company_Id: widget.company_Id,
              user_id: widget.user_id,
              check_followers: check_followers,
              list_post: posts,
              num_followers: num_followers);
        }));
      },
    );
  }
}

class temp {
  var post_Id, check_save, my_post;
}
