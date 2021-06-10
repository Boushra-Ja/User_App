import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../UserInfo.dart';

class buildDropdownButton extends StatefulWidget {
  int flex_, _selected;
  String text;
  buildDropdownButton(this.flex_, this.text, this._selected);
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
    final bloc = Provider.of<userInfo>(context);
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
              ? bloc.selectedDay
              : widget._selected == 2
              ? bloc.selectedMonth
              : widget._selected == 3
              ? bloc.selectedYear
              : widget._selected == 4
              ? bloc.selectedGender
              : widget._selected == 5
              ? bloc.selectedNationality
              : widget._selected == 6
              ? bloc.selectedCountry
              : widget._selected == 7
              ? bloc.selectedCity
              : widget._selected == 8
              ? bloc.selectedEdu
              :widget._selected == 9 ?  bloc.selectedFun : widget._selected == 10 ? bloc.selectedjob : widget._selected == 11 ? bloc.selectedExpr : bloc.selectedTypeJob,
          onChanged: (newValue) {
            widget._selected == 1
                ? bloc.set_selectedDay(newValue)
                : widget._selected == 2
                ? bloc.set_selectedMonth(newValue)
                : widget._selected == 3
                ? bloc.set_selectedYearr(newValue)
                : widget._selected == 4
                ? bloc.set_selectedGender(newValue)
                : widget._selected == 5
                ? bloc.set_selectedNationality(newValue)
                : widget._selected == 6
                ? bloc.set_selectedCountry(newValue)
                : widget._selected == 7
                ? bloc.set_selectedCity(newValue)
                : widget._selected == 8
                ? bloc.set_selectedEdu(newValue)
                : widget._selected == 9 ? bloc.set_selectedFun(newValue) : widget._selected == 10 ? bloc.set_selectedjob(newValue) : widget._selected == 11 ? bloc.set_selectedExpr(newValue) : bloc.set_selectedTypeJob(newValue);
          },
          validator: (val) {
            print("hellloo");
            if (widget._selected == 1) {
              if (bloc.selectedDay == null) return 'مطلوب';
            } else if (widget._selected == 2) {
              if (bloc.selectedMonth == null) return 'مطلوب';
            } else if (widget._selected == 3) {
              if (bloc.selectedYear == null) return 'مطلوب';
            } else if (widget._selected == 4) {
              if (bloc.selectedGender == null) return 'مطلوب';
            } else if (widget._selected == 5) {
              if (bloc.selectedNationality == null) return 'مطلوب';
            } else if (widget._selected == 6) {
              if (bloc.selectedCountry == null) return 'مطلوب';
            } else if (widget._selected == 7) {
              if (bloc.selectedCity == null) return 'مطلوب';
            } else if (widget._selected == 8) {
              if (bloc.selectedEdu == null) return 'مطلوب';
            } else if (widget._selected == 9) {
              if (bloc.selectedFun == null) return 'مطلوب';
            }
            else if (widget._selected == 10) {
              if (bloc.selectedjob == null) return 'مطلوب';
            }
            else if (widget._selected == 11) {
              if (bloc.selectedExpr == null) return 'مطلوب';
            }else{
              if (bloc.selectedTypeJob == null) return 'مطلوب';
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
