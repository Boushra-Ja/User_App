import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class myappbar extends StatelessWidget  implements PreferredSize{


  @override
  Widget build(BuildContext context) {
    return  AppBar(backgroundColor: Colors.pink.shade900,
        toolbarHeight: 150,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
          //  topRight: Radius.circular(10),
          //  topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(100),
          bottomRight: Radius.circular(70),)),

        bottom: TabBar(indicatorColor: Colors.white,
          indicator: UnderlineTabIndicator(
            //  borderSide: BorderSide(width: 10.0),
              insets: EdgeInsets.symmetric(horizontal: 60.0,)
          ),

          tabs: [
            Tab(child: Align(
              alignment: Alignment.centerLeft,
              child: Text("جميع الفرص"),),),
            Tab(child: Text("فرصي"),),

            Tab(child: Align(
              alignment: Alignment.centerRight, child: Text("الشركات"),),)
          ],
        ),
        title: TextField(
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(0.1, 0.1, 20, 0.1),
              filled: true,
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 3.0,),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.pink.shade800, width: 3.0,),
                borderRadius: BorderRadius.all(
                    Radius.circular(30.0)),
              ),

              hintText: "البحث ",
              border: InputBorder.none,
              suffixIcon: IconButton(
                icon: Icon(Icons.search), onPressed: () {},)
          ),
          style: TextStyle(color: Colors.white, fontSize: 14.0),
        ),
        iconTheme: IconThemeData(color: Colors.white),

        //backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.notifications_active,
              color: Colors.amberAccent,
            ),
            onPressed: () {
              //do some things to show notifications
            },
          ),
        ],
      );

  }
  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight+40);
  Widget get child => throw UnimplementedError();
}