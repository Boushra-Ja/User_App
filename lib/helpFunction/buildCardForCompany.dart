import 'package:b/Home/Company_Pages/Company_Profile.dart';
import 'package:flutter/material.dart';

class buildCardCompany extends StatelessWidget {
  final list;

  const buildCardCompany({Key key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
       // height: 110,
        padding: EdgeInsets.only(bottom: 15),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: ListTile(
            contentPadding: EdgeInsets.fromLTRB(10, 15, 10, 15),
            title: Text(" ${list['company']}" , style: TextStyle(fontSize: 18 ,
            ),
              maxLines: 3,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top : 8.0),
              child: Row(
                children: [
                  Icon(Icons.room , size: 15,),
                  Text("${list['region']} ، ${list['city']}"),
                ],
              ),
            ),
            trailing: Padding(
              padding: const EdgeInsets.only(top :15.0),
              child: Icon(Icons.arrow_forward_ios),
            ),
            leading: CircleAvatar(
              radius: 40,
              backgroundImage: list['link_image'] != 'not' ? NetworkImage(list['link_image']) : null,
              backgroundColor: list['link_image']== 'not' ? Colors.pink.shade100 : null,
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
