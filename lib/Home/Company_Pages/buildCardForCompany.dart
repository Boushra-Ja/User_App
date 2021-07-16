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
  var posts = [];

  check_follower() async {
    await company.doc(widget.company_Id).get().then((value) async {
      num_followers = value.data()['followers'].length - 1;
      print(num_followers);
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
    print("******" + "$num_followers");
  }

  get_Post() async {
    await FirebaseFirestore.instance
        .collection('companies')
        .doc(widget.company_Id)
        .collection('Post')
        .get()
        .then((docs) {
      if (docs.docs.isNotEmpty) {
        for (int i = 0; i < docs.docs.length; i++) {
          posts.add(docs.docs[i].data());
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
              radius: 40,
              backgroundImage: widget.list['link_image'] != "link of image"
                  ? NetworkImage(widget.list['link_image'])
                  : null,
              backgroundColor: widget.list['link_image'] == "link of image"
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
