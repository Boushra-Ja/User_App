import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class build_post extends StatefulWidget {
  var post, company_name, num_follwers, user_Id;
  build_post({this.post, this.company_name, this.num_follwers, this.user_Id});

  @override
  State<StatefulWidget> createState() {
    return build_postState();
  }
}

class build_postState extends State<build_post> {
  @override
  Widget build(BuildContext context) {
    bool check_sav = true;
    CollectionReference saved_Item = FirebaseFirestore.instance
        .collection("users")
        .doc(widget.user_Id)
        .collection("posts_saved");

    return Container(
        color: Colors.pink.shade50,
        width: MediaQuery.of(context).size.width,
        child: Card(
          color: Colors.white,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.pink.shade900,
                      child: Icon(
                        Icons.business,
                        size: 35,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 13),
                      child: Container(
                        width:
                            2 * ((MediaQuery.of(context).size.width - 40) / 3),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              "${widget.company_name}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                              maxLines: 2,
                            ),
                            Text(
                              "${widget.num_follwers}" + " متابع",
                              style: TextStyle(color: Colors.grey.shade700),
                            ),
                            Row(
                              children: [
                                Text("الوقت  ",
                                    style:
                                        TextStyle(color: Colors.grey.shade700)),
                                Icon(Icons.public,
                                    size: 17, color: Colors.grey.shade700)
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  // margin: EdgeInsets.symmetric(horizontal: 15),
                  child: AutoSizeText(
                    "${widget.post.my_post}",
                    style: TextStyle(fontSize: 16),
                    maxLines: 10,
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Divider(
                  color: Colors.grey.shade700,
                ),
                SizedBox(
                  height: 2,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [Icon(Icons.thumb_up_alt), Text("أعجبني")],
                        ),
                      ),
                      SizedBox(
                        width: 60,
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Icon(Icons.thumb_down_alt),
                            Text("لم يعجبني")
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 60,
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () async {
                            if (widget.post.check_save == false) {
                              setState(() {
                                widget.post.check_save = true;
                              });
                              print("########${widget.user_Id}");
                              await saved_Item.add({
                                'myPost': widget.post.my_post,
                                'company_name': widget.company_name,
                                'num_followers': widget.num_follwers,
                                'post_Id': widget.post.post_Id
                              }).then((value) {
                                print("success");
                              }).catchError((onError) {
                                print(onError);
                              });
                            } else {
                              setState(() {
                                widget.post.check_save = false;
                              });
                              await saved_Item.get().then((value) async {
                                if (value.docs.isNotEmpty) {
                                  for (int j = 0; j < value.docs.length; j++) {
                                    if (value.docs[j].data()['post_Id'] ==
                                        widget.post.post_Id) {
                                      print("_________________");
                                      print(
                                          "**(( ${value.docs[j].data()['post_Id']}");
                                      saved_Item
                                          .where("post_Id",
                                              isEqualTo: widget.post.post_Id)
                                          .get()
                                          .then((value) {
                                        value.docs.forEach((element) {
                                          saved_Item
                                              .doc(element.id)
                                              .delete()
                                              .then((value) {
                                            print("Success!");
                                          });
                                        });
                                      });
                                    }
                                  }
                                }
                              });
                            }
                          },
                          child: Column(
                            children: [
                              Icon(Icons.save),
                              Text(widget.post.check_save == false
                                  ? "حفظ"
                                  : "الغاء الحفظ")
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 6,
                )
              ],
            ),
          ),
        ));
  }
}

/*
 "#شاغر وظيفي " + '\n'+ "شركة ملابس تعلن غن توفر فرصة جديدة" + "\n\n" +"#في الرياض" +'\n\n'+ "الشروط : "
                        + "\n" + "-خبرة في نفس المجال "
 */
