import 'package:flutter/material.dart';


class My_Chances extends StatelessWidget {
  My_Chances(job) {
    print(job["name_job"]);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl, child: Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: ListView(
        children: [
          Text(" NAME :"),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Go back!'),
          ),
        ],
      ),
    ));
  }
}
