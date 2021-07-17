import 'package:flutter/material.dart';
import 'build_Card_Post.dart';

class company_Publication extends StatefulWidget {
  final post, company_name, num_follwers, user_Id;
  const company_Publication(
      {Key key, this.post, this.company_name, this.num_follwers, this.user_Id})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return company_PublicationState();
  }
}

class company_PublicationState extends State<company_Publication> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: widget.post.length,
      itemBuilder: (context, index) {
        return build_post(
            post: widget.post[index],
            company_name: (widget.company_name is String)
                ? widget.company_name
                : widget.company_name[index],
            num_follwers: (widget.num_follwers is int)
                ? widget.num_follwers
                : widget.num_follwers[index],
            user_Id: widget.user_Id);
      },
    );
  }
}
