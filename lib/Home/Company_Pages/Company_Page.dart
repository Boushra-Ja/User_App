import 'package:b/Home/Company_Pages/buildCardForCompany.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class companyPage extends StatefulWidget {
  final user_id;
  const companyPage({Key key, this.user_id}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return companyState();
  }
}

class companyState extends State<companyPage> {
  CollectionReference company_Info =
      FirebaseFirestore.instance.collection("companies");

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
            Container(
              padding: EdgeInsets.only(top: 20),
              child: StreamBuilder(
                  stream: company_Info.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("Error");
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: SpinKitCircle(
                        color: Colors.pink.shade300,
                        size: 50,
                      ),);
                    }
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, i) {
                            return buildCardCompany(
                                list: snapshot.data.docs[i], company_Id: snapshot.data.docs[i].id, user_id : widget.user_id
                            );
                          });
                    }
                    return Text("loading");
                  }),
            )
          ],
        )));
  }
}
/**/