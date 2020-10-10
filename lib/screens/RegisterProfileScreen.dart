import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skyplight/helper/AppColors.dart';
import 'package:flutter_skyplight/helper/AppConstants.dart';
import 'package:flutter_skyplight/helper/AppSharedPreference.dart';
import 'package:flutter_skyplight/helper/Utility.dart';
import 'package:flutter_skyplight/model/RegisterModel.dart';
import 'package:flutter_skyplight/model/SaveDataInfo.dart';

class RegisterProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RegisterProfileState();
  }
}

class RegisterProfileState extends State<RegisterProfileScreen>
    implements SaveDataInfo {
  final idLicenseController = TextEditingController(text:AppConstants.fname);
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final streetController = TextEditingController();
  final postalAddressController = TextEditingController();
  final phoneAddressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool showLoader = false;
  bool isRegValid = false;
  final FocusNode fnameFocus = FocusNode();
  final FocusNode lnameFocus = FocusNode();
  final FocusNode cityFocus = FocusNode();
  final FocusNode streetFocus = FocusNode();
  final FocusNode stateFocus = FocusNode();
  final FocusNode postalFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode licenseFocus = FocusNode();



  getValues() async {
    var val = await AppSharedPreference().getUserInfo();
    print("@@val" + val.state);
  }
//  fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
//    currentFocus.unfocus();
//    FocusScope.of(context).requestFocus(nextFocus);
//  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: AppColors.backgroundColor,
        body: SingleChildScrollView(
            child: Stack(
          children: <Widget>[
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
                    AppConstants.personalInfo.toUpperCase(),
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
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: (MediaQuery.of(context).size.width / 2.3),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 15.0, left: 10.0, right: 5.0),
                              child: TextField(
                                controller: firstNameController,
                                textInputAction: TextInputAction.next,
                                  focusNode: fnameFocus,
                                onChanged: (value){
                                  setState(() {
                                    AppConstants.fname=value;
                                    print("@@"+AppConstants.fname);

                                  });
                                },
                                onSubmitted: (value) {
                                  if (value.isNotEmpty) {
                                    setState(() {
                                        Utility.fieldFocusChange(context, fnameFocus, lnameFocus);
                                    });
                                  }
                                },
                                keyboardType: TextInputType.text,
                                cursorColor: AppColors.colorText,
                                decoration: InputDecoration(
                                  focusedBorder: new UnderlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: AppColors.black)),
                                  labelStyle: TextStyle(
                                      color: AppColors.black,
                                      fontSize: 15.0,
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.w300),
                                  labelText: AppConstants.firstName,
                                  hasFloatingPlaceholder: true,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                              width: (MediaQuery.of(context).size.width / 2.3),
                              child: Padding(
                                padding:
                                    EdgeInsets.only(top: 15.0, right: 10.0),
                                child: TextField(
                                  controller: lastNameController,
                                  focusNode: lnameFocus,
                                  onChanged: (value){
                                    setState(() {
                                      AppConstants.lname=value;
                                      print("@@"+AppConstants.lname);
                                    });
                                  },
                                  onSubmitted: (value) {
                                    if (value.isNotEmpty) {
                                      setState(() {
                                        // RegisterModel().firstName=value;
                                        AppConstants.lname=value;
                                        print("@@"+AppConstants.lname);
                                        Utility.fieldFocusChange(context, lnameFocus, streetFocus);
                                      });
                                    }
                                  },
                                  keyboardType: TextInputType.text,
                                  cursorColor: AppColors.colorText,
                                  decoration: InputDecoration(
                                    focusedBorder: new UnderlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: AppColors.black)),
                                    labelStyle: TextStyle(
                                        color: AppColors.black,
                                        fontSize: 15.0,
                                        fontFamily: 'Quicksand',
                                        fontWeight: FontWeight.w300),
                                    labelText: AppConstants.lastName,
                                    hasFloatingPlaceholder: true,
                                  ),
                                ),
                              ))
                        ],
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                        child: TextField(
                          controller: streetController,
                          focusNode: streetFocus,

                          onSubmitted: (value) {
                            if (value.isNotEmpty) {
                              setState(() {

                                AppConstants.street=value;
                                print("@@"+AppConstants.street);
                                Utility.fieldFocusChange(context, stateFocus, cityFocus);
                              });
                            }
                          },onChanged: (value) {
                            if (value.isNotEmpty) {
                              setState(() {

                                AppConstants.street=value;
                                print("@@"+AppConstants.street);

                              });
                            }
                          },
                          keyboardType: TextInputType.streetAddress,
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
                            labelText: AppConstants.streetAddress,
                            hasFloatingPlaceholder: true,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: (MediaQuery.of(context).size.width / 3.5),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 10.0, left: 10.0, right: 5.0),
                              child: TextField(
                                controller: cityController,
                                focusNode: cityFocus,
                                onSubmitted: (value) {
                                  if (value.isNotEmpty) {
                                    setState(() {
                                      Utility.fieldFocusChange(context, cityFocus, stateFocus);
                                    });
                                  }
                                }, onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    setState(() {

                                      AppConstants.cityN=value;
                                      print("@@"+AppConstants.cityN);

                                    });
                                  }
                                },
                                keyboardType: TextInputType.text,
                                cursorColor: AppColors.colorText,
                                decoration: InputDecoration(
                                  focusedBorder: new UnderlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: AppColors.black)),
                                  labelStyle: TextStyle(
                                      color: AppColors.black,
                                      fontSize: 15.0,
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.w300),
                                  labelText: AppConstants.city,
                                  hasFloatingPlaceholder: true,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                              width: (MediaQuery.of(context).size.width / 3.5),
                              child: Padding(
                                padding:
                                    EdgeInsets.only(top: 10.0, right: 10.0),
                                child: TextField(
                                  controller: stateController,
                                  focusNode: stateFocus,
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      setState(() {
                                        AppConstants.stateN=value;
                                        print("@@"+AppConstants.stateN);

                                      });
                                    }
                                  }, onSubmitted: (value) {
                                    if (value.isNotEmpty) {
                                      setState(() {
                                        Utility.fieldFocusChange(context, stateFocus, postalFocus);
                                      });
                                    }
                                  },
                                  keyboardType: TextInputType.text,
                                  cursorColor: AppColors.colorText,
                                  decoration: InputDecoration(
                                    focusedBorder: new UnderlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: AppColors.black)),
                                    labelStyle: TextStyle(
                                        color: AppColors.black,
                                        fontSize: 15.0,
                                        fontFamily: 'Quicksand',
                                        fontWeight: FontWeight.w300),
                                    labelText: AppConstants.state,
                                    hasFloatingPlaceholder: true,
                                  ),
                                ),
                              )),
                          SizedBox(
                              width: (MediaQuery.of(context).size.width / 3.5),
                              child: Padding(
                                padding:
                                    EdgeInsets.only(top: 10.0, right: 10.0),
                                child: TextField(
                                  focusNode: postalFocus,
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      setState(() {

                                        AppConstants.postal=value;
                                        print("@@"+AppConstants.postal);

                                      });
                                    }
                                  },  onSubmitted: (value) {
                                    if (value.isNotEmpty) {
                                      setState(() {
                                        Utility.fieldFocusChange(context, postalFocus, phoneFocus);
                                      });
                                    }
                                  },
                                  controller: postalAddressController,
                                  keyboardType: TextInputType.text,
                                  cursorColor: AppColors.colorText,
                                  decoration: InputDecoration(
                                    focusedBorder: new UnderlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: AppColors.black)),
                                    labelStyle: TextStyle(
                                        color: AppColors.black,
                                        fontSize: 15.0,
                                        fontFamily: 'Quicksand',
                                        fontWeight: FontWeight.w300),
                                    labelText: AppConstants.postalCode,
                                    hasFloatingPlaceholder: true,
                                  ),
                                ),
                              ))
                        ],
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                        child: TextField(
                          focusNode: phoneFocus,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              setState(() {
                                AppConstants.phone=value;
                                print("@@"+AppConstants.phone);

                              });
                            }
                          }, onSubmitted: (value) {
                            if (value.isNotEmpty) {
                              setState(() {
                                Utility.fieldFocusChange(context, phoneFocus, emailFocus);
                              });
                            }
                          },
                          controller: phoneAddressController,
                          keyboardType: TextInputType.phone,
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
                            labelText: AppConstants.phoneNumber,
                            hasFloatingPlaceholder: true,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                        child: TextField(
                          focusNode: emailFocus,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              setState(() {
                                AppConstants.emailID=value;
                                print("@@"+AppConstants.emailID);

                              });
                            }
                          },onSubmitted: (value) {
                            if (value.isNotEmpty) {
                              setState(() {
                                Utility.fieldFocusChange(context, emailFocus, licenseFocus);
                              });
                            }
                          },
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
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
                            labelText: AppConstants.email,
                            hasFloatingPlaceholder: true,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                        child: TextFormField(
                          textInputAction: TextInputAction.done,
                            focusNode: licenseFocus,
                          onChanged: (term){
                            setState(() {
                              AppConstants.idLicense = term;
                              print("@@" + AppConstants.idLicense);

                            });
                          },
                          onFieldSubmitted: (term) {
                            if (term.isNotEmpty) {


                              if (firstNameController.text == "") {
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                    content: Text(AppConstants.msgEnterFname)));
                              } else if (lastNameController.text == "") {
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                    content: Text(AppConstants.msgEnterLname)));
                              } else if (streetController.text == "") {
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                    content: Text(
                                        AppConstants.msgEnterStreet)));
                              } else if (cityController.text == "") {
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                    content: Text(AppConstants.msgEnterCity)));
                              } else if (stateController.text == "") {
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                    content: Text(AppConstants.msgEnterState)));
                              } else if (postalAddressController.text == "") {
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                    content: Text(
                                        AppConstants.msgEnterPostal)));
                              } else if (phoneAddressController.text == "") {
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                    content: Text(AppConstants.msgEnterPhone)));
                              } else if (emailController.text == "") {
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                    content: Text(AppConstants.msgEnterEmail)));
                              } else if (!Utility.isValidEmail(
                                  emailController.text.trim())) {
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                    content: Text(AppConstants.msgEnterEmail)));
                              } else if (idLicenseController.text == "") {
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                    content:
                                    Text(AppConstants.msgEnterIdorLicense)));
                              } else {
                                AppConstants.isProfileCompleted=true;
//                                 Map map=new Map();
//                                 map['firstName']=firstNameController.text.toString();
//                                 map['lastName']=lastNameController.text.toString();
//                                 map['streetAddress']=streetController.text.toString();
//                                 map['city']=cityController.text.toString();
//                                 map['state']=stateController.text.toString();
//                                 map['postalCode']=postalAddressController.text.toString();
//                                 map['phoneNumber']=phoneAddressController.text.toString();
//                                 map['email']=emailController.text.toString(                             );
//                                 map['idLicense']=idLicenseController.text.toString();
//                                 String str=jsonEncode(map);
//                                 print("@@@"+str);
//                                     streetController.text.toString(),cityController.text.toString(),stateController.text.toString(),
//                                     postalAddressController.text.toString(),phoneAddressController.text.toString(),
//                                     emailController.text.toString(),
//                                     idLicenseController.text.toString() );

//                                isRegValid = true;
//                                saveDataToPref();
//                                getValues();
                              }
                            }
                          },
                          controller: idLicenseController,
                          decoration: InputDecoration(
                              focusedBorder: new UnderlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: AppColors.black)),
                              labelStyle: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 15.0,
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.w300),
                              labelText: AppConstants.idLicenseNo,
                              hasFloatingPlaceholder: true),
                        ),
                      ),

