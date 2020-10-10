import 'package:flutter/material.dart';
import 'package:flutter_skyplight/helper/AppConstants.dart';
import 'package:flutter_skyplight/screens/RegisterBankingScreen.dart';
import 'package:flutter_skyplight/screens/RegisterPhotoScreen.dart';
import 'package:flutter_skyplight/screens/RegisterProfileScreen.dart';

class SliderModel{

  String title;
  IconData icon;

  SliderModel(this.title, this.icon);

//  RegisterProfileScreen registerProfileScreen;
//  RegisterBankingScreen registerBankingScreen;
//  RegisterPhotoScreen registerPhotoScreen;
//
//
//  void setRegisterProfileScreen(RegisterProfileScreen registerProfileScreen){
//    registerProfileScreen = registerProfileScreen;
//  }
//  RegisterProfileScreen getRegisterProfileScreen(){
//    return registerProfileScreen;
//  }
//
//  void setRegisterBankingScreen(RegisterBankingScreen registerBankingScreen){
//    registerBankingScreen = registerBankingScreen;
//  }
//  RegisterBankingScreen getRegisterBankingScreen(){
//    return registerBankingScreen;
//  }



}

List<SliderModel> getSlides() {
  List<SliderModel> slides = new List<SliderModel>();
  final sliderModel = [
    new SliderModel(AppConstants.registerPhotoScreen, Icons.arrow_back_ios),
    new SliderModel(AppConstants.registerBankingScreen, Icons.arrow_back_ios),
    new SliderModel(AppConstants.registerPhotoScreen, Icons.arrow_back_ios),

  ];
  slides.addAll(sliderModel);
  return slides;
}