import 'package:b/Home/all_chance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'ThemeManager.dart';

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
        backgroundColor: ThemeNotifier.mode ? Colors.pink.shade900 : Colors.black87,
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