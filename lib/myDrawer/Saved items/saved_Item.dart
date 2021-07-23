import 'package:b/Home/homepage.dart';
import 'package:b/myDrawer/Saved%20items/saved_Companies.dart';
import 'package:b/myDrawer/Saved%20items/saved_Posts.dart';
import 'package:b/myDrawer/Saved%20items/saved_jobs.dart';
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
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final tabs = <Widget>[
      savedCompanies(user_Id: widget.user_Id),
      savedJobs(user_Id: widget.user_Id),
      savedPosts(user_Id: widget.user_Id)
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
            body: Center(
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
