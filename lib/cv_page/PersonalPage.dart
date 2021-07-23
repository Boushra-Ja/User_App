import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:b/Home/homepage.dart';
import 'package:b/component/alart.dart';
import 'package:b/cv_page/Location_Info.dart';
import 'package:b/cv_page/Personal_Information.dart';
import 'package:b/cv_page/Seientific_Information.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fa_stepper/fa_stepper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../UserInfo.dart';
import 'Contact_Information.dart';
import 'Work_Information.dart';

class personalPage extends StatefulWidget {
  final country , city ;
  const personalPage({Key key, this.country, this.city}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PersnalState();
  }
}

class PersnalState extends State<personalPage> {
  int _currentStep = 0;
  CollectionReference userRef = FirebaseFirestore.instance.collection("users");
  GlobalKey<FormState> formState = new GlobalKey<FormState>();
  GlobalKey<FormState> formState2 = new GlobalKey<FormState>();
  GlobalKey<FormState> formState3 = new GlobalKey<FormState>();
  GlobalKey<FormState> formState4 = new GlobalKey<FormState>();
  GlobalKey<FormState> formState5 = new GlobalKey<FormState>();

  addData(userInfo user) async {
    showLoading(context);
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
      'notify': false,
      'scientific_level': user.selectedEdu,
      'carrer_level': user.selectedFun,
      'work_field': user.selectedjob,
      'experience_year': user.selectedExpr,
      'previous_job': user.previous_job,
      'skill': user.Skills,
      'type_work': user.selectedTypeJob,
      'worksite': user.workSite,
      'salary': user.salary,
      'companies_follow' : [],
      'language' : user.language
    }).then((value) {
      print('Sucsess');
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
        return MyHomePage();
      }));
    }).catchError((e) {
      AwesomeDialog(context: context, title: "Error", body: Text('Error'))
        ..show();
    });
  }

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<userInfo>(context);

    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: CustomAppBar(),
            body: Container(
              child: FAStepper(
                  titleHeight: 50,
                  physics: ClampingScrollPhysics(),
                  type: FAStepperType.horizontal,
                  steps: mySteps(),
                  currentStep: _currentStep,
                  onStepTapped: (step) {
                    setState(() {
                      this._currentStep = step;
                    });
                  },
                  onStepContinue: () async {
                    var formdata = formState.currentState;
                    var formdata2 = formState2.currentState;
                    var formdata3 = formState3.currentState;
                    var formdata4 = formState4.currentState;
                    var formdata5 = formState5.currentState;

                    if (_currentStep == 0) {
                      if (formdata.validate()) {
                        formdata.save();
                        setState(() {
                          _currentStep = _currentStep + 1;
                        });
                      }
                    } else if (_currentStep == 1) {
                      if (formdata2.validate()) {
                        formdata2.save();
                        setState(() {
                          _currentStep = _currentStep + 1;
                        });
                      }
                    } else if (_currentStep == 2) {
                      if (formdata3.validate()) {
                        formdata3.save();
                        setState(() {
                          _currentStep = _currentStep + 1;
                        });
                      }
                    } else if (_currentStep == 3) {
                      if (formdata4.validate()) {
                        formdata4.save();
                        setState(() {
                          _currentStep = _currentStep + 1;
                        });
                      }
                    } else {
                      if (formdata5.validate()) {
                        formdata5.save();
                        print(user.mygmail);
                        print(user.phone);
                        var res =await addData(user);
                        if(res != null){
                          print("***&&&&&&");
                         setState(() {
                           user = null;
                         });
                          print(user);
                        }
                      }

                    }
                  },
                  onStepCancel: () {
                    setState(() {
                      if (this._currentStep > 0) {
                        this._currentStep = _currentStep - 1;
                      } else {
                        this._currentStep = 0;
                      }
                    });
                  },
                  stepNumberColor: Colors.pink.shade800,
                  titleIconArrange: FAStepperTitleIconArrange.row,
                  controlsBuilder: (BuildContext context,
                      {VoidCallback onStepContinue,
                        VoidCallback onStepCancel}) {
                    return Row(
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 130,
                          height: 40,
                          child: RaisedButton(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                            color: Colors.pink.shade900.withOpacity(0.7),
                            onPressed: () {
                              print(user.firstName);
                              print(user.endName);
                              print(user.salary);
                              onStepContinue();
                            },
                            child: Text(
                              _currentStep != 4 ? 'Continue' : "Save",
                              style:
                              TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                          width: 130,
                          height: 40,
                          child: RaisedButton(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                            color: Colors.amber.shade100,
                            onPressed: onStepCancel,
                            child: const Text('Cancel',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black)),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    );
                  }),
            )));
  }

  List<FAStep> mySteps() {
    List<FAStep> _steps = [
      FAStep(
        title: Icon(
          Icons.person,
          size: 30,
        ),
        content: Container(
          margin: EdgeInsets.only(bottom: 30, top: 10),
          child: Form(
            key: formState,
            child: PersonalInfo(),
          ),
        ),
        isActive: _currentStep >= 0,
      ),
      FAStep(
        title: Icon(
          Icons.home,
          size: 30,
        ),
        content: Container(
            margin: EdgeInsets.only(bottom: 30, top: 10),
            child: Form(
              key: formState2,
              child: LocationInfo(country : widget.country , city : widget.city),
            )),
        isActive: _currentStep >= 1,
      ),
      FAStep(
        title: Icon(
          Icons.school,
          size: 30,
        ),
        content: Container(
            margin: EdgeInsets.only(bottom: 30, top: 10),
            child: Form(
              key: formState3,
              child: seientificInformation(),
            )),
        isActive: _currentStep >= 2,
      ),
      FAStep(
        title: Icon(
          Icons.work,
          size: 30,
        ),
        content: Container(
            margin: EdgeInsets.only(bottom: 30, top: 10),
            child: Form(
              key: formState4,
              child: workInformation(country : widget.country , city : widget.city),
            )),
        isActive: _currentStep >= 3,
      ),
      FAStep(
        title: Icon(
          Icons.contact_page,
          size: 30,
        ),
        content: Container(
          margin: EdgeInsets.only(bottom: 30, top: 10),
          child: Form(
            key: formState5,
            child: contactInformation(),
          ),
        ),
        isActive: _currentStep >= 4,
      ),
    ];
    return _steps;
  }
}

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => Size(double.infinity, 100);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.pink.shade900, Colors.grey.shade800]),
        )
        ),

    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, size.height - 20);

    final firstControlPoint = Offset(size.width / 4, size.height);
    final firstEndPoint = Offset(size.width / 2.25, size.height - 30.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
    Offset(size.width - (size.width / 3.25), size.height - 65);
    var secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
