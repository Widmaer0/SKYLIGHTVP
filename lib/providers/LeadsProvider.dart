import 'package:flutter/material.dart';
import 'package:flutter_skyplight/helper/AppDBHelper.dart';
import 'package:flutter_skyplight/model/LeadModel.dart';

class LeadsProvider extends ChangeNotifier {
  List<LeadModel> _leadsList;

  getLeads() async {
    _leadsList = await AppDBHelper.instance.getLeads();

    print("Leads found" + _leadsList.length.toString());
    notifyListeners();
  }
  searchLeads(String text) async{

    _leadsList = await AppDBHelper.instance.searchLeads(text);

    print("Leads found" + _leadsList.length.toString());
    notifyListeners();

  }




 List<LeadModel> get leadsList => _leadsList;

}
