import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:b/component/alart.dart';
import '../UserInfo.dart';

class informationScientificPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return informationState();
  }
}

class informationState extends State<informationScientificPage> {

  List<String> eductionlist = [ 'تعليم ابتدائي', 'تعليم اعدادي','تعليم ثانوي' , 'شهادة جامعية' , 'شهادة دبلوم' , 'شهادة ماجستير' , 'شهادة دكتوراه' , 'لم أحصل على تعليم'] ;
  List<String> functionalist = [ 'مبتدئ', 'فترة تدريب','مساعد' , 'مدير اداري' , 'مدير تنفيذي' ] ;
  List<String> joblist = [ 'تكنولوجيا المعلومات', 'علوم طبيعية','تدريس' , 'ترجمة ' , 'تصيم غرافيكي وتحريك', "سكرتاريا" , "صحافة" ,"مديرمشاريع" ,"محاسبة" ,"كيمياء ومخابر" ,"طبيب" ,"صيدلة وأدوية"  ,"غير ذلك"] ;
  List<String> experiencelist = [ '1','2' ,'3','4','5','6','7','8' ,'اكثر من ذلك'] ;
  List<String> typeworkList = ['دوام كامل ' , 'دوام جزئي' , 'تدريب' , 'تطوع'] ;
  var docid ;
  userInfo user = new userInfo() ;

