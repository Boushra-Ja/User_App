import 'package:b/Home/all_chance.dart';
import 'package:b/Home/show.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'Notification_Page.dart';
import 'ThemeManager.dart';

class myappbar extends StatelessWidget  implements PreferredSize{
  var chance_List ,temp_list, user_Id , user_name;
  List<dynamic>specialization_list ;
  myappbar({this.chance_List ,this.temp_list, this.user_Id ,this.specialization_list , this.user_name});
  @override
  Widget build(BuildContext context) {
    return  AppBar(
      flexibleSpace: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors:ThemeNotifier.mode == true ? <Color>[
                  Colors.pink.shade900,
                  Colors.grey.shade800
                ] : <Color>[
                  Colors.grey.shade700,
                  Colors.black87
                ])),
      ),
      toolbarHeight: 150,

      bottom: TabBar(
        indicatorColor: Colors.white,
        indicator: UnderlineTabIndicator(
          //  borderSide: BorderSide(width: 10.0),
            insets: EdgeInsets.symmetric(
              horizontal: 60.0,
            )),
        tabs: [
          Tab(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Icon(Icons.work , color: ThemeNotifier.mode == true ? Colors.white : Colors.grey.shade200,),
            ),
          ),
          Tab(
            child: Icon(Icons.favorite ,  color: ThemeNotifier.mode == true ? Colors.white : Colors.grey.shade200),
          ),
          Tab(
            child: Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.business ,  color: ThemeNotifier.mode == true ? Colors.white : Colors.grey.shade200),
            ),
          ),
          Tab(
            child: Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.markunread_sharp ,  color: ThemeNotifier.mode == true ? Colors.white : Colors.grey.shade200),
            ),
          ),
          Tab(
            child: Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.lightbulb ,  color: ThemeNotifier.mode == true ? Colors.white : Colors.grey.shade200),
            ),
          )
        ],
      ),
      title : InkWell(
        onTap: (){
          showSearch(context: context, delegate: dataSearch(chance_List: chance_List , user_Id:  user_Id , specialization_list : specialization_list));
        },
        child: Container(
          width: 3*(MediaQuery.of(context).size.width/4) ,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white
          ),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.search , color: Colors.grey,size: 18,),
                onPressed: () {
                },
              ),
              Text("انقر للبحث....." , style: TextStyle(color: Colors.grey , fontSize: 16),)
            ],
          ),
        ),
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
            Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return notificationPage(user_Id:  user_Id , user_name: user_name);
            }));
          },
        ),
      ],
    );

  }
  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight + 100);
  Widget get child => throw UnimplementedError();
}

class dataSearch extends SearchDelegate<String>{
  dataSearch({
    String hintText = "ادخل التخصص",
    this.chance_List , this.user_Id ,this.specialization_list}) : super(
    searchFieldLabel: hintText,
    keyboardType: TextInputType.text,
    textInputAction: TextInputAction.search,


  );
  var chance_List ;
  var user_Id ;
  List<dynamic>specialization_list;
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
    IconButton(
        icon: Icon(
          Icons.arrow_forward,
        ),
        onPressed: () {
          close(context, null);
        })

    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.clear,
        ),
        onPressed: () {
          query = "";
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var temp = [] ;
    List<dynamic> filter_chance = query.isEmpty
        ? specialization_list
        : specialization_list.where((element) => element.startsWith(query)).toList();


    return Directionality(textDirection: TextDirection.rtl, child: Scaffold(
      body: ListView.builder(
          itemCount: filter_chance.length,
          itemBuilder: (context, i) {
            return ListTile(
                leading: Icon(Icons.nature_people),
                title: Text(filter_chance[i]),
                onTap: () {
                  query = filter_chance[i];
                  for(int k = 0 ; k < chance_List.length ; k++){
                    if(query == chance_List[k].job_Info['specialties'])
                    {
                      temp.add(chance_List[k]);
                    }
                  }
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return show_temp(chance_list : temp , user_Id: user_Id );
                  }));

                });
          })

    ));
  }


}



class show_temp extends StatelessWidget{
  var chance_list ,temp_list,  user_Id;
  show_temp({this.chance_list ,this.temp_list, this.user_Id});
  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl, child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade900,
        toolbarHeight: MediaQuery.of(context).size.height/7,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(70),
              bottomRight: Radius.circular(70),
            )),
      ),
       body: all_chance(chance_list ,temp_list, user_Id , false),

    ));
  }
}