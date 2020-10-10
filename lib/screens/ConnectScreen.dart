import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skyplight/helper/AppColors.dart';
import 'package:flutter_skyplight/helper/AppConstants.dart';
import 'package:flutter_svg/svg.dart';

class ConnectScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ConnectState();
  }
}

class ConnectState extends State<ConnectScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
//              IconButton(
//                icon: const Icon(
//                  Icons.chat_bubble_outline,
//                  color: AppColors.black,
//                  size: 20,
//                ),
//                onPressed: () {
//                  Navigator.pop(context);
//                },
//              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  AppConstants.drawerConnect.toString(),
                  style: TextStyle(
                      fontSize: 15,
                      color: AppColors.black,
                      fontFamily: 'Quicksand'),
                ),
              )
            ],
          ),
        ),
        backgroundColor: AppColors.backgroundColor,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.black,
                size: 20,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
        actions: [
          IconButton(
              padding: EdgeInsets.only(right: 2),
              icon: Icon(
                Icons.camera_alt,
                color: AppColors.black,
                size: 20,
              ),
              onPressed: () {}),
          IconButton(
              padding: EdgeInsets.only(right: 10),
              icon: Icon(
                Icons.menu,
                color: AppColors.black,
                size: 20,
              ),
              onPressed: () {
                _showOverlay(context);
              })
        ],
      ),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            /// TOP SEARCH WIDGET
            _getTopSearchWidget(),

            /// SEARCH LIST
            _getLeadsListWidget(),

            /// IF LIST IS EMPTY
            // _getNoResultWidget()
          ],
        ),
      ),
    );
  }

  void _showOverlay(BuildContext context) {
//    Navigator.of(context).push(DrawerOverlay());

    List list = new List();
    list.add(AppConstants.drawerTurf);
    list.add(AppConstants.drawerConnect);
    list.add(AppConstants.drawerFlex);
    list.add(AppConstants.drawerChat);
    list.add("Home");
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
                                              Navigator.pop(context);
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

  _getTopSearchWidget() {
    return Card(
      elevation: 1,
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
      child: TextFormField(
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: AppColors.black,
          ),
          hintText: "Search",
          hintStyle: TextStyle(color: AppColors.black),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
        onFieldSubmitted: (value) {
          /// SEARCH LOGIC
        },
      ),
    );
  }

  _getLeadsListWidget() {
    return Expanded(
        child: ListView.builder(
      itemBuilder: (context, position) {
        return _getListItem(position);
      },
      itemCount: 3,
    ));
  }

  _getListItem(int position) {
    return Card(
      elevation: 0.5,
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Container(
          height: 320.0,
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                      padding:
                          EdgeInsets.only(top: 5, bottom: 5, left: 6, right: 6),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          "assets/images/placeholder.jpeg",
                          width: 42,
                          height: 42,
                          fit: BoxFit.fill,
                        ),
                      )),
                  VerticalDivider(
                    width: 5,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Christian Collins ",
                        style: TextStyle(color: AppColors.black),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        "54 mins ago ",
                        style: TextStyle(
                            color: AppColors.colorText, fontSize: 12.0),
                      ),
                    ],
                  )),
                  Container(
                      padding:
                          EdgeInsets.only(top: 5, bottom: 5, left: 8, right: 8),
                      decoration: BoxDecoration(
                          color: AppColors.black,
                          borderRadius: BorderRadius.all(Radius.circular(7))),
                      child: Expanded(
                          child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/images/chat.svg",
                            color: AppColors.colorPrimaryLight,
                            width: 18,
                            height: 15,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            "Chat ",
                            style: TextStyle(
                                color: AppColors.colorPrimaryLight,
                                fontSize: 12.0),
                          ),
                        ],
                      ))),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                  margin: EdgeInsets.only(left: 5.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Solar panels are always the way you go. ",
                    style: TextStyle(color: AppColors.black),
                  )),
              SizedBox(
                height: 2,
              ),
              Container(
                margin: EdgeInsets.only(left: 5.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  "#solar #panels, #vicotrypower",
                  style: TextStyle(
                      color: AppColors.colorPrimaryLight, fontSize: 14.0),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                  padding:
                      EdgeInsets.only(top: 10, bottom: 10, left: 12, right: 12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      "assets/images/solarpanel.jpeg",
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 150.0,
                      fit: BoxFit.fill,
                    ),
                  )),
            ],
          )),
    );
  }

  _getListItemMultiple(int position) {
    return Card(
      elevation: 0.5,
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                      padding:
                          EdgeInsets.only(top: 5, bottom: 5, left: 6, right: 6),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          "assets/images/placeholder.jpeg",
                          width: 42,
                          height: 42,
                          fit: BoxFit.fill,
                        ),
                      )),
                  VerticalDivider(
                    width: 5,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Christian Collins ",
                        style: TextStyle(color: AppColors.black),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        "54 mins ago ",
                        style: TextStyle(
                            color: AppColors.colorText, fontSize: 12.0),
                      ),
                    ],
                  )),
                  Container(
                      padding:
                          EdgeInsets.only(top: 5, bottom: 5, left: 8, right: 8),
                      decoration: BoxDecoration(
                          color: AppColors.black,
                          borderRadius: BorderRadius.all(Radius.circular(7))),
                      child: Expanded(
                          child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/images/chat.svg",
                            color: AppColors.colorPrimaryLight,
                            width: 18,
                            height: 15,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            "Chat ",
                            style: TextStyle(
                                color: AppColors.colorPrimaryLight,
                                fontSize: 12.0),
                          ),
                        ],
                      ))),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                child: Row(
                  children: [
                    Container(
                        padding: EdgeInsets.only(
                            top: 10, bottom: 10, left: 12, right: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            "assets/images/solarpanel.jpeg",
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: 80.0,
                            fit: BoxFit.fill,
                          ),
                        )),
                    Container(
                        padding: EdgeInsets.only(
                            top: 10, bottom: 10, left: 12, right: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            "assets/images/solarpanel.jpeg",
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: 80.0,
                            fit: BoxFit.fill,
                          ),
                        )),
                    Container(
                        padding: EdgeInsets.only(
                            top: 10, bottom: 10, left: 12, right: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            "assets/images/solarpanel.jpeg",
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: 80.0,
                            fit: BoxFit.fill,
                          ),
                        )),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
