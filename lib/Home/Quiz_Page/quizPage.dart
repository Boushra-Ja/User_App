import 'package:b/component/Loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'build_question.dart';

class quizPage extends StatefulWidget {
  final company_Id, chance_Id, company_name, user_Id , image;
  const quizPage(
      {Key key,
      this.company_Id,
      this.chance_Id,
      this.company_name,
      this.user_Id,this.image})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return quizPageState();
  }
}

class quizPageState extends State<quizPage> {
  bool loading = true, Q;
  var questions_List = [], Answer_List = [], coorect_Answer = [], N;

  getQuestions() async {
    await FirebaseFirestore.instance
        .collection('companies')
        .doc(widget.company_Id)
        .collection("chance")
        .doc(widget.chance_Id)
        .get()
        .then((value) {
      if (value.data()['quiz'] == 1) {
        print(11111111111);
        questions_List = value.data()['Q'];
        Answer_List = value.data()['Z'];
        coorect_Answer = value.data()['A'];
        setState(() {
          Q = false;
        });
      } else if (value.data()['quiz'] == 2) {
        print(2222222222);
        Answer_List = ["صح", "خطأ"];
        questions_List = value.data()['Q'];
        coorect_Answer = value.data()['A'];
        setState(() {
          Q = true;
        });
      }

      setState(() {
        N = questions_List.length;
        loading = false;
      });
    });
  }

  @override
  void initState() {
    () async {
      await getQuestions();
    }();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.pink.shade900,
                toolbarHeight: MediaQuery.of(context).size.height / 7,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(70),
                  bottomRight: Radius.circular(70),
                )),
              ),
              body: Container(
                margin: EdgeInsets.all(20),
                child: ListView(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "شركة " +
                          "${widget.company_name}" +
                          " تقدم اختبار قبل التقدم لهذه الفرصة  ",
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    Divider(),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                        "الاختبار مكون من " +
                            "${N}" +
                            (Q == true
                                ? " سؤال صح أو خطأ"
                                : " سؤال اختيار من متعدد") +
                            "......عليك الحصول على نسبة نجاح أعلى من 80% لكي يتم التقدم على هذه الفرصة.",
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Icon(Icons.help_outline,
                          size: (MediaQuery.of(context).size.height / 7)),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                        child: Text("هل انت جاهز للبدأ ؟؟",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.pink.shade700,
                                fontWeight: FontWeight.w500))),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return build_question(
                                    Q: questions_List,
                                    A: Answer_List,
                                    C_A: coorect_Answer,
                                    index: 0,
                                    k: 0,
                                    res: 0,
                                    type_quiz: Q,
                                    company_Id: widget.company_Id,
                                    chance_Id: widget.chance_Id,
                                    user_Id: widget.user_Id,
                                  company_name : widget.company_name,
                                  image : widget.image
                                );
                              }));
                            },
                            child: Container(
                              width: 30,
                              height: 40,
                              child: Center(
                                  child: Text("ابدأ",
                                      style: TextStyle(fontSize: 16))),
                              decoration: BoxDecoration(
                                  color: Colors.yellow.shade600,
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: (){
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              width: 30,
                              height: 40,
                              child: Center(
                                  child: Text("الغاء",
                                      style: TextStyle(fontSize: 16))),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade400,
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ));
  }
}
