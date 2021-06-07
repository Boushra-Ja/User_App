import 'package:b/myDrawer/Drawer.dart';
import 'package:flutter/material.dart';


class show extends StatelessWidget {
  show(job) {
   // print(job["name_job"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.purple[700],
        title: Text("Second Route"),
      ),
        drawer: mydrawer(),
      body: ListView(
        children: [
          Text(" NAME :"),
          ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.purple[200]),),
          onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Go back!'),
          ),
        ],
      ),
    );
  }
}
