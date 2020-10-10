import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skyplight/helper/AppColors.dart';
import 'package:flutter_skyplight/helper/AppConstants.dart';
import 'package:flutter_skyplight/model/LeadModel.dart';
import 'package:flutter_skyplight/providers/LeadsProvider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class LeadsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LeadsState();
  }
}

class LeadsState extends State<LeadsScreen> {
  LeadsProvider leadsProvider;
  TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    leadsProvider = LeadsProvider();
    _searchController = TextEditingController();
    _searchController.addListener(() {
      if (_searchController.text.length > 0) {
        leadsProvider.searchLeads(_searchController.text);
      }
      else
        {
          leadsProvider.getLeads();
        }
    });
    leadsProvider.getLeads();

  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => leadsProvider,
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              title: Text(
                AppConstants.drawerLead.toString(),
                style: TextStyle(
                    fontSize: 15,
                    color: AppColors.black,
                    fontFamily: 'Quicksand'),
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
            body: Consumer<LeadsProvider>(
              builder: (context, provider, child) {
                return Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      /// TOP SEARCH WIDGET
                      _getTopSearchWidget(),

                      /// SEARCH LIST
                      _getLeadsListWidget(provider),

                      /// IF LIST IS EMPTY
                      // _getNoResultWidget()
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  _getTopSearchWidget() {
    return Card(
      elevation: 1,
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
      child: TextFormField(
        controller: _searchController,
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

  _getLeadsListWidget(LeadsProvider provider) {
    return Expanded(
        child: ListView.builder(
      itemBuilder: (context, position) {
        return _getListItem(position, leadsProvider.leadsList[position]);
      },
      itemCount:
          provider.leadsList != null ? leadsProvider.leadsList.length : 0,
    ));
  }

  _getListItem(int position, LeadModel lead) {
    return InkWell(
      child: Card(
        elevation: 0.5,
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Padding(
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: SvgPicture.asset(
                  "assets/images/light_bulb.svg",
                  color: AppColors.colorPrimaryLight,
                  width: 32,
                  height: 32,
                ),
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, left: 12, right: 12),
              ),
              VerticalDivider(
                width: 10,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lead.leadFirstName + " " + lead.leadLastName,
                    style: TextStyle(color: AppColors.black),
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
                          valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.colorPrimaryLight),
                        )),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Approval",
                        style: TextStyle(
                          color: AppColors.black_50,
                          fontSize: 10,
                          fontFamily: 'Quicksand',
                        ),
                      ),
                      Text(
                        "Updated " +
                            DateFormat("MM/dd/yyyy")
                                .format(DateTime.parse(lead.leadCreatedTime)),
                        style: TextStyle(
                          color: AppColors.black_50,
                          fontSize: 10,
                          fontFamily: 'Quicksand',
                        ),
                      ),
                    ],
                  )
                ],
              ))
            ],
          ),
          padding: EdgeInsets.all(15),
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, AppConstants.leadProgressScreen,
            arguments: lead);
      },
    );
  }

  _getNoResultWidget() {
    return Expanded(
        child: Center(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.error,
          size: 48,
          color: AppColors.colorPrimary,
        ),
        SizedBox(
          height: 10,
        ),
        Text("Ooppss.. result not found!")
      ],
    )));
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
}
