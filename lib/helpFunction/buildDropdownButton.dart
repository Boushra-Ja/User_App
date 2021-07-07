import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../UserInfo.dart';

class buildDropdownButton extends StatefulWidget {
  int flex_, _selected;
  String text;
  userInfo bloc ;

  buildDropdownButton(this.flex_, this.text, this._selected , this.bloc);
  @override
  State<StatefulWidget> createState() {
    return DropState();
  }
}

class DropState extends State<buildDropdownButton> {
  List<String> _gender = ['ذكر', 'أنثى'];
  List<String> _day = [];
  List<String> _month = [];
  List<String> _year = [];
  List<String> _country = ["سوريا", "العراق", "مصر", "السعودية", "الأردن"];
  List<String> _city = ["دمشق", "حمص", "درعا", "حلب", "حماة", "غير ذلك"];
  List<String> eductionlist = [
    'تعليم ابتدائي',
    'تعليم اعدادي',
    'تعليم ثانوي',
    'شهادة جامعية',
    'شهادة دبلوم',
    'شهادة ماجستير',
    'شهادة دكتوراه',
    'لم أحصل على تعليم'
  ];
  List<String> functionalist = [
    'مبتدئ',
    'فترة تدريب',
    'مساعد',
    'مدير اداري',
    'مدير تنفيذي'
  ];
  List<String> joblist = [
    'تكنولوجيا المعلومات',
    'علوم طبيعية',
    'تدريس',
    'ترجمة ',
    'تصيم غرافيكي وتحريك',
    "سكرتاريا",
    "صحافة",
    "مديرمشاريع",
    "محاسبة",
    "كيمياء ومخابر",
    "طبيب",
    "صيدلة وأدوية",
    "غير ذلك"
  ];
  List<String> experiencelist = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    'اكثر من ذلك'
  ];
  List<String> typeworkList = ['دوام كامل ', 'دوام جزئي', 'تدريب', 'تطوع'];

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
    List<String> temp = widget._selected == 1
        ? _day
        : widget._selected == 2
        ? _month
        : widget._selected == 3
        ? _year
        : widget._selected == 4
        ? _gender
        : widget._selected == 5 || widget._selected == 6
        ? _country
        : widget._selected == 7
        ? _city
        : widget._selected == 8
        ? eductionlist
        : widget._selected == 9 ? functionalist : widget._selected == 10 ? joblist : widget._selected == 11 ? experiencelist : typeworkList;
    return Expanded(
      flex: widget.flex_,
      child: Container(
        alignment: AlignmentDirectional.centerStart,
        margin: EdgeInsets.only(left: 5),
        child: DropdownButtonFormField(
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              contentPadding: EdgeInsets.fromLTRB(10, 0.01, 12, 0.01),
              filled: true,
              fillColor: Colors.white),
          isExpanded: true,
          hint: Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Text(widget.text),
          ),
          value: widget._selected == 1
              ? widget.bloc.selectedDay
              : widget._selected == 2
              ?  widget.bloc.selectedMonth
              : widget._selected == 3
              ?  widget.bloc.selectedYear
              : widget._selected == 4
              ?  widget.bloc.selectedGender
              : widget._selected == 5
              ?  widget.bloc.selectedNationality
              : widget._selected == 6
              ?  widget.bloc.selectedCountry
              : widget._selected == 7
              ?  widget.bloc.selectedCity
              : widget._selected == 8
              ?  widget.bloc.selectedEdu
              :widget._selected == 9 ?   widget.bloc.selectedFun : widget._selected == 10 ?  widget.bloc.selectedjob : widget._selected == 11 ?  widget.bloc.selectedExpr :  widget.bloc.selectedTypeJob,
          onChanged: (newValue) {
            widget._selected == 1
                ?  widget.bloc.set_selectedDay(newValue)
                : widget._selected == 2
                ?  widget.bloc.set_selectedMonth(newValue)
                : widget._selected == 3
                ?  widget.bloc.set_selectedYearr(newValue)
                : widget._selected == 4
                ?  widget.bloc.set_selectedGender(newValue)
                : widget._selected == 5
                ?  widget.bloc.set_selectedNationality(newValue)
                : widget._selected == 6
                ?  widget.bloc.set_selectedCountry(newValue)
                : widget._selected == 7
                ?  widget.bloc.set_selectedCity(newValue)
                : widget._selected == 8
                ?  widget.bloc.set_selectedEdu(newValue)
                : widget._selected == 9 ?  widget.bloc.set_selectedFun(newValue) : widget._selected == 10 ?  widget.bloc.set_selectedjob(newValue) : widget._selected == 11 ?  widget.bloc.set_selectedExpr(newValue) :  widget.bloc.set_selectedTypeJob(newValue);
          },
          validator: (val) {
            print("hellloo");
            if (widget._selected == 1) {
              if ( widget.bloc.selectedDay == null) return 'مطلوب';
            } else if (widget._selected == 2) {
              if ( widget.bloc.selectedMonth == null) return 'مطلوب';
            } else if (widget._selected == 3) {
              if ( widget.bloc.selectedYear == null) return 'مطلوب';
            } else if (widget._selected == 4) {
              if ( widget.bloc.selectedGender == null) return 'مطلوب';
            } else if (widget._selected == 5) {
              if ( widget.bloc.selectedNationality == null) return 'مطلوب';
            } else if (widget._selected == 6) {
              if ( widget.bloc.selectedCountry == null) return 'مطلوب';
            } else if (widget._selected == 7) {
              if ( widget.bloc.selectedCity == null) return 'مطلوب';
            } else if (widget._selected == 8) {
              if ( widget.bloc.selectedEdu == null) return 'مطلوب';
            } else if (widget._selected == 9) {
              if ( widget.bloc.selectedFun == null) return 'مطلوب';
            }
            else if (widget._selected == 10) {
              if ( widget.bloc.selectedjob == null) return 'مطلوب';
            }
            else if (widget._selected == 11) {
              if ( widget.bloc.selectedExpr == null) return 'مطلوب';
            }else{
              if ( widget.bloc.selectedTypeJob == null) return 'مطلوب';
            }
            return null;
          },
          items: temp.map((item) {
            return DropdownMenuItem(
              child: Container(
                  child: Text(
                    item,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                    ),
                  )),
              value: item,
            );
          }).toList(),
        ),
      ),
    );
  }
}
