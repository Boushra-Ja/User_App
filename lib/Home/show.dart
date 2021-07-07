import 'package:b/myDrawer/Drawer.dart';
import 'package:flutter/material.dart';


class show extends StatelessWidget {
  var job;
  show(job) {
    this.job=job;
    // print(job["name_job"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.pink.shade800,
        title: Text("Second Route"),
      ),
      drawer: mydrawer(),
      body: ListView(
        children: [
          Text(" NAME :" +"${job["name_job"]}"),
          ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.amberAccent),),
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
