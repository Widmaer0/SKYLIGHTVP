import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_skyplight/helper/AppColors.dart';
import 'package:flutter_skyplight/helper/AppConstants.dart';
import 'package:flutter_skyplight/helper/AppDBHelper.dart';
import 'package:flutter_skyplight/helper/AppSharedPreference.dart';

import 'package:flutter_skyplight/helper/UserModel.dart';
import 'package:flutter_skyplight/helper/Utility.dart';

class LoginScreen extends StatefulWidget {
  final String val;

  LoginScreen({Key key, @required this.val}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<LoginScreen> {
  bool _obscureText = true;
  String userName = "";
  final warehouseController = TextEditingController();

  TextEditingController passwordController;

  TextEditingController emailController;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool showLoader = false;
  bool rememberMe = false;

  togglePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  toggleRemeber() {
    setState(() {
      rememberMe = !rememberMe;
    });
  }

  Widget checkbox(String title, bool boolValue) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Checkbox(
          value: boolValue,
          activeColor: AppColors.black,
          onChanged: (bool value) {
            setState(() {
              toggleRemeber();
              boolValue = value;
            });
          },
        ),
        Text(
          title,
          style: TextStyle(fontSize: 14.0, fontFamily: "Quicksand"),
        )
      ],
    );
  }

  Color getToggleButtonColor() {
    if (_obscureText)
      return AppColors.grey;
    else
      return AppColors.colorPrimaryDark;
  }

  getUsername() async {
    String user = await AppSharedPreference().getUserName();
    if (user != null && user != "") {
      userName = user;
    }
  }

  @override
  void initState() {
    super.initState();
    //userName = widget.val;
   /* passwordController = TextEditingController(text: kReleaseMode ?"":"1234567890"  );
    emailController = TextEditingController(text: kReleaseMode ? "":"abc@gmail.com" );*/
    passwordController = TextEditingController(  );
    emailController = TextEditingController();
  }

  Future<bool> onWillPop() {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    getUsername();
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: AppColors.backgroundColor,
        body: WillPopScope(
          onWillPop: onWillPop,
          child: SingleChildScrollView(
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
                            padding: EdgeInsets.only(
                                top: 75.0, left: 10.0, right: 10.0),
                            margin: EdgeInsets.only(
                                top: 10.0, left: 10.0, right: 10.0),
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: new Image.asset(
                              'assets/images/skylight_logo_black.png',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 15.0, left: 10.0, right: 10.0),
                          child: Text(
                            AppConstants.welcome,
                            style: TextStyle(
                              fontSize: 22.0,
                              color: AppColors.colorText,
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Text(
                            userName != null ? userName : "",
                            style: TextStyle(
                              fontSize: 22.0,
                              color: AppColors.black,
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 40.0, left: 10.0, right: 10.0),
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
                          padding: EdgeInsets.only(
                              top: 15.0, left: 10.0, right: 10.0),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(left: 1.0, right: 5.0),
                                child: checkbox(
                                    AppConstants.rememberMe, rememberMe)),
                            Padding(
                              padding: EdgeInsets.only(left: 5.0, right: 5.0),
                              child: Text(
                                AppConstants.forgotPassword,
                                style: TextStyle(
                                    fontSize: 14.0, fontFamily: "Quicksand"),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 30.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                margin:
                                    EdgeInsets.only(left: 15.0, right: 15.0),
                                width: MediaQuery.of(context).size.width,
                                padding:
                                    EdgeInsets.only(left: 15.0, right: 15.0),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6.0)),
                                    color: AppColors.buttonColor),
                                child: FlatButton(
                                  onPressed: () {
                                    if (emailController.text == "") {
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
                                     /* if (kReleaseMode) {
                                        showLoader = true;
                                        login(emailController.text.toString(),
                                            passwordController.text.toString());
                                      } else {
                                        AppConstants.passedName = "Virtual";
                                        AppSharedPreference().saveUserName(
                                            AppConstants.passedName);
                                        Navigator.pushNamed(
                                            context, AppConstants.homeScreen,
                                            arguments: AppConstants.passedName);
                                      }*/
                                      showLoader = true;
                                      login(emailController.text.toString(),
                                          passwordController.text.toString());
                                    }
                                  },
                                  child: Text(
                                    AppConstants.login.toUpperCase(),
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
                                        context, AppConstants.registerScreen);
                                  },
                                  child: RichText(
                                    text: TextSpan(
                                        text: AppConstants.msgNewUser,
                                        style: TextStyle(
                                            color: AppColors.colorText,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Quicksand'),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: AppConstants.signup,
                                              style: TextStyle(
                                                  color: AppColors
                                                      .colorPrimaryLight,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Quicksand'))
                                        ]),
                                  ),
                                ),
                              ),
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
          )),
        ));
  }

  void login(String email, String password) async {
    var reg = AppDBHelper.instance.queryRegisterAll(AppDBHelper.tableRegister);
    print("@@" + reg.toString());
//    if (email == "virtual@gmail.com" && password == "123456") {
//      showLoader = false;
//      AppConstants.passedName = "Virtual";
//      AppSharedPreference().saveUserName(AppConstants.passedName);
//      Navigator.pushNamed(context, AppConstants.homeScreen,
//          arguments: AppConstants.passedName);
//    } else {
    UserModel userModel = await AppDBHelper.instance.getLogin(email, password);
    emailController.text = "";
    passwordController.text = "";
    if (userModel != null) {
      showLoader = false;
      AppConstants.emailID = email;
      AppSharedPreference().saveEmail(email);
      AppConstants.passedName = userModel.name;
      AppSharedPreference().saveUserName(AppConstants.passedName);
      Navigator.pushNamed(context, AppConstants.homeScreen,
          arguments: AppConstants.passedName);
      print("logged in");
      print(AppConstants.passedName);
      AppSharedPreference().isLoggedIn(true);
    } else {
      showLoader = false;
      Utility.showToast("invalid credentials");
    }
    // }
  }
}
