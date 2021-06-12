import 'package:b/Home/Company_Pages/Company_Profile.dart';
import 'package:flutter/material.dart';

class buildCardCompany extends StatelessWidget {
  final list;

  const buildCardCompany({Key key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 110,
        padding: EdgeInsets.only(bottom: 15),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: ListTile(
            title: Text("${list['name_job']}" , style: TextStyle(fontSize: 18),),
            subtitle: Padding(
              padding: const EdgeInsets.only(top : 8.0),
              child: Row(
                children: [
                  Icon(Icons.room , size: 15,),
                  Text("${list['region']}"),
                ],
              ),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage("images/photo55.png"),
            ),
          ),
        ),
      ),
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context){
          return companyProfile(list : list);
        }));
      },
    );
  }
}
