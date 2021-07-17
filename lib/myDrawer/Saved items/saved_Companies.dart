import 'package:b/Home/Company_Pages/buildCardForCompany.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class savedCompanies extends StatelessWidget {
  var companies_list, user_Id;
  savedCompanies({this.companies_list, this.user_Id});

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
                  stream: FirebaseFirestore.instance
                      .collection('companies')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("Error");
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading");
                    }
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, i) {
                            for (int j = 0; j < companies_list.length; j++) {
                              if (companies_list[j]['company_Id'] ==
                                  snapshot.data.docs[i].id) {
                                return buildCardCompany(
                                    list: snapshot.data.docs[i],
                                    company_Id: snapshot.data.docs[i].id,
                                    user_id: user_Id);
                              }
                            }
                            return Text("");
                          });
                    }
                    return Text("loading");
                  }),
            )
          ],
        )));
  }
}