  GlobalKey<FormState> formeState = new GlobalKey<FormState>();
  CollectionReference userRef = FirebaseFirestore.instance.collection("users");


  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc['uid'] == FirebaseAuth.instance.currentUser.uid) {
          setState(() {
            docid = doc.id;
          });
        }
      });
    });

    super.initState();
  }

  addData() async {
    var formdata = formeState.currentState;
    print(docid) ;
    if (formdata.validate()) {

      showLoading(context);
      formdata.save();
      await userRef.doc(docid).update(
          {
            'scientific_level' : user.selectedEdu ,
            'carrer_level' : user.selectedFun ,
            'work_field' : user.selectedjob ,
            'experience_year' : user.selectedExpr ,
            'previous_job' : user.previous_job ,
            'skill' : user.Skills ,
            'type_work' : user.selectedTypeJob ,
            'worksite' : user.workSite ,
            'salary' : user.salary
          }
      ).then((value) {
        print('Sucsess');
        Navigator.of(context).pushNamed('homepage');
      }).catchError((e) {
        AwesomeDialog(context: context, title: "Error", body: Text('Error'))
          ..show();
      });
    } else {
      print("failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            body: Stack(children: [
              Container(
                  width: double.infinity,
                  color: Colors.deepPurple.shade200.withOpacity(0.1) ),

              Container(
                child: Form(
                  key: formeState,
                  child: ListView(
                    children: [
                      SizedBox(height: 10,),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          margin: EdgeInsets.only(top : 20 , left: 10 , right: 10) ,
                          decoration: BoxDecoration(
                              color: Colors.deepPurple.shade400,
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black, spreadRadius: 1, blurRadius: 2)
                              ]),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Icon(
                                    Icons.school,
                                    size: 60,
                                  )),
                              Expanded(
                                  flex: 4,
                                  child: Container(
                                      child: Text(
                                        "المجال العلمي",
                                        style: TextStyle(fontSize: 22),
                                      ))),
                            ],
                          )),
                      Container(margin : EdgeInsets.all(10),child: Text("  ** خبراتك العلمية تساعدنا في تأمين الفرص المناسبة لك ** " , style: TextStyle(fontSize: 14 , color: Colors.black),)) ,
                      buildForm("المستوى العلمي" , "حدد مستواك العلمي" , 1  ) ,
                      buildForm("المستوى الوظيفي" , "اختر" , 2  ) ,
                      buildForm("ماهي مجالات عملك" , "اختر" , 3  ) ,
                      buildForm("عدد سنوات خبرتك" , "اختر" , 4  ) ,
                      Container(
                          margin: EdgeInsets.only(left: 15 , right: 15 , bottom: 10),
                          child:  Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              color: Colors.white,
                              child: Row(
                                children: [
                                  Container(padding : EdgeInsets.only(right: 20 , left: 20),child: Text("هل سبق أن عملت بشركة" , style: TextStyle(fontSize: 14),)) ,
                                  Radio(value: 'yes', groupValue: user.previous_job ,onChanged: (val){
                                    setState(() {
                                      user.previous_job = val ;
                                    });
                                  }) ,
                                  Text("نعم" ,style: TextStyle(fontSize: 14 )) ,
                                  Radio(value: 'no', groupValue:  user.previous_job, onChanged: (val){
                                    setState(() {
                                      user.previous_job = val ;
                                    });
                                  }) ,
                                  Text("لا" ,style: TextStyle(fontSize: 14 ))
                                ],
                              )
                          )
                      ) ,

                      Container(
                          margin: EdgeInsets.only(left: 15 , right: 15 , bottom: 10),
                          child:  Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              color: Colors.white,

                              child: Container(
                                padding: EdgeInsets.only(bottom: 10),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10) ,
                                child: Column(
                                  children: [
                                    Text(" المهارات (اختياري)" , style: TextStyle(fontSize: 16),),
                                    buildTextForm(1, "على سبيل المثال  laravel , paython ...")
                                  ],
                                ),
                              )
                          )) ,
                      Container(
                          margin: EdgeInsets.only(left: 15 , right: 15 , bottom: 10),
                          child:  Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            color: Colors.white,

                            child: Container(
                              padding: EdgeInsets.only(bottom: 10),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10) ,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("ماذا تفضل ؟!! " , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.w600 , color: Colors.deepPurple), ),
                                    ],
                                  ),
                                  Divider( color: Colors.deepPurple,) ,
                                  SizedBox(height: 15,) ,
                                  Text("ما نوع العمل الذي ترغب فيه" , style: TextStyle(fontSize: 16),),
                                  buildDropdownButton('اختر', 5) ,
                                  SizedBox(height: 20) ,
                                  Text("حدد موقع العمل المطلوب" , style: TextStyle(fontSize: 16),),
                                  Padding(
                                      padding: const EdgeInsets.symmetric(horizontal:40.0),
                                      child: buildTextForm(2, "ادخل البلد")
                                  ),
                                  SizedBox(height: 20,) ,
                                  Text("حدد الراتب الذي ترغب فيه" , style: TextStyle(fontSize: 16),),
                                  Container(
                                      margin: EdgeInsets.only( right: 40 , left: 40),
                                      child: buildTextForm(3, "000 100  ")
                                  ),
                                  SizedBox( height: 30,)
                                ],
                              ),
                            ) ,
                          )),
                      buildRaisedButton()
                    ],
                  ),
                ),
              )
            ])));
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
                await addData() ;
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

  Container buildDropdownButton( String text , _selected) {
    List <String>temp = _selected == 1 ? eductionlist : _selected ==2 ? functionalist : _selected == 3 ? joblist : _selected == 4 ? experiencelist :  _selected == 5 ? typeworkList : null ;
    return Container(
      alignment: AlignmentDirectional.centerStart,
      margin: EdgeInsets.only(top: 12, right: 20, left: 20),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
            border: (_selected != 5 ) ? OutlineInputBorder(borderRadius: BorderRadius.circular(30)) : null,
            filled: (_selected != 5 )  ?  true : false,
            hintStyle: TextStyle(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.w200),
            contentPadding: EdgeInsets.fromLTRB(0.1, 0.01, 0.1, 0.01),
            fillColor: Colors.deepPurple.shade100.withOpacity(0.1)),
        isExpanded: true,
        hint: Center(child: Text(text)),
        value: _selected==1 ? user.selectedEdu : _selected == 2 ? user.selectedFun : _selected == 3  ? user.selectedjob : _selected == 4 ? user.selectedExpr : _selected == 5 ? user.selectedTypeJob : null,
        onChanged: (newValue) {
          setState(() {
            _selected == 1 ?  user.selectedEdu = newValue : _selected == 2 ? user.selectedFun = newValue : _selected == 3 ? user.selectedjob = newValue : _selected == 4 ? user.selectedExpr = newValue : user.selectedTypeJob = newValue;
          });
        },
        validator: (val) {
          if(_selected == 1) {
            if (user.selectedEdu == null) return 'يجب الاختيار';
          }else if(_selected == 2)
          {
            if (user.selectedFun == null) return 'يجب الاختيار';
          }
          else if(_selected == 3)
          {
            if (user.selectedjob == null) return 'يجب الاختيار';
          }
          else if(_selected == 4)
          {
            if ( user.selectedExpr == null) return 'يجب الاختيار';
          }
          else if(_selected == 5)
          {
            if(user.selectedTypeJob == null)return 'يجب الاختيار ';
          }

          return null;
        },
        items: temp.map((item) {
          return DropdownMenuItem(
            child: Container(
                width: double.infinity,
                child: Center(
                  child: Text(
                    item,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w300, color: Colors.black),
                  ),
                )),
            value: item,
          );
        }).toList(),
      ),
    );
  }

  Container buildForm (text , hintText , num)
  {
    return Container(
        margin: EdgeInsets.only(left: 15 , right: 15 , bottom: 10),
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          color: Colors.white,
          child: Container(
              padding: EdgeInsets.only(bottom: 10),
              margin: EdgeInsets.symmetric(
                  horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  Text(text , style: TextStyle(fontSize: 16),) ,
                  buildDropdownButton(hintText , num)
                ],
              )
          ),

        )) ;
  }
  TextFormField buildTextForm(num , hintText)
  {
    return TextFormField(
        validator: (val){
          if(num == 1)
          {
            if(val.length == 0)
              return 'مطلوب' ;
          }else if(num == 2)
          {
            if(val.length == 0)
              return 'مطلوب' ;
          }else
          {
            if(val.length == 0)
              return 'مطلوب' ;
          }
          return null ;
        },
        onSaved: (val)
        {
          if(num == 1)
            user.Skills = val ;
          else if(num == 2)
            user.workSite = val ;
          else
            user.salary = val ;
        },
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w100 ,  ),
          contentPadding: EdgeInsets.fromLTRB(10.0, 0.01, 10.0, 0.01),
        )
    );
  }
}
