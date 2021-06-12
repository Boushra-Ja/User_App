import 'dart:io';
import 'dart:math';
import 'package:b/UserInfo.dart';
import 'package:path/path.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:b/component/alart.dart';
class EditProfile extends StatefulWidget {
  final list, docid;

  const EditProfile({Key key, this.list, this.docid}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return EditProfileState();
  }
}

class EditProfileState extends State<EditProfile> {

  CollectionReference userRef = FirebaseFirestore.instance.collection("users");

  GlobalKey<FormState> formeState = new GlobalKey<FormState>();

  userInfo user = new userInfo() ;
  var imagepicker = ImagePicker(), photo;
  Reference refstorage;
  File file;

  List<String> _gender = ['ذكر', 'أنثى'];
  List<String> _day = [];
  List<String> _month = [];
  List<String> _year = [];
  List<String> _country = ["سوريا", "العراق", "مصر", "السعودية", "الأردن"];
  List<String> _city = ["دمشق", "حمص", "درعا", "حلب", "حماة", "غير ذلك"];

  UploadImagesFromCamera(context, int num, check) async {
    var picker;
    if (num == 1)
      picker = await imagepicker.getImage(source: ImageSource.camera);
    else
      picker = await imagepicker.getImage(source: ImageSource.gallery);

    if (picker != null) {
      file = File(picker.path);
      var nameImage = basename(picker.path);
      var random = Random().nextInt(10000);
      nameImage = "$random$nameImage";
      refstorage = FirebaseStorage.instance
          .ref()
          .child("profileImages")
          .child("$nameImage");
      showLoading(context);
      setState(() {
        photo = file;
      });
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    for (int i = 1980; i < 2020; i++) {
      _year.add("$i");
    }
    for (int i = 1; i <= 12; i++) {
      _month.add("$i");
    }
    for (int i = 1; i <= 30; i++) {
      _day.add("$i");
    }
    user.selectedDay = widget.list['date']['day'];
    user.selectedMonth = widget.list['date']['month'];
    user.selectedYear = widget.list['date']['year'];
    user.selectedGender = widget.list['gender'];
    user.selectedNationality = widget.list['Nationality'];
    user.selectedCity = widget.list['placerecident'];
    user.selectedCountry = widget.list['originalhome'];
    user.phone = widget.list['phone'];

    super.initState();
  }

  UpdateData(context) async {
    var formdata = formeState.currentState;

    if (file == null) {
      if (formdata.validate()) {
        showLoading(context);
        formdata.save();
        await userRef.doc(widget.docid).update({
          'firstname': user.firstName,
          'endname': user.endName,
          'gmail': user.mygmail,
          'gender': user.selectedGender,
          'date': {
            'day': user.selectedDay,
            'month': user.selectedMonth,
            'year': user.selectedYear
          },
          'phone': user.phone,
          'Nationality': user.selectedNationality,
          'originalhome': user.selectedCountry,
          'placerecident': user.selectedCity,
          'uid': FirebaseAuth.instance.currentUser.uid,
        }).then((value) {
          print('Sucsess');
          Navigator.of(context).pushReplacementNamed('homepage');
        }).catchError((e) {
          AwesomeDialog(context: context, title: "Error", body: Text('Error'))
            ..show();
        });
      }
    } else {
      if (formdata.validate()) {
        showLoading(context);
        formdata.save();

        await refstorage.putFile(file);
        user.imageurl = await refstorage.getDownloadURL();
        widget.list['imageurl'] = url;

        await userRef.doc(widget.docid).update({
          'firstname': user.firstName,
          'endname': user.endName,
          'gmail': user.mygmail,
          'gender': user.selectedGender,
          'date': {
            'day': user.selectedDay,
            'month': user.selectedMonth,
            'year': user.selectedYear
          },
          'phone': user.phone,
          'Nationality': user.selectedNationality,
          'originalhome': user.selectedCountry,
          'placerecident': user.selectedCity,
          'uid': FirebaseAuth.instance.currentUser.uid,
          'imageurl': url
        }).then((value) {
          print('Sucsess');
          Navigator.of(context).pushReplacementNamed('homepage');
        }).catchError((e) {
          AwesomeDialog(context: context, title: "Error", body: Text('Error'))
            ..show();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var mdw = MediaQuery.of(context).size.width;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(
              title: Text("ملفي الشخصي"),
              centerTitle: true,
              backgroundColor: Colors.pink.shade900,
              leading: InkWell(
                child: Icon(Icons.arrow_back),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              actions: [
                Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Icon(Icons.share)),
              ],
            ),
            body: Form(
              key: formeState,
              child: ListView(
                children: [
                  Container(
                      width: double.infinity,
                      color: Colors.deepPurple.shade200.withOpacity(0.1)),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (ctxt) => new AlertDialog(
                                  title: Column(
                                    children: [
                                      InkWell(
                                          onTap: () async {
                                            UploadImagesFromCamera(
                                                context, 1, false);
                                            Navigator.of(context).pop();
                                          },
                                          child: Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 10),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      flex: 4,
                                                      child: Container(
                                                          width:
                                                          double.infinity,
                                                          child: Text(
                                                            "تحميل من الكاميرا",
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                            textDirection:
                                                            TextDirection
                                                                .rtl,
                                                            textAlign:
                                                            TextAlign.right,
                                                          ))),
                                                  Expanded(
                                                      flex: 1,
                                                      child: Icon(
                                                        Icons.camera_alt,
                                                        size: 30,
                                                      )),
                                                ],
                                              ))),
                                      InkWell(
                                          onTap: () async {
                                            UploadImagesFromCamera(
                                                context, 2, false);
                                            Navigator.of(context).pop();
                                          },
                                          child: Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 10),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      flex: 4,
                                                      child: Container(
                                                          width:
                                                          double.infinity,
                                                          child: Text(
                                                            "تحميل من المعرض",
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                            textDirection:
                                                            TextDirection
                                                                .rtl,
                                                            textAlign:
                                                            TextAlign.right,
                                                          ))),
                                                  Expanded(
                                                      flex: 1,
                                                      child: Icon(
                                                        Icons.camera,
                                                        size: 30,
                                                      )),
                                                ],
                                              ))),
                                    ],
                                  )));
                        },
                        child: CircleAvatar(
                            radius: 45,
                            backgroundImage: photo != null
                                ? FileImage(photo)
                                : widget.list['imageurl'] != 'not'
                                ? NetworkImage(widget.list['imageurl'])
                                : null,
                            backgroundColor: widget.list['imageurl'] == 'not'
                                ? Colors.amber.shade100
                                : null,
                            child: (widget.list['imageurl'] == 'not'&& photo == null)
                                ? Icon(
                              Icons.person,
                              size: 40,
                              color: Colors.white,
                            )
                                : null),
                      ),
                      Container(
                          padding: EdgeInsets.only(bottom: 40),
                          child: Icon(Icons.add_a_photo))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          widget.list['firstname'] +
                              " " +
                              widget.list['endname'],
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: Colors.white,
                        child: Container(
                          padding: EdgeInsets.only(bottom: 20),
                          margin: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child: Column(
                            children: [
                              Center(
                                  child: Container(
                                    child: Text(
                                      "معلوماتك الشخصية",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  )),
                              Divider(
                                thickness: 1,
                                color: Colors.black,
                              ),
                              Row(
                                children: [
                                  buildText("الاسم الأول", 3),
                                  buildText("", 1),
                                  buildText("الاسم الأخير", 3)
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Row(
                                children: [
                                  buildTextFormAll("ادخل هنا", 3, 1,
                                      widget.list['firstname']),
                                  buildText("", 1),
                                  buildTextFormAll(
                                      "ادخل هنا", 3, 2, widget.list['endname'])
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  buildText("البريد الالكتروني", 3),
                                  buildText("", 1),
                                ],
                              ),
                              Row(
                                children: [
                                  buildTextFormAll(
                                      "ادخل هنا", 4, 3, widget.list['gmail']),
                                  buildText("", 1),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  buildText("الجنس", 1),
                                  buildDropdownButton(
                                      3, widget.list['gender'], 4),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  buildText("تاريخ الميلاد", 3),
                                  buildText("", 1),
                                ],
                              ),
                              Row(
                                children: [
                                  buildDropdownButton(
                                      1, widget.list['date']['day'], 1),
                                  buildDropdownButton(
                                      1, widget.list['date']['month'], 2),
                                  buildDropdownButton(
                                      1, widget.list['date']['year'], 3),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  buildText("رقم الهاتف", 1),
                                  buildTextFormAll(
                                      "09********", 2, 4, widget.list['phone'])
                                ],
                              ),
                              SizedBox(height: 20,)
                            ],
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: Colors.white,
                        child: Container(
                          padding: EdgeInsets.only(bottom: 20),
                          margin: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child: Column(
                            children: [
                              Center(
                                  child: Container(
                                    child: Text(
                                      "معلومات الإقامة",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  )),
                              Divider(
                                thickness: 1,
                                color: Colors.black,
                              ),
                              Row(
                                children: [
                                  buildText("الجنسية", 2),
                                  buildDropdownButton(
                                      3, widget.list['Nationality'], 5),
                                  buildText("", 1),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  buildText("بلد الإقامة", 2),
                                  buildDropdownButton(
                                      3, widget.list['originalhome'], 6),
                                  buildText("", 1),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  buildText("المدينة", 2),
                                  buildDropdownButton(
                                      3, widget.list['placerecident'], 7),
                                  buildText("", 1),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        )),
                  ),
                  buildRaisedButton(context),
                ],
              ),
            )));
  }

  Expanded buildTextFormAll(
      String myHintText, int flex_, valid_num, initialVal) {
    return Expanded(
      flex: flex_,
      child: TextFormField(
        keyboardType: valid_num == 4
            ? TextInputType.number
            : valid_num == 3
            ? TextInputType.emailAddress
            : TextInputType.text,
        initialValue: initialVal,
        validator: (val) {
          if (valid_num == 1 || valid_num == 2) {
            if (val.length == 0) return "يجب تعبئة الحقل";
          } else if (valid_num == 3) {
            if (val.length < 11) return "الرجاء ادخال ايميل صحيح";
          }

          return null;
        },
        onSaved: (val) {
          if (valid_num == 1)
            user.firstName = val;
          else if (valid_num == 2)
            user.endName = val;
          else if (valid_num == 3)
            user.mygmail = val;
          else if (valid_num == 4) user.phone = val;
        },
        decoration: InputDecoration(
            filled: true,
            contentPadding: EdgeInsets.fromLTRB(10.0, 0.1, 20.0, 1.0),
            fillColor: Colors.deepPurple.shade100.withOpacity(0.01)),
      ),
    );
  }

  Expanded buildText(String text, int flex_) {
    return Expanded(
        flex: flex_,
        child: Container(
            padding: EdgeInsets.only(top: 20, right: 15),
            child: Text(
              text,
              style: TextStyle(fontSize: 16, color: Colors.black),
            )));
  }

  Container buildRaisedButton(context) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Center(
        child: Container(
          width: 150,
          child: RaisedButton(
              onPressed: () async {
                await UpdateData(context);
              },
              elevation: 10,
              child: Text(
                "تعديل",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              color: Colors.pink.shade900),
        ),
      ),
    );
  }

  Expanded buildDropdownButton(flex_, String text, _selected) {
    List<String> temp = _selected == 1
        ? _day
        : _selected == 2
        ? _month
        : _selected == 3
        ? _year
        : _selected == 4
        ? _gender
        : _selected == 5 || _selected == 6
        ? _country
        : _city;
    return Expanded(
      flex: flex_,
      child: Container(
        alignment: AlignmentDirectional.centerStart,
        margin: EdgeInsets.only(top: 10, right: 20, left: 20),
        child: DropdownButtonFormField(
          isExpanded: true,
          hint: Text(text),
          value: _selected == 1
              ? user.selectedDay
              : _selected == 2
              ? user.selectedMonth
              : _selected == 3
              ? user.selectedYear
              : _selected == 4
              ? user.selectedGender
              : _selected == 5
              ? user.selectedNationality
              : _selected == 6
              ? user.selectedCountry
              : user.selectedCity,
          onChanged: (newValue) {
            setState(() {
              _selected == 1
                  ? user.selectedDay = newValue
                  : _selected == 2
                  ? user.selectedMonth = newValue
                  : _selected == 3
                  ? user.selectedYear = newValue
                  : _selected == 4
                  ? user.selectedGender = newValue
                  : _selected == 5
                  ? user.selectedNationality = newValue
                  : _selected == 6
                  ? user.selectedCountry = newValue
                  : user.selectedCity = newValue;
            });
          },
          items: temp.map((item) {
            return DropdownMenuItem(
              child: Container(
                  width: double.infinity,
                  child: Text(
                    item,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontWeight: FontWeight.w300, color: Colors.black),
                  )),
              value: item,
            );
          }).toList(),
        ),
      ),
    );
  }
}
