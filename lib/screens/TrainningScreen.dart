import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skyplight/helper/AppColors.dart';
import 'package:flutter_skyplight/helper/AppConstants.dart';

class TrainningScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TrainningState();
  }

}

class TrainningState extends State<TrainningScreen>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          AppConstants.drawerTrainning.toString(),
          style: TextStyle(
              fontSize: 15, color: AppColors.black, fontFamily: 'Quicksand'),
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
      body: Center(
        child: Text(AppConstants.drawerTrainning,textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold ,color:AppColors.colorText ),),
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
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          // margin: EdgeInsets.all(10.0),
                          height: 20.0,
                          alignment: Alignment.topRight,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
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
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 2,
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
                                            Navigator.of(
                                                context, rootNavigator: true)
                                                .pop();

                                            if (index == 0) {
                                              Navigator.pushNamed(
                                                  context,
                                                  AppConstants.turfScreen);
                                            } else if (index ==1) {
                                              Navigator.pushNamed(context,
                                                  AppConstants.connectScreen);
                                            } else if (index ==
                                                2) {
                                              Navigator.pushNamed(
                                                  context,
                                                  AppConstants.flexScreen);
                                            } else if (index ==
                                                3) {
                                              Navigator.pushNamed(
                                                  context,
                                                  AppConstants.leadScreen);
                                            } else if (index ==
                                                4) {
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

}