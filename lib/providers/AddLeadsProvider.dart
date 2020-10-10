import 'dart:io';

import 'package:flutter/material.dart';

class AddLeadsProvider extends ChangeNotifier {
  String _fiTime = "";
  String _maxOffset;
  File _imageFile;
  String _selectedLeadType;


  setlectedLeadType(String value) {
    _selectedLeadType = value;
    notifyListeners();
  }

  setFiTime(String value) {
    _fiTime = value;
    notifyListeners();
  }

  setMaxOffset(String maxOffset) {
    _maxOffset = maxOffset;
    notifyListeners();
  }
  setImageFile(File file){
    _imageFile=file;
    notifyListeners();
  }

  String get fiTime => _fiTime;
  String get maxOffset => _maxOffset;
  String get selectedLeadType => _selectedLeadType;
  File get imageFile => _imageFile;
}
