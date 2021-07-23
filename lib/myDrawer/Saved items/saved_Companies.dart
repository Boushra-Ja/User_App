import 'package:b/Home/Company_Pages/buildCardForCompany.dart';
import 'package:b/component/Loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class savedCompanies extends StatefulWidget {
  var user_Id;
  savedCompanies({this.user_Id});

  @override
  State<StatefulWidget> createState() {
    return savedCompaniesState();
  }
}

class savedCompaniesState extends State<savedCompanies> {
  var companies_list = [];
  bool loading = true;
  get_companies() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.user_Id)
        .collection("companies_saved")
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (int i = 0; i < value.docs.length; i++) {
          companies_list.add(value.docs[i].data());
        }
      }
    });
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    () async {
      await get_companies();
    }();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Directionality(
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
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text("Loading");
                        }
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (context, i) {
                                for (int j = 0;
                                    j < companies_list.length;
                                    j++) {
                                  if (companies_list[j]['company_Id'] ==
                                      snapshot.data.docs[i].id) {
                                    return buildCardCompany(
                                        list: snapshot.data.docs[i],
                                        company_Id: snapshot.data.docs[i].id,
                                        user_id: widget.user_Id);
                                  }
                                }
                                return Text('');
                              });
                        }
                        return Text("loading");
                      }),
                )
              ],
            )));
  }
}
