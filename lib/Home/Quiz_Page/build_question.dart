import 'dart:async';

import 'package:b/Home/ThemeManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'finish_quiz.dart';

class build_question extends StatefulWidget{
  var Q , A , C_A , index , k , res , type_quiz , company_Id , chance_Id , user_Id , company_name , image , chance_name , token ,user_name;
  final Duration timerTastoPremuto;
  build_question({this.Q , this.A , this.C_A , this.index , this.k , this.res , this.type_quiz , this.company_Id , this.chance_Id , this.user_Id,this.timerTastoPremuto , this.company_name , this.image ,this.chance_name ,this.token ,this.user_name});
  @override
  State<StatefulWidget> createState() {
    return build_questionState();
  }
}
class build_questionState extends State<build_question>{
  String ans , check = 'No' ;
  bool win ;
  Timer _timer;
  int _start = 10 , all = 10;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            if(widget.index != widget.Q.length - 1 ) {
              if (widget.type_quiz == false) {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) {
                      return build_question(Q: widget.Q,
                        A: widget.A,
                        C_A: widget.C_A,
                        index: (widget.index + 1),
                        k: (widget.k + 3),
                        res: widget.res,
                        type_quiz: widget.type_quiz,
                        company_Id: widget.company_Id,
                        chance_Id: widget.chance_Id,
                        user_Id: widget.user_Id,
                        chance_name: widget.chance_name,
                        token: widget.token,
                        user_name: widget.user_name,
                      );
                    }));
              } else {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) {
                      return build_question(Q: widget.Q,
                        A: widget.A,
                        C_A: widget.C_A,
                        index: (widget.index + 1),
                        k: widget.k,
                        res: widget.res,
                        type_quiz: widget.type_quiz,
                        company_Id: widget.company_Id,
                        chance_Id: widget.chance_Id,
                        user_Id: widget.user_Id,chance_name: widget.chance_name,
                        token: widget.token,
                        user_name: widget.user_name,);
                    }));
              }
            }else{
              var success_rate = (100 * widget.res) / widget.Q.length;
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) {
                    return finish_Quiz(res: win,
                        result: "${widget.res}/${widget.Q.length}",
                        company_Id: widget.company_Id,
                        chance_Id: widget.chance_Id,
                        user_Id: widget.user_Id,
                        success_rate: success_rate,
                      chacne_name: widget.chance_name,
                      token: widget.token,
                      user_name: widget.user_name,
                    );
                  }));
            }
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    Widget ImmediatelyChange = Container(
      height: 50.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              height: 60.0,
              color: Colors.white,
              child: Center(
                child: Text("سؤال " + "${widget.index + 1}" + " من " + "${widget.Q.length} " + " (${_start} " + "-" + "${all})"),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () async {
                  ////if not finish question and user select answer
                  if (widget.index < widget.Q.length - 1 && check == 'Yes') {
                    /////////if quiz is Multiple-choice
                    if (widget.type_quiz == false &&
                        ans == widget.C_A[widget.index]) {
                      widget.res++;
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                            return build_question(Q: widget.Q,
                              A: widget.A,
                              C_A: widget.C_A,
                              index: (widget.index + 1),
                              k: (widget.k + 3),
                              res: widget.res,
                              type_quiz: widget.type_quiz,
                              company_Id: widget.company_Id,
                              chance_Id: widget.chance_Id,
                              user_Id: widget.user_Id,
                              company_name: widget.company_name,
                              image: widget.image,
                              chance_name: widget.chance_name,
                              token: widget.token,
                              user_name: widget.user_name,
                            );
                          }));
                    }
                    //////////if quiz true or false
                    else {
                      if ((ans == "صح" && widget.C_A[widget.index] == '1') ||
                          (ans == "خطأ" && widget.C_A[widget.index] == '2')) {
                        widget.res ++;
                      }
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                            return build_question(Q: widget.Q,
                              A: widget.A,
                              C_A: widget.C_A,
                              index: (widget.index + 1),
                              k: widget.k,
                              res: widget.res,
                              type_quiz: widget.type_quiz,
                              company_Id: widget.company_Id,
                              chance_Id: widget.chance_Id,
                              user_Id: widget.user_Id,
                              company_name: widget.company_name,
                              image: widget.image,
                              chance_name: widget.chance_name,
                              token: widget.token,
                              user_name: widget.user_name,
                            );
                          }));
                    }
                  }
                  ///////////if user finish question.....check The last question
                  else  if (widget.index == widget.Q.length - 1 && check == 'Yes') {
                    //////if quiz is Multiple-choice
                    if (widget.type_quiz == false &&
                        ans == widget.C_A[widget.index]) {
                      widget.res++;
                    }
                    //////////if quiz true or false
                    else {
                      if ((ans == 'صح' && widget.C_A[widget.index] == '1') ||
                          (ans == 'خطأ' && widget.C_A[widget.index] == '2')) {
                        widget.res ++;
                      }
                    }
                    //////Result test and display
                    if (widget.res >= (widget.Q.length * 80) / 100) {
                      setState(() {
                        win = true;
                      });
                    } else {
                      setState(() {
                        win = false;
                      });
                    }
                    var success_rate = (100 * widget.res) / widget.Q.length;
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) {
                          return finish_Quiz(res: win,
                              result: "${widget.res}/${widget.Q.length}",
                              company_Id: widget.company_Id,
                              chance_Id: widget.chance_Id,
                              user_Id: widget.user_Id,
                              success_rate: success_rate,
                            company_name: widget.company_name,
                            image: widget.image,
                            chacne_name: widget.chance_name,
                            token: widget.token,
                            user_name: widget.user_name,
                          );
                        }));
                  }

              },
              child: Container(
                  width: 20,
                  height: 60.0,
                  color: check == 'Yes' ?Colors.yellow.shade500 : Colors.grey.shade300,
                  child : Center(child:Text( widget.index == widget.Q.length-1 ? "عرض النتيجة" : "التالي" ) )
              ),
            ),
          ),
        ],
      ),
    );

    return Directionality(textDirection: TextDirection.rtl, child: Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeNotifier.mode ? Colors.pink.shade900 : Colors.black87,
          toolbarHeight: MediaQuery.of(context).size.height/7,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(70),
                bottomRight: Radius.circular(70),
              )),
        ),
        body : Container(
          margin: EdgeInsets.all(10),
          child: ListView(
            children: [
              SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey.shade100,
                ),
                width: MediaQuery.of(context).size.width,
                child : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30 , horizontal: 10),
                  child: Text("${widget.index+1}) " + "${widget.Q[widget.index]}" + "؟؟؟؟؟؟؟؟؟؟" , style: TextStyle(color: ThemeNotifier.mode?Colors.black87:Colors.white), ),//
                ),
              ) ,

                  RadioListTile(
                    selected: ans == '${widget.A[widget.k]}' ? true :false,
                    value: "${widget.A[widget.k]}", groupValue: ans, onChanged: (val){
                    setState(() {
                      ans = val ;
                      check = 'Yes';
                    });
                  } ,
                    activeColor: Colors.blue,
                    title: Text("${widget.A[widget.k]}", style: TextStyle(color: ThemeNotifier.mode?Colors.black87:Colors.white)),//${widget.A[0]}
                  ),
                  RadioListTile(
                    selected: ans == '${widget.A[(widget.k+1)]}' ? true :false,
                    value: "${widget.A[(widget.k+1)]}", groupValue: ans, onChanged: (val){
                    setState(() {
                      ans = val ;
                      check = 'Yes';

                    });

                  } ,
                    activeColor: Colors.blue,
                    title: Text("${widget.A[widget.k + 1]}" , style: TextStyle(color: ThemeNotifier.mode?Colors.black87:Colors.white)),//
                  ),
                  widget.type_quiz == false ? RadioListTile(
                    selected: ans == '${widget.A[(widget.k+2)] }' ? true :false,
                    value: "${widget.A[(widget.k+2)] }", groupValue: ans, onChanged: (val){
                    setState(() {
                      ans = val ;
                      check = 'Yes';

                    });
                  } ,
                    title: Text("${widget.A[widget.k + 2]}" , style: TextStyle(color: ThemeNotifier.mode?Colors.black87:Colors.white)),
                  ) : Text(""),
            ],
          ),
        ),
        bottomNavigationBar: ImmediatelyChange
    ));
  }
}
/*

 */