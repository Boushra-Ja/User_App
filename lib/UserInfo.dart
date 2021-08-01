import 'package:flutter/material.dart';

class userInfo with ChangeNotifier{
  String firstName = "null",
      endName = "null",
      mygmail = "null",
      phone = "null",
      selectedGender,
      selectedDay ,
      selectedMonth ,
      selectedYear ,
      selectedCountry ,
      selectedCity ,
      selectedNationality ,
      selectedEdu ,
      selectedFun ,
      selectedExpr ,
      selectedTypeJob ,
      Skills = "null" ,
      workSite ,
      salary ,
      imageurl = 'not',
      typechance,
      previous_job = " ";
  bool  privecy ,
      notify ;


  List selectedjob = [] , language = [];

  set_firstname(String txt){
    this.firstName = txt;
    notifyListeners();
  }
  set_lastname(String txt){
    this.endName= txt;
    notifyListeners();
  }
  set_mygmail(String txt){
    this.mygmail = txt ;
    notifyListeners();

  }

  set_selectedGender(String txt){
    this.selectedGender = txt;
    notifyListeners();

  }
  set_selectedMonth(String txt){
    this.selectedMonth = txt;
    notifyListeners();

  }
  set_selectedYearr(String txt){
    this.selectedYear = txt;
    notifyListeners();

  }
  set_selectedCountry(String txt){
    this.selectedCountry = txt;
    notifyListeners();

  }
  set_selectedDay(String txt){
    this.selectedDay = txt;
    notifyListeners();

  }
  set_selectedCity(String txt){
    this.selectedCity = txt;
    notifyListeners();

  }
  set_selectedNationality(String txt){
    this.selectedNationality = txt;
    notifyListeners();

  }
  set_selectedEdu(String txt){
    this.selectedEdu = txt;
    notifyListeners();

  }

  set_selectedFun(String txt){
    this.selectedFun = txt;
    notifyListeners();

  }

  set_selectedjob(List txt){
    this.selectedjob = txt ;
    notifyListeners();

  }
  set_selectedExpr(String txt){
    this.selectedExpr = txt;
    notifyListeners();

  }
  set_selectedTypeJob(String txt){
    this.selectedTypeJob = txt;
    notifyListeners();

  }
  set_Skills(String txt){
    this.Skills = txt;
    notifyListeners();

  }
  set_workSite(String txt){
    this.workSite = txt;
    notifyListeners();

  }
  set_salary(String txt){
    this.salary = txt;
    notifyListeners();

  }
  set_imageurl(String txt){
    this.imageurl = txt;
    notifyListeners();

  }
  set_previous_job(String txt){
    this.previous_job = txt;
    notifyListeners();

  }

  set_phone(String txt){
    this.phone = txt;
    notifyListeners();
  }
  set_language(List txt){
    this.language = txt ;
    notifyListeners();
  }
  set_typeChance(txt){
    this.typechance = txt;
    notifyListeners();
  }
}




