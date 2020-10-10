import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skyplight/helper/AppColors.dart';
import 'package:flutter_skyplight/helper/AppConstants.dart';
import 'package:flutter_skyplight/helper/AppSharedPreference.dart';
import 'package:flutter_skyplight/helper/Utility.dart';
import 'package:flutter_skyplight/model/SaveDataInfo.dart';

class RegisterBankingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RegisterBankingState();
  }
}

class RegisterBankingState extends State<RegisterBankingScreen> implements SaveDataInfo{
  final bankController = TextEditingController();
  final accountController = TextEditingController();
  final routingController = TextEditingController();
  bool showLoader = false;bool isRegValid=false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final FocusNode routingFocus = FocusNode();
  final FocusNode accountFocus = FocusNode();
  final FocusNode bankFocus = FocusNode();

  getValues() async{
    var val=await AppSharedPreference().getBankInfo();
    print("@@val"+val.bankName);
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
            child: SingleChildScrollView(
                child: Stack(children: <Widget>[
          Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 45.0, left: 15.0, right: 15.0),
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      AppConstants.register,
                      style: TextStyle(
                        fontSize: 30.0,
                        color: AppColors.colorText,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 18.0, top: 8.0, bottom: 8.0),
                  alignment: Alignment.centerLeft,
                  color: AppColors.grey_50,
                  margin: EdgeInsets.only(top: 10.0),
                  child: Text(
                    AppConstants.bankingInfo.toUpperCase(),
                    style: TextStyle(
                      fontSize: 12.0,
                      color: AppColors.colorText,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                    margin:
                        EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
                    child: Column(children: [
                      Padding(
                        padding:
                            EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                        child: TextField(
                          controller: routingController,
                          textInputAction: TextInputAction.next,
                          focusNode: routingFocus,
                          onChanged: (value){
                            setState(() {
                              AppConstants.routngNum=value;
                              print("@@"+AppConstants.routngNum);

                            });
                          },
                          onSubmitted: (value) {
                            if (value.isNotEmpty) {
                              setState(() {
                                Utility.fieldFocusChange(context, routingFocus, accountFocus);
                              });
                            }
                          },
                          keyboardType: TextInputType.number,
                          cursorColor: AppColors.colorText,
                          obscureText: true,
                          obscuringCharacter: '#',
                          decoration: InputDecoration(
                            focusedBorder: new UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: AppColors.black)),
                            labelStyle: TextStyle(
                                color: AppColors.black,
                                fontSize: 15.0,
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.w300),
                            labelText: AppConstants.routingNo,
                            hasFloatingPlaceholder: true,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                        child: TextField(
                          controller: accountController,
                          textInputAction: TextInputAction.next,
                          focusNode: accountFocus,
                          onChanged: (value){
                            setState(() {
                              AppConstants.accountNum=value;
                              print("@@"+AppConstants.accountNum);

                            });
                          },
                          onSubmitted: (value) {
                            if (value.isNotEmpty) {
                              setState(() {
                                Utility.fieldFocusChange(context, accountFocus, bankFocus);
                              });
                            }
                          },
                          keyboardType: TextInputType.number,
                          cursorColor: AppColors.colorText,
                          obscureText: true,
                          obscuringCharacter: '#',
                          decoration: InputDecoration(
                            focusedBorder: new UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: AppColors.black)),
                            labelStyle: TextStyle(
                                color: AppColors.black,
                                fontSize: 15.0,
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.w300),
                            labelText: AppConstants.accountNumbuer,
                            hasFloatingPlaceholder: true,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                        child: TextField(
                          textInputAction: TextInputAction.done,
                          focusNode: bankFocus,
                          onChanged: (value){
                            setState(() {
                              AppConstants.bankNum=value;
                              print("@@"+AppConstants.bankNum);

                            });
                          },

                          onSubmitted: (term){
                            if (routingController.text == "") {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text(AppConstants.msgEnterFname)));
                            } else if (accountController.text == "") {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text(AppConstants.msgEnterLname)));
                            }else if (bankController.text == "") {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text(AppConstants.msgEnterLname)));
                            }else{
                              AppConstants.isBankInfoCompleted=true;
                              Map map=new Map();
                              map['routingNum']=routingController.text.toString();
                              map['accountNumber']=accountController.text.toString();
                              map['bankName']=bankController.text.toString();
                              String str=jsonEncode(map);
                              print("@@@"+str);
                              AppSharedPreference().saveBankInfo(str);
                              getValues();
                            }
                          },

                          controller: bankController,
                          keyboardType: TextInputType.text,
                          cursorColor: AppColors.colorText,
                          decoration: InputDecoration(
                            focusedBorder: new UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: AppColors.black)),
                            labelStyle: TextStyle(
                                color: AppColors.black,
                                fontSize: 15.0,
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.w300),
                            labelText: AppConstants.bankName,
                            hasFloatingPlaceholder: true,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                    ]))
              ])),
          showLoader
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 1,
                      backgroundColor: AppColors.black,
                    ),
                  ),
                )
              : Container()
        ]))));
  }

  @override
  String dataCollection() {
    // TODO: implement dataCollection
    throw UnimplementedError();
  }

  @override
  void saveBankInfo() {
    // TODO: implement saveBankInfo
    if(isRegValid){
    Map map=new Map();
    map['routingNum']=routingController.text.toString();
    map['accountNumber']=accountController.text.toString();
    map['bankName']=bankController.text.toString();
    String str=jsonEncode(map);
    print("@@@"+str);
    AppSharedPreference().saveBankInfo(str);
    getValues();
  }else{
      print("reg bank !isRegValid");
    }
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
