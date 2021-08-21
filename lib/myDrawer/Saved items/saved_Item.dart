import 'package:b/Home/ThemeManager.dart';
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
                        colors: ThemeNotifier.mode ? <Color>[
                      Colors.pink.shade900,
                      Colors.amber.shade50
                    ] : <Color>[
                          Colors.black87,
                          Colors.grey.shade700
                        ])),
              ),
              leading: InkWell(
                child: Icon(
                  Icons.arrow_back,
                  color: ThemeNotifier.mode ?  Colors.pink.shade900 : Colors.white,
                  size: 30,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            body: Center(
              child: tabs.elementAt(_selectedIndex),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items:  <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.business , color: ThemeNotifier.mode ? Colors.black87 : Colors.white,),
                  label: 'الشركات' ,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.work , color: ThemeNotifier.mode ? Colors.black87 : Colors.white),
                  label: 'الفرص',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.markunread , color: ThemeNotifier.mode ? Colors.black87 : Colors.white),
                  label: 'المنشورات',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.pink.shade900,
              selectedLabelStyle: TextStyle(fontSize: 18),
              onTap: _onItemTapped,
              unselectedLabelStyle: TextStyle(fontSize: 14 , color: ThemeNotifier.mode ? Colors.black87 : Colors.white),
            )));
  }
}
