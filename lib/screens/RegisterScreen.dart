import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skyplight/helper/AppColors.dart';
import 'package:flutter_skyplight/helper/AppConstants.dart';
import 'package:flutter_skyplight/helper/AppDBHelper.dart';
import 'package:flutter_skyplight/helper/AppSharedPreference.dart';
import 'package:flutter_skyplight/helper/Utility.dart';
import 'package:flutter_skyplight/model/SaveDataInfo.dart';
import 'package:flutter_skyplight/model/SliderModel.dart';
import 'package:flutter_skyplight/screens/LoginScreen.dart';
import 'package:flutter_skyplight/screens/RegisterProfileScreen.dart';

import 'RegisterBankingScreen.dart';
import 'RegisterPhotoScreen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RegisterState();
  }
}

class RegisterState extends State<RegisterScreen> implements SaveDataInfo {
  List<SliderModel> mySLides = new List<SliderModel>();
  int slideIndex = 0;
  PageController controller;
  RegisterProfileScreen registerProfileScreen = new RegisterProfileScreen();
  RegisterPhotoScreen registerPhotoScreen = new RegisterPhotoScreen();
  RegisterBankingScreen registerBankingScreen = new RegisterBankingScreen();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mySLides = getSlides();
    controller = new PageController();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Container(
          height: MediaQuery.of(context).size.height - 90,
          child: PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() {
                slideIndex = index;
                slideIndex == 0
                    ? AppConstants.isProfileCompleted ? saveDataToPref() : null
                    : null;
                slideIndex == 1
                    ? AppConstants.isBankInfoCompleted ? saveBankDataToPref() : null
                    : null;
              });
            },
            children: <Widget>[
              RegisterProfileScreen(),
              RegisterBankingScreen(),
              RegisterPhotoScreen(),
//              SlideTile('Register', Icons.arrow_back_ios, 0),
//              SlideTile('Register', Icons.arrow_back_ios, 1),
//              SlideTile('Register', Icons.arrow_back_ios, 2),
            ],
          ),
        ),
        bottomSheet:
//            slideIndex==0?Container(height: 10.0,): InkWell(
//              onTap: () {
//                print("Get Started Now");
//              },
//              child: Container(
//                height: Platform.isIOS ? 70 : 60,
//                alignment: Alignment.center,
//                margin: EdgeInsets.all( 16),
//                decoration: BoxDecoration(
//                    borderRadius:  BorderRadius.all(Radius.circular(6.0)),
//                    color: AppColors.buttonColor
//                ),
//                child: Text(
//                  "DONE",
//                  style: TextStyle(
//                      color: AppColors.colorPrimaryLight, fontWeight: FontWeight.w600),
//                ),
//              ),
//            ),

            slideIndex != 2
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        color: AppColors.buttonColor),
                    child: FlatButton(
                      onPressed: () {
                        slideIndex == 0 ? saveDataToPref() : getValues();
                        slideIndex == 1 ? saveBankDataToPref() : getValues();
                        controller.animateToPage(slideIndex == 0 ? 1 : 2,
                            duration: Duration(milliseconds: 400),
                            curve: Curves.linear);

                      },
                      splashColor: Colors.blue[50],
                      child: Text(
                        "NEXT",
                        style: TextStyle(
                            color: AppColors.colorPrimaryLight,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  )
                : InkWell(
                    onTap: () {
                      print("Get Started Now");

                      saveProfileDataToPref();

                        insertValues();

                    },
                    child: Container(
                      height: Platform.isIOS ? 70 : 60,
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                          color: AppColors.buttonColor),
                      child: Text(
                        "DONE",
                        style: TextStyle(
                            color: AppColors.colorPrimaryLight,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
      ),
    );
  }

  getValues() async {
    var val = await AppSharedPreference().getUserInfo();
    print("@@val" + val.state);
  }

  insertValues() async {
    try {
      var val = await AppSharedPreference().getBankInfo();
      var user = await AppSharedPreference().getUserInfo();
      var profile = await AppSharedPreference().getProfileInfo();
      print("@@val" + val.bankName);

      int i = await AppDBHelper.instance.insertRegister({
        AppDBHelper.columnFirstName: user.firstName,
        AppDBHelper.columnLastName: user.lastName,
        AppDBHelper.columnStreetAddress: user.streetAddress,
        AppDBHelper.columnCity: user.city,
        AppDBHelper.columnState: user.state,
        AppDBHelper.columnPostalCode: user.postalCode,
        AppDBHelper.columnPhoneNumber: user.phoneNumber,
        AppDBHelper.columnEmail: user.email,
        AppDBHelper.columnIdLicense: user.idLicense,
        AppDBHelper.columnRoutingNum: val.routingNum,
        AppDBHelper.columnAccountNumber: val.accountNumber,
        AppDBHelper.columnBankName: val.bankName,
        AppDBHelper.columnUserName: profile.userName,
        AppDBHelper.columnPassword: profile.password,
        AppDBHelper.columnPhoto: AppConstants.photo
      });
      print("$i");
      if (i > 0) {
        Utility.showToast("User registered successfully");
        AppSharedPreference().saveUserName(profile.userName);
        AppConstants.passedName = profile.userName;
        Navigator.pushNamed(context, AppConstants.loginScreen,
            arguments: AppConstants.passedName);
      }
    }catch(e){
     Utility.showToast("error"+e.toString());
    }
  }

  saveDataToPref() {
//    if (isRegValid) {
    Map map = new Map();
    map['firstName'] = AppConstants.fname;
    map['lastName'] = AppConstants.lname;
    map['streetAddress'] = AppConstants.street;
    map['city'] = AppConstants.cityN;
    map['state'] = AppConstants.stateN;
    map['postalCode'] = AppConstants.postal;
    map['phoneNumber'] = AppConstants.phone;
    map['email'] = AppConstants.emailID;
    map['idLicense'] = AppConstants.idLicense;
    String str = jsonEncode(map);
    AppSharedPreference().saveUser(str);
//    } else {
//      print("not valid");
//    }
  }

  saveBankDataToPref() {
//    if (isRegValid) {
    Map map = new Map();
    map['routingNum'] = AppConstants.routngNum;
    map['accountNumber'] = AppConstants.accountNum;
    map['bankName'] = AppConstants.bankNum;
    String str = jsonEncode(map);
    print("@@@" + str);
    AppSharedPreference().saveBankInfo(str);
    getValues();
//    } else {
//      print("not valid");
//    }
  }

  saveProfileDataToPref() {
//    if (isRegValid) {
    Map map = new Map();
    map['userName'] = AppConstants.username;
    map['password'] = AppConstants.pass;
    map['photo'] = AppConstants.photo;
    String str = jsonEncode(map);
    print("@@@" + str);
    AppSharedPreference().saveProfileInfo(str);
//    } else {
//      print("not valid");
//    }
  }

  @override
  String dataCollection() {
    SaveDataInfo();
  }

  @override
  void saveBankInfo() {
    // TODO: implement saveBankInfo
  }

  @override
  void savePersonalInfo() {
    // TODO: implement savePersonalInfo
  }

  @override
  void saveProfileInfo() {
    // TODO: implement saveProfileInfo
  }
}

class SlideTile extends StatelessWidget {
  String title;
  IconData icon;
  int pos = 0;

  SlideTile(this.title, this.icon, this.pos);

  getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new RegisterProfileScreen();
        break;
      case 1:
        return new RegisterBankingScreen();

        break;
      case 2:
        return new RegisterPhotoScreen();
        break;

      default:
        return new Text("Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return getDrawerItemWidget(pos);
  }
}
