import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'finish_quiz.dart';

class build_question extends StatefulWidget{
  var Q , A , C_A , index , k , res , type_quiz , company_Id , chance_Id , user_Id;
  build_question({this.Q , this.A , this.C_A , this.index , this.k , this.res , this.type_quiz , this.company_Id , this.chance_Id , this.user_Id});
  @override
  State<StatefulWidget> createState() {
    return build_questionState();
  }
}
class build_questionState extends State<build_question>{
  String ans , check = 'No' ;
  bool win ;

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
                child: Text("سؤال " + "${widget.index + 1}" + " من " + "${widget.Q.length}"),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () async {
                ////if not finish question and user select answer
                if(widget.index < widget.Q.length - 1 && check == 'Yes')
                {
                  /////////if quiz is Multiple-choice
                  if(widget.type_quiz == false && ans == widget.C_A[widget.index]){
                      widget.res++;
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                        return build_question(Q: widget.Q , A : widget.A , C_A: widget.C_A , index: (widget.index + 1), k : (widget.k + 3) , res: widget.res , type_quiz: widget.type_quiz,company_Id: widget.company_Id,chance_Id: widget.chance_Id,user_Id: widget.user_Id,) ;
                      }));
                  }
                  //////////if quiz true or false
                  else{
                    if((ans == "صح" && widget.C_A[widget.index]=='1') || (ans == "خطأ" && widget.C_A[widget.index]=='2'))
                      {
                        widget.res ++;
                      }
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                      return build_question(Q: widget.Q , A : widget.A , C_A: widget.C_A , index: (widget.index + 1), k : widget.k , res: widget.res , type_quiz: widget.type_quiz ,company_Id: widget.company_Id,chance_Id: widget.chance_Id,user_Id: widget.user_Id,) ;
                    }));
                  }
                }
                ///////////if user finish question.....check The last question
                else if(widget.index == widget.Q.length - 1 && check == 'Yes'){

                  //////if quiz is Multiple-choice
                  if(widget.type_quiz == false && ans == widget.C_A[widget.index]){
                    widget.res++;
                  }
                  //////////if quiz true or false
                  else{
                    if((ans == 'صح' && widget.C_A[widget.index]=='1') || (ans == 'خطأ' && widget.C_A[widget.index]=='2'))
                    {
                      widget.res ++;
                    }
                  }
                  //////Result test and display
                  if(widget.res >= (widget.Q.length*80)/100)
                    {
                      setState(() {
                        win = true ;
                      });
                    }else{
                    setState(() {
                      win = false;
                    });
                  }
                  var success_rate = (100*widget.res)/widget.Q.length;

                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                    return finish_Quiz(res : win , result : "${widget.res}/${widget.Q.length}" , company_Id : widget.company_Id , chance_Id : widget.chance_Id , user_Id : widget.user_Id , success_rate : success_rate);
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
          backgroundColor: Colors.pink.shade900,
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
                  child: Text("${widget.index+1}) " + "${widget.Q[widget.index]}" + "؟؟؟؟؟؟؟؟؟؟" ),//
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
                    title: Text("${widget.A[widget.k]}"),//${widget.A[0]}
                  ),
                  RadioListTile(
                    selected: ans == '${widget.A[(widget.k+1)]}' ? true :false,
                    value: "${widget.A[(widget.k+1)]}", groupValue: ans, onChanged: (val){
                    setState(() {
                      ans = val ;
                      check = 'Yes';

                    });

                  } ,
                    title: Text("${widget.A[widget.k + 1]}"),//
                  ),
                  widget.type_quiz == false ? RadioListTile(
                    selected: ans == '${widget.A[(widget.k+2)] }' ? true :false,
                    value: "${widget.A[(widget.k+2)] }", groupValue: ans, onChanged: (val){
                    setState(() {
                      ans = val ;
                      check = 'Yes';

                    });
                  } ,
                    title: Text("${widget.A[widget.k + 2]}"),
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