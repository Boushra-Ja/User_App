import 'package:b/Home/homepage.dart';
import 'package:b/component/Loading.dart';
import 'package:b/myDrawer/Saved%20items/saved_Companies.dart';
import 'package:b/myDrawer/Saved%20items/saved_Posts.dart';
import 'package:b/myDrawer/Saved%20items/saved_jobs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class saved_Item extends StatefulWidget {
  final user_Id;

  const saved_Item({Key key, this.user_Id}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return savedItemState();
  }
}

class savedItemState extends State<saved_Item> {
  int _selectedIndex = 0;
  var companies_list = [], posts_list = [];
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  bool loading = true;
  temp_ t = new temp_();

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
    print("****" + companies_list.toString());
  }

  get_posts() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.user_Id)
        .collection("posts_saved")
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (int i = 0; i < value.docs.length; i++) {
          t = new temp_();
          t.check_save = true;
          t.my_post = value.docs[i].data()['myPost'];
          t.post_Id = value.docs[i].data()['post_Id'];
          t.company_name = value.docs[i].data()['company_name'];
          t.num_followers = value.docs[i].data()['num_followers'];
          posts_list.add(t);
        }
      }
    });

    if (posts_list.isNotEmpty) print("****" + posts_list.elementAt(0).my_post);
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    () async {
      await get_companies();
      await get_posts();
    }();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final tabs = <Widget>[
      savedCompanies(companies_list: companies_list, user_Id: widget.user_Id),
      savedJobs(),
      savedPosts(posts_list: posts_list, user_Id: widget.user_Id)
    ];

    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(
              flexibleSpace: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomRight,
                        colors: <Color>[
                      Colors.pink.shade900,
                      Colors.amber.shade50
                    ])),
              ),
              leading: InkWell(
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.pink.shade900,
                  size: 30,
                ),
                onTap: () {
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (context) {
                    return MyHomePage();
                  }));
                },
              ),
            ),
            body: loading
                ? Loading()
                : Center(
                    child: tabs.elementAt(_selectedIndex),
                  ),
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.business),
                  label: 'الشركات',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.work),
                  label: 'الفرص',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.markunread),
                  label: 'المنشورات',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.pink.shade900,
              selectedLabelStyle: TextStyle(fontSize: 16),
              onTap: _onItemTapped,
              unselectedItemColor: Colors.black,
            )));
  }
}

class temp_ {
  var post_Id, check_save, my_post, company_name, num_followers;
}
