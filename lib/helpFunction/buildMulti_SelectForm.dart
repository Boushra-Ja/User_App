import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../UserInfo.dart';

class build_MultiSelect extends StatefulWidget{
  int flex_, _selected;
  String text;
  build_MultiSelect(this.flex_, this.text, this._selected);
  @override
  State<StatefulWidget> createState() {
    return build_MultiSelectState();
  }
}
class build_MultiSelectState extends State<build_MultiSelect>{
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
    print(widget.text);
    print(widget._selected);

  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<userInfo>(context) ;
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
          title: Text('مجالات العمل' , textDirection: TextDirection.rtl,),
          validator: (value) {
            if (value == null || value.length == 0) {
              return 'يمكنك اختيار أكثر من مجال';
            }
            return null;
          },
          dataSource: [

            {
              "display":'تكنولوجيا المعلومات',
              "value": "تكنولوجيا المعلومات",
            },
            {
              "display": 'علوم طبيعية',
              "value": 'علوم طبيعية',
            },
            {
              "display":  'تدريس',
              "value":  'تدريس',
            },
            {
              "display": 'ترجمة ',
              "value": 'ترجمة ',
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
              "display": "مديرمشاريع",
              "value": "مديرمشاريع",
            },
            {
              "display":  "محاسبة",
              "value":  "محاسبة",
            },
            {
              "display": "كيمياء ومخابر",
              "value": "كيمياء ومخابر",
            },
            {
              "display": "طبيب",
              "value": "طبيب",
            },
            {
              "display": "صيدلة وأدوية",

              "value": "صيدلة وأدوية",

            },
            {
              "display": "مطور ألعاب",

              "value": "مطور ألعاب",

            }, {
              "display": "غير ذلك",

              "value": "غير ذلك",

            },
          ],
          textField: 'display',
          valueField: 'value',
          okButtonLabel: 'OK',
          cancelButtonLabel: 'CANCEL',
          // required: true,
          hintWidget: widget.text == 'true' ? Text("اختر") : null,
          initialValue: widget.text == 'false ' ? bloc.selectedjob : null,
          onSaved: (value) {
            if (value == null) return ;
            setState(() {
              bloc.set_selectedjob(value)  ;
            });
          },
        ),
      ),
    );
  }
}