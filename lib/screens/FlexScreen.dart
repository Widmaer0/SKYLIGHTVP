import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skyplight/helper/AppColors.dart';
import 'package:flutter_skyplight/helper/AppConstants.dart';

class FlexScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FlexState();
  }
}

class FlexState extends State<FlexScreen> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 5, vsync: this);
    super.initState();
  }

  double itemWidth = 0;
  double itemHeight = 0;

  @override
  Widget build(BuildContext context) {
    itemWidth = (MediaQuery.of(context).size.width / 2) - 15;
    itemHeight = (MediaQuery.of(context).size.width / 2) - 55;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          AppConstants.drawerFlex.toString(),
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
        bottom: TabBar(
          tabs: [
            Tab(
              text: "Daily",
            ),
            Tab(
              text: "Weekly",
            ),
            Tab(
              text: "Monthly",
            ),
            Tab(
              text: "Quarterly",
            ),
            Tab(
              text: "Yearly",
            )
          ],
          controller: _tabController,
          labelColor: AppColors.black,
          unselectedLabelColor: AppColors.black.withOpacity(0.2),
          indicatorColor: AppColors.colorPrimaryLight,
          indicatorSize: TabBarIndicatorSize.tab,
          isScrollable: true
        ),
        bottomOpacity: 1,
      ),
      body: TabBarView(
        children: [
          _flexDataScreen(),
          _flexDataScreen(),
          _flexDataScreen(),
          _flexDataScreen(),
          _flexDataScreen(),
        ],
        controller: _tabController,
      ),
    );
  }

  _flexDataScreen() {
    return SingleChildScrollView(
        child: Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          /// TOP WIDGET
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            childAspectRatio: (itemWidth / itemHeight),
            children: <Widget>[
              _topboxWidgetItem("SIGNED DEALS", "\$0"),
              _topboxWidgetItem("APPROVED DEALS", "0"),
              _topboxWidgetItem("INSTALLATIONS", "0"),
              _topboxWidgetItem("KILOWATTS", "0"),
            ],
          ),

          /// SQUAD LEADER WIDGET
          _squadLeaderWidget(),

          /// TEAM OVERVIEW WIDGET
          _teamOverviewWidget(),

          /// WATCHLIST WIDGET
         // _watchListWidget()
        ],
      ),
    ));
  }

  _topboxWidgetItem(String text1, String text2) {
    return Card(
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text1,
              style: TextStyle(fontSize: 12, fontFamily: 'Quicksand'),
            ),
            Text(
              text2,
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Quicksand'),
            ),
          ],
        ),
      ),
    );
  }

  _squadLeaderWidget() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
      child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Squad Leader",
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "50 days left",
                    style: TextStyle(fontSize: 12, fontFamily: 'Quicksand'),
                  ),
                ],
              ),
              _squadLeaderWidgetItems(
                  "COLLECTIVE CONTRACTS", "0 of 50", "0% completed"),
              _squadLeaderWidgetItems(
                  "TOTAL RECRUITS", "0 of 5", "0% completed"),
              _squadLeaderWidgetItems(
                  "CONTRACT AVERAGE", "0 of 5", "0% completed"),
            ],
          )),
    );
  }

  _squadLeaderWidgetItems(String text1, String text2, String text3) {
    return Column(
      children: [
        Divider(
          height: 20,
          color: AppColors.white,
        ),
        Text(
          text1,
          style: TextStyle(color: AppColors.black, fontSize: 12),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 10,
          child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: LinearProgressIndicator(
                backgroundColor: AppColors.black_50.withOpacity(0.05),
                value: 0,
                valueColor:
                    AlwaysStoppedAnimation<Color>(AppColors.colorPrimaryLight),
              )),
        ),
        SizedBox(
          height: 4,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text2,
              style: TextStyle(
                color: AppColors.black_50,
                fontSize: 10,
                fontFamily: 'Quicksand',
              ),
            ),
            Text(
              text3,
              style: TextStyle(
                color: AppColors.black_50,
                fontSize: 10,
                fontFamily: 'Quicksand',
              ),
            ),
          ],
        )
      ],
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }

  _teamOverviewWidget() {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
        child: Container(
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Team Overview",
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w500),
              ),
              Text(
                "New York",
                style: TextStyle(fontSize: 12, fontFamily: 'Quicksand'),
              ),
            ],
          ),
          _teamOverviewWidgetItem("Team ProScore", "NYC Market", "0"),
          _teamOverviewWidgetItem("Leads", "NYC Market", "#"),
          _teamOverviewWidgetItem("Contracts", "NYC Market", "#"),
          _teamOverviewWidgetItem("Installs", "NYC Market", "#")
        ],
      ),
    ));
  }

  _teamOverviewWidgetItem(String text1, String text2, String text3) {
    return Column(
      children: [
        Divider(
          height: 20,
          color: AppColors.white,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text1,
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  text2,
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Quicksand',
                  ),
                ),
              ],
              mainAxisSize: MainAxisSize.min,
            ),
            Text(
              text3,
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w500),
            ),
          ],
        )
      ],
      mainAxisSize: MainAxisSize.min,
    );
  }

  _watchListWidget() {

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Watchlist",
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w500),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, position) {
                if (position == 0) {
                  return Padding(padding: EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),child: Row(children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.person,size: 34,),
                        SizedBox(height: 8,),
                        Text(
                          "Bruce Rodgers",
                          style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.person,size: 32,),
                        Text(
                          "Laura Todd",
                          style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    )
                  ], mainAxisAlignment: MainAxisAlignment.spaceBetween));
                } else {

                  var item=_getWatchListItemText(position);

                  return Padding(padding: EdgeInsets.only(top: 10),child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        item[0],
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        item[1],
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: 'Quicksand',
                        ),
                      ),
                      Text(
                        item[2],
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ));
                }
              },
              itemCount: 5,
            )
          ],
          mainAxisSize: MainAxisSize.min,
        ),
      ),
    );
  }

  _getWatchListItemText(int position)
  {
  switch(position)
  {
    case 1 : return ["2.5","ProScore","2.5"];
    case 2 : return ["6","Leads","8"];
    case 3 : return ["3","Contracts","4"];
    case 4 : return ["6","Installs","6"];

  }
  }


  void _showOverlay(BuildContext context) {
//    Navigator.of(context).push(DrawerOverlay());

    List list = new List();
    list.add(AppConstants.drawerTurf);
    list.add(AppConstants.drawerConnect);
    list.add("Home");
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
                                              Navigator.pop(context);
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
}
