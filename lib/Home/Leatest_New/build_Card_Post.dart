import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class build_post extends StatelessWidget {
  final post, company_name, num_follwers;
  const build_post({Key key, this.post, this.company_name, this.num_follwers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                              "$company_name",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                              maxLines: 2,
                            ),
                            Text(
                              "$num_follwers" + " متابع",
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
                    "${post['myPost']}",
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
                        child: Column(
                          children: [Icon(Icons.save), Text("حفظ")],
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
