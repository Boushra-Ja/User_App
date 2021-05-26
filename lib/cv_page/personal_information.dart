import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:b/component/alart.dart';
import '../UserInfo.dart';

class informationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return informationState();
  }
}

class informationState extends State<informationPage> {

  userInfo user = new userInfo() ;
  CollectionReference userRef = FirebaseFirestore.instance.collection("users");
  GlobalKey<FormState> formeState = new GlobalKey<FormState>();

  List<String> _gender = ['ذكر', 'أنثى'];
  List<String> _day = [];
  List<String> _month = [];
  List<String> _year = [];
  List<String> _country = ["سوريا", "العراق", "مصر", "السعودية", "الأردن"];
  List<String> _city = ["دمشق", "حمص", "درعا", "حلب", "حماة", "غير ذلك"];

  addData() async {
    var formdata = formeState.currentState;

    if (formdata.validate()) {
      showLoading(context);
      formdata.save();

      await userRef.add({
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
        'imageurl': "not",
        'privecy': false,
        'notify': false
      }).then((value) {
        print('Sucsess');
        Navigator.of(context).pushNamed('informationscientific');
      }).catchError((e) {
        AwesomeDialog(context: context, title: "Error", body: Text('Error'))
          ..show();
      });
    } else {
      print("failed");
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

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            body: Stack(
              children: [
                Container(
                    width: double.infinity,
                    color: Colors.deepPurple.shade200.withOpacity(0.1)),
                Container(
                  child: Form(
                    key: formeState,
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: Colors.deepPurple.shade400,
                                borderRadius: BorderRadius.circular(50),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12,
                                      spreadRadius: 1,
                                      blurRadius: 2)
                                ]),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Icon(
                                      Icons.account_circle,
                                      size: 60,
                                    )),
                                Expanded(
                                    flex: 4,
                                    child: Container(
                                        child: Text(
                                          "  الملف الشخصي",
                                          style: TextStyle(fontSize: 22),
                                        ))),
                              ],
                            )),
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
                                    Text(
                                      "الحقل الذي يحوي * هو حقل اجباري",
                                      style: TextStyle(
                                          color: Colors.red.shade700, fontSize: 12),
                                    ),
                                    Row(
                                      children: [
                                        buildText(" الاسم الأول*", 3),
                                        buildText("", 1),
                                        buildText("الاسم الأخير*", 3)
                                      ],
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Row(
                                      children: [
                                        buildTextFormAll("ادخل هنا", 3, 1),
                                        buildText("", 1),
                                        buildTextFormAll("ادخل هنا", 3, 2)
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        buildText("البريد الالكتروني*", 3),
                                        buildText("", 1),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        buildTextFormAll("ادخل هنا", 4, 3),
                                        buildText("", 1),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        buildText("الجنس*", 1),
                                        buildDropdownButton(3, "اختر", 4),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        buildText("تاريخ الميلاد*", 3),
                                        buildText("", 1),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        buildDropdownButton(1, "اليوم", 1),
                                        buildDropdownButton(1, "الشهر", 2),
                                        buildDropdownButton(1, "السنة", 3),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        buildText("رقم الهاتف", 1),
                                        buildTextFormAll("09********", 2, 4)
                                      ],
                                    )
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
                                        buildText("الجنسية*", 2),
                                        buildDropdownButton(3, 'اختر', 5),
                                        buildText("", 1),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        buildText("بلد الإقامة*", 2),
                                        buildDropdownButton(3, "البلد", 6),
                                        buildText("", 1),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        buildText("المدينة*", 2),
                                        buildDropdownButton(3, "المدينة", 7),
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
                        buildRaisedButton(),
                      ],
                    ),
                  ),
                ),
              ],
            )));
  }

  Expanded buildTextFormAll(String myHintText, int flex_, valid_num) {
    return Expanded(
      flex: flex_,
      child: TextFormField(
        keyboardType: valid_num == 4
            ? TextInputType.number
            : valid_num == 3
            ? TextInputType.emailAddress
            : TextInputType.text,
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
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            hintText: myHintText,
            filled: true,
            hintStyle: TextStyle(
                fontSize: 12, color: Colors.black, fontWeight: FontWeight.w200),
            contentPadding: EdgeInsets.fromLTRB(10.0, 0.01, 20.0, 0.01),
            fillColor: Colors.deepPurple.shade100.withOpacity(0.01)),
      ),
    );
  }

  Expanded buildText(String text, int flex_) {
    return Expanded(
        flex: flex_,
        child: Container(
            padding: EdgeInsets.only(top: 15, right: 15),
            child: Text(
              text,
              style: TextStyle(fontSize: 16, color: Colors.black),
            )));
  }

  Container buildRaisedButton() {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Center(
        child: Container(
          width: 150,
          child: RaisedButton(
              onPressed: () async {
                await addData();
              },
              elevation: 10,
              child: Text(
                "حفظ",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              color: Colors.deepPurple.shade400.withOpacity(0.8)),
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
                  :  user.selectedCity = newValue;
            });
          },
          validator: (val) {
            if (_selected == 1) {
              if (user.selectedDay == null) return 'مطلوب';
            } else if (_selected == 2) {
              if (user.selectedMonth == null) return 'مطلوب';
            } else if (_selected == 3) {
              if (user.selectedYear == null) return 'مطلوب';
            } else if (_selected == 4) {
              if (user.selectedGender == null) return 'مطلوب';
            } else if (_selected == 5) {
              if (user.selectedNationality == null) return 'مطلوب';
            } else if (_selected == 6) {
              if (user.selectedCountry == null) return 'مطلوب';
            } else {
              if (user.selectedCity == null) return 'مطلوب';
            }

            return null;
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
