import 'package:flutter/material.dart';
import 'build_Card_Post.dart';

class company_Publication extends StatelessWidget {
  final post, company_name, num_follwers;
  const company_Publication(
      {Key key, this.post, this.company_name, this.num_follwers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: post.length,
      itemBuilder: (context, index) {
        return build_post(
          post: post[index],
          company_name:
              (company_name is String) ? company_name : company_name[index],
          num_follwers:
              (num_follwers is int) ? num_follwers : num_follwers[index],
        );
      },
    );
  }
}
