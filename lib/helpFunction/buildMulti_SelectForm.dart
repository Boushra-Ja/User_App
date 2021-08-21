import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:flutter/material.dart';


class build_MultiSelect extends StatefulWidget{
  int flex_, _selected;
  String text;
  var user ;
  build_MultiSelect(this.flex_, this.text, this._selected , this.user);
  @override
  State<StatefulWidget> createState() {
    return build_MultiSelectState();
  }
}
class build_MultiSelectState extends State<build_MultiSelect>{
  List work_field =[

    {
      "display":'تكنولوجيا المعلومات',
      "value": "تكنولوجيا المعلومات",
    },
    {
      "display": 'العلوم طبيعية',
      "value": 'العلوم طبيعية',
    },
    {
      "display":  'التعليم',
      "value":  'التعليم',
    },
    {
      "display": 'الترجمة',
      "value": "الترجمة",
    },

    {
      "display": "سكرتاريا",
      "value": "سكرتاريا",
    },
    {
      "display": "صحافة",
      "value": "صحافة",
    },
    {
      "display": 'تصيم غرافيكي وتحريك',
      "value": 'تصيم غرافيكي وتحريك',
    },
    {
      "display": "ادارة مشاريع",
      "value": "ادارة مشاريع",
    },
    {
      "display":  "المحاسبة",
      "value":  "المحاسبة",
    },
    {
      "display": "الكيمياء ومخابر",
      "value": "الكيمياء ومخابر",
    },
    {
      "display": "الطب",
      "value": "الطب",
    },
    {
      "display": "الصيدلة",

      "value": "الصيدلة",

    },
    {
      "display": "مطور ألعاب",

      "value": "مطور ألعاب",

    }, {
      "display": "مجالات مختلفة",

      "value": "مجالات مختلفة",

    },
  ];
  List lang = [
    {
      "display": "العربية",

      "value": "العربية",
    },
    {
      "display": "الانكلليزية",

      "value": "الانكليزية",
    },
    {
      "display": "الفرنسية",

      "value": "الفرنسية",
    },
    {
      "display": "الروسية",

      "value": "الروسية",
    },
    {
      "display": "الصينية",

      "value": "الصينية",
    },
    {
      "display": "الألمانية",

      "value": "الألمانية",
    },
    {
      "display": "يابانية",

      "value": "يابانية",
    },

  ];

  List _myActivities = [];
  String _myActivitiesResult = '';
  final formKey = new GlobalKey<FormState>();

  _saveForm() {
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        _myActivitiesResult = _myActivities.toString();
      });
    }
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: widget.flex_,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
        ),
        alignment: AlignmentDirectional.centerStart,
        margin: EdgeInsets.only(left: 5),
        child:  MultiSelectFormField(
          autovalidate: false,
          chipBackGroundColor: Colors.pink.shade900.withOpacity(0.4),
          chipLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
          checkBoxActiveColor: Colors.pink.shade900,
          checkBoxCheckColor: Colors.amber.shade100,
          title: widget._selected == 1 ? Text('مجالات العمل' , textDirection: TextDirection.rtl,) : Text("اللغات" ,textDirection: TextDirection.rtl),
          validator: (value) {
            if(widget._selected == 1) {
              if (value == null || value.length == 0) {
                return 'يمكنك اختيار أكثر من مجال';
              }
            }else if(widget._selected == 2){
              if (value == null || value.length == 0) {
                return 'يمكنك اختيار أكثر من مجال';
              }
            }
            return null;
          },
          dataSource: widget._selected == 1 ? work_field : lang,
          textField: 'display',
          valueField: 'value',
          okButtonLabel: 'OK',
          cancelButtonLabel: 'CANCEL',
          // required: true,
          hintWidget: widget.text == 'true' ? Text("اختر") : null,
          initialValue: (widget.text == 'false' && widget._selected ==1) ?  widget.user.selectedjob : (widget.text == 'false' && widget._selected ==2) ? widget.user.language : [] ,
          onSaved: (value) {
            if(widget._selected == 1) {
              if (value == null) return;
              setState(() {
                widget.user.set_selectedjob(value)  ;
              });
            }else if(widget._selected == 2) {
              if (value == null) return;
              setState(() {
                widget.user.set_language(value)  ;
                print( widget.user.language);
              });
            }
          },
        ),
      ),
    );
  }
}