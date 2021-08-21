import 'package:flutter/material.dart';
import 'build_Card_Post.dart';

class company_Publication extends StatefulWidget {
  final post_Info , user_Id ,user_name;
  const company_Publication(
      {Key key, this.post_Info , this.user_Id ,this.user_name})
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
    return widget.post_Info.length ==0 ? Center(child: Text("لا يوجد منشورات")) : ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: widget.post_Info.length,
      itemBuilder: (context, index) {
        return build_post(
          post_Info : widget.post_Info[index] , user_Id: widget.user_Id , user_name: widget.user_name,
        );
      },
    );
  }
}

