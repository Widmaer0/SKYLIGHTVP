import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_skyplight/helper/AppColors.dart';
import 'package:flutter_skyplight/helper/AppConstants.dart';
import 'package:flutter_skyplight/helper/AppDBHelper.dart';
import 'package:flutter_skyplight/helper/AppSharedPreference.dart';
import 'package:flutter_skyplight/helper/Utility.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SignupState();
  }
}

class SignupState extends State<SignupScreen> {
  bool _obscureText = true;
  String userLanguage = "";

  final passwordController = TextEditingController();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool showLoader = false;

  togglePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Color getToggleButtonColor() {
    if (_obscureText)
      return AppColors.grey;
    else
      return AppColors.colorPrimaryDark;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              );
            },
          ),
          backgroundColor: AppColors.backgroundColor,
          centerTitle: true,
          title: Text(
            AppConstants.signup,
            style: TextStyle(
              fontSize: 20.0,
              color: AppColors.colorText,
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        key: _scaffoldKey,
        backgroundColor: AppColors.backgroundColor,
        body: SingleChildScrollView(
            child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                  margin: EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 40.0, left: 10.0, right: 10.0),
                          width: MediaQuery.of(context).size.width / 2,
                          child: new Image.asset(
                            'assets/images/skylight_logo_black.png',
                          ),
                        ),
                      ),


                      Padding(
                        padding:
                            EdgeInsets.only(top: 40.0, left: 10.0, right: 10.0),
                        child: TextField(
                          controller: userNameController,
                          keyboardType: TextInputType.text,
                          cursorColor: AppColors.colorText,
                          decoration: InputDecoration(
                            focusedBorder: new UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: AppColors.black)),
                            labelStyle: TextStyle(
                                color: AppColors.black,
                                fontSize: 17.0,
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.w300),
                            labelText: AppConstants.userName,
                            hasFloatingPlaceholder: true,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                        child: TextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: AppColors.colorText,
                          decoration: InputDecoration(
                            focusedBorder: new UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: AppColors.black)),
                            labelStyle: TextStyle(
                                color: AppColors.black,
                                fontSize: 17.0,
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
                          maxLength: 10,
                          controller: passwordController,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            focusedBorder: new UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: AppColors.black)),
                            labelStyle: TextStyle(
                                color: AppColors.black,
                                fontSize: 17.0,
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.w300),
                            labelText: AppConstants.password,
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.remove_red_eye,
                                color: getToggleButtonColor(),
                              ),
                              onPressed: () {
                                togglePassword();
                              },
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(top: 30.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 15.0, right: 15.0),
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.only(left: 15.0, right: 15.0),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6.0)),
                                  color: AppColors.buttonColor),
                              child: FlatButton(
                                onPressed: () {
                                  if (userNameController.text == "") {
                                    _scaffoldKey.currentState.showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                AppConstants.msgEnterEmail)));
                                  } else if (emailController.text == "") {
                                    _scaffoldKey.currentState.showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                AppConstants.msgEnterEmail)));
                                  } else if (!Utility.isValidEmail(
                                      emailController.text.toString())) {
                                    _scaffoldKey.currentState.showSnackBar(
                                        SnackBar(
                                            content: Text(AppConstants
                                                .msgEnterValidEmail)));
                                  } else if (passwordController.text == "") {
                                    _scaffoldKey.currentState.showSnackBar(
                                        SnackBar(
                                            content: Text(AppConstants
                                                .msgEnterPassword)));
                                  } else if (passwordController.text.length <
                                      6) {
                                    _scaffoldKey.currentState.showSnackBar(
                                        SnackBar(
                                            content: Text(AppConstants
                                                .msgEnterValidPassword)));
                                  } else {
                                    signUp(userNameController.text.toString(), emailController.text.toString(),
                                        passwordController.text.toString(), "success");
                                  }
                                },
                                child: Text(
                                  AppConstants.signup.toUpperCase(),
                                  style: TextStyle(
                                      color: AppColors.colorPrimaryLight,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                color: Colors.transparent,
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    top: 50.0, left: 10.0, right: 10.0),
                                child: FlatButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, AppConstants.loginScreen);
                                  },
                                  child: RichText(
                                    text: TextSpan(
                                        text:
                                            AppConstants.msgAlreadyHaveAccount,
                                        style: TextStyle(
                                            color: AppColors.colorText,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Quicksand'),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: AppConstants.login,
                                              style: TextStyle(
                                                  color: AppColors
                                                      .colorPrimaryLight,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Quicksand'))
                                        ]),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
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

  void signUp(
      String username, String email, String password, String status) async {
    int i = await AppDBHelper.instance.insert({
      AppDBHelper.columnId: 1,
      AppDBHelper.columnUserName: username,
      AppDBHelper.columnEmail: email,
      AppDBHelper.columnPassWord: password,
      AppDBHelper.columnStatus: status,
    });
    if (i > 0) {
      AppSharedPreference().saveUserName(username);
      AppConstants.passedName=username;
      Navigator.pushNamed(context, AppConstants.loginScreen, arguments: AppConstants.passedName);

    }
    print("inserted");
    print("$i");
  }
}
