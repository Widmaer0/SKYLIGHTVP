import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_skyplight/helper/AppDBHelper.dart';
import 'package:flutter_skyplight/helper/AppSharedPreference.dart';
import 'package:flutter_skyplight/helper/TeamModel.dart';
import 'package:flutter_skyplight/helper/AppColors.dart';
import 'package:flutter_skyplight/helper/AppConstants.dart';
import 'package:flutter_skyplight/helper/Utility.dart';
import 'package:flutter_skyplight/model/RegisterModel.dart';
import 'package:flutter_skyplight/model/RegisterResponseModel.dart';
import 'package:flutter_skyplight/screens/DrawerOverlay.dart';
import 'package:flutter_skyplight/screens/LoginScreen.dart';
import 'package:flutter_skyplight/screens/RegisterBankingScreen.dart';
import 'package:flutter_skyplight/screens/RegisterProfileScreen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatefulWidget {
  final String val;

  HomeScreen({Key key, @required this.val}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  DateTime currentBackPressTime;
  ScrollController scrollController;
  List<Map<String, dynamic>> itemRow;
  File imageFile;
  String city = "";

  String usermame = "";
  List<TeamModel> teamModel = [
    TeamModel("VP", "assets/images/skylight_logo_square.png", true, "GM"),
    TeamModel("VP", "assets/images/skylight_logo_square.png", false, "SL"),
    TeamModel("Add Pro", "", false, "")
    /* TeamModel("Harry", "assets/images/placeholder.jpeg", false, "Pro"),
    TeamModel("Clyde", "assets/images/placeholder.jpeg", false, "Pro")*/
  ];
  final myImageAndCaption = [
    ["assets/images/eva_pin_outline.png", AppConstants.drawerTurf],
    ["assets/images/eva_radio_outline.png", AppConstants.drawerConnect],
    ["assets/images/noun_biceps.png", AppConstants.drawerFlex],
    ["assets/images/eva_briefcase_outline.png", AppConstants.drawerLead],
    ["assets/images/eva_bulb_outline.png", AppConstants.drawerTrainning],
    ["assets/images/eva_settings_sec_outline.png", AppConstants.drawerSettings]
  ];
  List<Color> _colors = [AppColors.colorPrimaryDark, Colors.black];

  //show side menu
  void _showOverlay(BuildContext context) {
    List list = new List();
    list.add(AppConstants.drawerTurf);
    list.add(AppConstants.drawerConnect);
    list.add(AppConstants.drawerFlex);
    list.add(AppConstants.drawerChat);
    list.add(AppConstants.drawerLead);
    list.add(AppConstants.drawerSettings);
    showDialog(
        context: context,
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Dialog(
                backgroundColor: Colors.black.withOpacity(0),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          // margin: EdgeInsets.all(10.0),
                          height: 20.0,
                          alignment: Alignment.topRight,
                          width: MediaQuery.of(context).size.width,
                          child: IconButton(
                            icon: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true).pop();
                              print("@@cross00");
                            },
                          ),
                        ),
                        Container(
                          // margin: EdgeInsets.all(10.0),
                          height: 20.0,
                          alignment: Alignment.topLeft,
                          width: MediaQuery.of(context).size.width,
                          child: IconButton(
                            icon: Icon(
                              Icons.bug_report,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true).pop();
                              print("@@cross00");
                            },
                          ),
                        ),
                        Center(
                            child: Container(
                                margin: EdgeInsets.only(
                                    left: 10.0, right: 10.0, top: 150.0),
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width / 2,
                                child: new ListView.builder(
                                    itemCount: list.length,
                                    itemBuilder:
                                        (BuildContext ctxt, int index) {
                                      return ListTile(
                                          title: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: new Text(
                                              list[index]
                                                  .toString()
                                                  .toUpperCase(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: AppColors.white,
                                                  fontSize: 18.0,
                                                  fontFamily: 'Quicksand',
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          onTap: () {
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop();

                                            if (index == 0) {
                                              Navigator.pushNamed(context,
                                                  AppConstants.turfScreen);
                                            } else if (index == 1) {
                                              Navigator.pushNamed(context,
                                                  AppConstants.connectScreen);
                                            } else if (index == 2) {
                                              Navigator.pushNamed(context,
                                                  AppConstants.flexScreen);
                                            } else if (index == 3) {
                                              Navigator.pushNamed(context,
                                                  AppConstants.leadScreen);
                                            } else if (index == 4) {
                                              Navigator.pushNamed(context,
                                                  AppConstants.leadScreen);
                                            } else if (index == 5) {
                                              Navigator.pushNamed(context,
                                                  AppConstants.settingsScreen);
                                            }

                                            print("@@cross00");
                                          });
                                    }))),
                      ],
                    )))));
  }

  //exit from app
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Utility.showToast("press again to exit!!");
      return Future.value(false);
    }
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    return Future.value(true);
  }

  final String assetName = 'assets/images/back.svg';

  getUsername() async {
    //usermame = await AppSharedPreference().getUserName();
  }

  @override
  void initState() {
    super.initState();

    getUsername();
    getUserData();

  }

  showAlertDialog(BuildContext context) {
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Logout",
              style: TextStyle(fontSize: 13.0, color: AppColors.black)),
          content: Text("Do you want to logout? "),
          actions: <Widget>[
            new FlatButton(
              onPressed: () {
                AppConstants.passedName = "";
                AppSharedPreference().saveUserName("");
                AppSharedPreference().isLoggedIn(false);
                Navigator.of(context, rootNavigator: true).pop();
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                // dismisses only the dialog and returns nothing
              },
              child: new Text('Yes',
                  style: TextStyle(fontSize: 13.0, color: AppColors.black)),
            ),
            new FlatButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true)
                    .pop(); // dismisses only the dialog and returns nothing
              },
              child: new Text('No',
                  style: TextStyle(fontSize: 13.0, color: AppColors.black)),
            ),
          ],
        );
      },
    );
  }

  getUserData() async {
    var user =
        await AppDBHelper.instance.queryRegisterAll(AppDBHelper.tableRegister);
    print("@@user" + user.toList().toString());
    String email = await AppSharedPreference().getEmail();
    if (email != null && email.isNotEmpty) {
      itemRow = await AppDBHelper.instance.querySelectOne(email);

      if (itemRow != null) {
        print("@@itemRow" + itemRow.toList().toString());
        RegisterResponseModel registerResponseModel =
            RegisterResponseModel.fromJson(itemRow[0]);
        print("@@itemRow" + registerResponseModel.email);
        setState(() {
          imageFile = File(registerResponseModel.photo.toString());
          usermame = registerResponseModel.firstName.toString() +
              " " +
              registerResponseModel.lastName.toString();
          city = registerResponseModel.city.toString();
          print(registerResponseModel.userName);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/backgroundimage.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          title: Text(
            AppConstants.home,
            style: TextStyle(fontSize: 14, fontFamily: 'Quicksand'),
          ),
          centerTitle: true,
          backgroundColor: AppColors.colorPrimaryDark,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Image.asset(
                  'assets/images/logout_img.png',
                  color: AppColors.white,
                  height: 22,
                  width: 22,
                ),
                onPressed: () {
                  showAlertDialog(context);
                },
              );
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () {
                _showOverlay(context);
              },
            )
          ],
        ), //app bar of the screen

        body: WillPopScope(
          onWillPop: onWillPop,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12)),
                child: Container(
                  height: _screenSize * 0.32,
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: new ExactAssetImage(
                          'assets/images/backgroundimage.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: 10.0),
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(5.0),
                                child: imageFile != null
                                    ? SizedBox(
                                        width: 68,
                                        height: 68,
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(200),
                                            child: Image.file(
                                              imageFile,
                                              fit: BoxFit.fill,
                                            )))
                                    : CircleAvatar(
                                        radius: 40,
                                        backgroundImage: AssetImage(
                                            'assets/images/placeholder.jpeg'),
                                      ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 5.0,
                                    bottom: 5.0,
                                    left: 15.0,
                                    right: 15.0),
                                child: Text(
                                  usermame != null ? usermame : "",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      color: AppColors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Quicksand'),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: 5.0, left: 15.0, right: 15.0),
                                child: Text(
                                  "position",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      color: AppColors.white,
                                      fontFamily: 'Quicksand'),
                                ),
                              ),
                            ],
                          )),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                              padding: EdgeInsets.only(bottom: 20, top: 5),
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                    AppColors.black_50,
                                    AppColors.black.withOpacity(0.2),
                                    AppColors.black.withOpacity(0.1)
                                  ])),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: EdgeInsets.only(
                                          top: 5.0, left: 15.0, right: 15.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "ProScore",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                color: AppColors.white,
                                                fontFamily: 'Quicksand'),
                                          ),
                                          Text(
                                            "0",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.white,
                                                fontFamily: 'Quicksand'),
                                          ),
                                        ],
                                      )),
                                  Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: EdgeInsets.only(
                                          top: 5.0, left: 15.0, right: 15.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "Market",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                color: AppColors.white,
                                                fontFamily: 'Quicksand'),
                                          ),
                                          Text(
                                            city,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                color: AppColors.white,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Quicksand'),
                                          ),
                                        ],
                                      )),
                                ],
                              )))
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 0.5,
                margin: EdgeInsets.all(15.0),
                child: Container(
                  height: _screenSize * 0.18,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding:
                              EdgeInsets.only(top: 12.0, left: 10.0, bottom: 5),
                          child: new Text(
                            AppConstants.team.toUpperCase(),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: AppColors.colorText,
                                fontSize: 13.0,
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Expanded(
                            child: ListView.builder(
                                itemCount: teamModel.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext ctxt, int index) {
                                  bool addPro =
                                      teamModel[index].userName == "Add Pro"
                                          ? true
                                          : false;

                                  return SizedBox(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Stack(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.all(5.0),
                                            child: SizedBox(
                                                width: (MediaQuery.of(context)
                                                            .  size
                                                            .width /
                                                        5 -
                                                    20),
                                                height: (MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        5 -
                                                    20),
                                                child: addPro
                                                    ? InkWell(
                                                        child: Icon(
                                                            Icons.add_circle,
                                                            size: (MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    5 -
                                                                20)),
                                                        onTap: () {
                                                          _assignProDialog();
                                                        },
                                                      )
                                                    : CircleAvatar(
                                                        radius: 27,
                                                        backgroundColor:
                                                            teamModel[index]
                                                                    .status
                                                                ? AppColors
                                                                    .colorPrimary
                                                                : AppColors
                                                                    .lightRed,
                                                        child: CircleAvatar(
                                                          radius: 27,
                                                          backgroundImage:
                                                              AssetImage(
                                                                  teamModel[
                                                                          index]
                                                                      .image),
                                                        ),
                                                      )),
                                          ),
                                          addPro
                                              ? Container()
                                              : Container(
                                                  margin: EdgeInsets.all(5.0),
                                                  width: (MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          5 -
                                                      20),
                                                  height:
                                                      (MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              5 -
                                                          20),
                                                  child: Center(
                                                    child: Text(
                                                      teamModel[index].reps,
                                                      style: TextStyle(
                                                          fontSize: 13.0,
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          color:
                                                              AppColors.white),
                                                    ),
                                                  ),
                                                  decoration: BoxDecoration(
                                                      color: AppColors
                                                          .colorPrimaryLight
                                                          .withOpacity(0.5),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              400)),
                                                )
                                        ],
                                      ),
                                      Container(
                                          child: new Text(
                                              teamModel[index].userName,
                                              style: TextStyle(
                                                  color: AppColors.colorText,
                                                  fontSize: 13.0,
                                                  fontFamily: 'Quicksand',
                                                  fontWeight:
                                                      FontWeight.w500))),
                                    ],
                                  ));
                                })),
                      ]),
                ),
              ),
              Card(
                elevation: 0.5,
                margin: EdgeInsets.only(left: 15.0, right: 15, top: 5.0),
                child: Container(
                  height: _screenSize * 0.28,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              top: 15.0, left: 20.0, bottom: 8.0),
                          child: new Text(
                            AppConstants.menu.toUpperCase(),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: AppColors.colorText,
                                fontSize: 13.0,
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Expanded(
                          child: GridView.count(
                            crossAxisCount: 3,
                            mainAxisSpacing: 1.0,
                            childAspectRatio: 3 / 2,
                            children: [
                              ...myImageAndCaption.map(
                                (i) => GestureDetector(
                                    child: Padding(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          /* Expanded(child:  SizedBox(width: MediaQuery.of(context).size.width,child: Material(
                                            color: AppColors.black,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5))),
                                            elevation: 3.0,
                                            child: Padding(
                                              padding: EdgeInsets.all(5.0),
                                              child: Image.asset(
                                                i.first,
                                                height: 28,
                                                width: 28,
                                              ),
                                            )))),*/
                                          Expanded(
                                              child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      6,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      6,
                                                  decoration: BoxDecoration(
                                                      color: AppColors.black,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Image.asset(
                                                    i.first,
                                                    width: 20,
                                                    height: 20,
                                                  ))),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          SizedBox(
                                              width: 55,
                                              child: Text(
                                                i.last,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily: 'Quicksand',
                                                    fontSize: 12.0),
                                              )),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                    ),

                                    //on tap navigation of the scrrens
                                    onTap: () {
                                      print(i);
                                      if (i.last == AppConstants.drawerTurf) {
                                        Navigator.pushNamed(
                                            context, AppConstants.turfScreen);
                                      } else if (i.last ==
                                          AppConstants.drawerConnect) {
                                        Navigator.pushNamed(context,
                                            AppConstants.connectScreen);
                                      } else if (i.last ==
                                          AppConstants.drawerFlex) {
                                        Navigator.pushNamed(
                                            context, AppConstants.flexScreen);
                                      } else if (i.last ==
                                          AppConstants.drawerLead) {
                                        Navigator.pushNamed(
                                            context, AppConstants.leadScreen);
                                      } else if (i.last ==
                                          AppConstants.drawerTrainning) {
                                        Navigator.pushNamed(context,
                                            AppConstants.trainningScreen);
                                      } else if (i.last ==
                                          AppConstants.drawerSettings) {
                                        Navigator.pushNamed(context,
                                            AppConstants.settingsScreen);
                                      }
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _assignProDialog() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
              padding: EdgeInsets.only(top: 20,bottom:  20),
              child: Wrap(
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text("Assign Pro",
                          style: TextStyle(
                              color: AppColors.black,
                              fontSize: 18.0,
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.w500))),
                  Container(
                    height: 20,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      radius: 27,
                      backgroundImage:
                          AssetImage("assets/images/placeholder.jpeg"),
                    ),
                    title: Text("Steve Smith"),
                    onTap: (){Navigator.pop(context);},
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      radius: 27,
                      backgroundImage:
                          AssetImage("assets/images/placeholder.jpeg"),
                    ),
                    title: Text("Harry Name"),
                    onTap: (){Navigator.pop(context);},
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      radius: 27,
                      backgroundImage:
                          AssetImage("assets/images/placeholder.jpeg"),
                    ),
                    title: Text("Amy Jackson"),
                    onTap: (){Navigator.pop(context);},
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      radius: 27,
                      backgroundImage:
                          AssetImage("assets/images/placeholder.jpeg"),
                    ),
                    title: Text("Kavin Peterson"),
                    onTap: (){Navigator.pop(context);},
                  ),
                ],
              ));
        });
  }
}
