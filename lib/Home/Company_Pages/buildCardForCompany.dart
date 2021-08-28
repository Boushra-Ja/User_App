import 'package:b/Home/Company_Pages/Company_Profile.dart';
import 'package:b/UserInfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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

  CollectionReference company =
      FirebaseFirestore.instance.collection("companies");

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
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return companyProfile(
              list: widget.list,
              user_id: widget.user_id,
              user_name : widget.user_name,
              company_Id : widget.company_Id,
            num_followers: widget.list['followers'].length,
         );
        }));
      },
    );
  }
}
