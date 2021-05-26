import 'package:flutter/material.dart';
import 'package:b/SettingPage/setting_page.dart';

class updatePassword extends StatefulWidget {
  final list, docid;
  const updatePassword({Key key, this.list, this.docid}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return updateState();
  }
}

class updateState extends State<updatePassword> {

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepPurple.shade700,
            leading: InkWell(
              child: Icon(
                Icons.arrow_back_ios,
                size: 20,
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return settingPage(
                    list: widget.list,
                    docid: widget.docid,
                  );
                }));
              },
            ),
          ),
          body: Container(
              margin: EdgeInsets.all(20),
              child: Column(
                children: [
                  buildTextForm("كلمة المرور القديمة", 0),
                  SizedBox(
                    height: 20,
                  ),
                  buildTextForm("كلمة المرور ألجديدة", 1),
                  SizedBox(
                    height: 20,
                  ),
                  buildTextForm("تأكيد كلمة المرور", 1),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 150,
                    child: RaisedButton(
                        onPressed: () async {},
                        elevation: 10,
                        child: Text(
                          "تغيير",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
                        color: Colors.deepPurple.shade700.withOpacity(0.8)),
                  )
                ],
              )),
        ));
  }

  TextFormField buildTextForm(hintText, num) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: num == 1 ? Icon(Icons.lock) : Icon(Icons.vpn_key_outlined),
        hintText: hintText,
        hintStyle: TextStyle(
            fontSize: 18,
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w300),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
