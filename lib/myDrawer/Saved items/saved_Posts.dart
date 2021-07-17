import 'package:b/Home/Leatest_New/build_Card_Post.dart';
import 'package:flutter/material.dart';

class savedPosts extends StatelessWidget {
  final posts_list, user_Id;
  const savedPosts({Key key, this.posts_list, this.user_Id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
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
                    user_Id: user_Id);
              },
            )
          ],
        )));
  }
}