//                           Container(
//                             width: MediaQuery.of(context).size.width,
//                             margin: EdgeInsets.all( 16),
//                             decoration: BoxDecoration(
//                                 borderRadius:  BorderRadius.all(Radius.circular(6.0)),
//                                 color: AppColors.buttonColor
//                             ),
//                             child:
//                             FlatButton(
//                               onPressed: () {
//
//
//                               },
//                               splashColor: Colors.blue[50],
//                               child: Text(
//                                 "NEXT",
//                                 style: TextStyle(
//                                     color: AppColors.colorPrimaryLight,
//                                     fontWeight: FontWeight.w600),
//                               ),
//                             ),
//                           ),
                      SizedBox(
                        height: 90.0,
                      ),
                    ],
                  ),
                ),
              ],
            )),
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
          ],
        )));
  }

  saveDataToPref() {
    if (isRegValid) {
      Map map = new Map();
      map['firstName'] = firstNameController.text.toString();
      map['lastName'] = lastNameController.text.toString();
      map['streetAddress'] = streetController.text.toString();
      map['city'] = cityController.text.toString();
      map['state'] = stateController.text.toString();
      map['postalCode'] = postalAddressController.text.toString();
      map['phoneNumber'] = phoneAddressController.text.toString();
      map['email'] = emailController.text.toString();
      map['idLicense'] = idLicenseController.text.toString();
      String str = jsonEncode(map);

      AppSharedPreference().saveUser(str);
    } else {
      print("not valid");
    }
  }

  @override
  String dataCollection() {}

  @override
  void saveBankInfo() {
    // TODO: implement saveBankInfo
  }

  @override
  void savePersonalInfo() {
    // TODO: implement savePersonalInfo
    saveDataToPref();
  }

  @override
  void saveProfileInfo() {
    // TODO: implement saveProfileInfo
  }
}
