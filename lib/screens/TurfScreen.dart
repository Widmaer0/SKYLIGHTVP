import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skyplight/helper/AppColors.dart';
import 'package:flutter_skyplight/helper/AppConstants.dart';
import 'package:flutter_skyplight/helper/DPAAMenuWidget.dart';
import 'package:flutter_skyplight/providers/AddLeadsProvider.dart';
import 'package:flutter_skyplight/providers/TurfProvider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';

import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:provider/provider.dart';

class TurfScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TurfState();
  }
}

class TurfState extends State<TurfScreen> {
  static const String ACCESS_TOKEN =
      "pk.eyJ1Ijoic3dvb3B3aWQiLCJhIjoiY2tmaWo2NmxiMGZkNDJ1cG03MjUwNDVqZSJ9.qdIn2NZHDfh_ooJMHfPp2g";

  _onMapCreated(MapboxMapController mapController) {
    /*mapController.addSymbols([
      SymbolOptions(
          geometry: currentLatLng, iconImage: "airport-15", iconSize: 3),
      SymbolOptions(
          geometry: LatLng(28.5355, 77.3915), iconImage: "airport-15"),
      SymbolOptions(
          geometry: LatLng(28.5355, 77.3920), iconImage: "airport-15"),
      SymbolOptions(geometry: LatLng(28.5355, 77.3925), iconImage: "airport-15")
    ]);*/
  }

  _onMapClick(Point<double> point, LatLng coordinates) {
    /*_scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text("Map click is fine")));
*/

    showMapBottomSheet();
  }

  _onStyleLoaded() {}

  TurfProvider turfProvider;
  LatLng currentLatLng;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  bool showBottomSnackBar = false;

  @override
  void initState() {
    super.initState();
    turfProvider = TurfProvider();
    turfProvider.getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => turfProvider,
      child: Builder(
        builder: (context) {
          return Scaffold(
            key: _scaffoldKey,
            body: Consumer<TurfProvider>(
              builder: (context, provider, child) {
                if (provider.currentLocation != null)
                  currentLatLng = provider.currentLocation;

                return Stack(
                  children: [
                    provider.currentLocation != null
                        ? MapboxMap(
                            onStyleLoadedCallback: _onStyleLoaded,
                            styleString: provider.getMapStyleString == null
                                ? MapboxStyles.MAPBOX_STREETS
                                : provider.getMapStyleString,
                            onMapClick: _onMapClick,
                            myLocationEnabled: true,
                            onMapCreated: _onMapCreated,
                            initialCameraPosition: CameraPosition(
                                target: provider.currentLocation, zoom: 11.0),
                            accessToken: ACCESS_TOKEN,
                            zoomGesturesEnabled: true,
                          )
                        : Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SpinKitFoldingCube(
                                    color: AppColors.colorPrimary,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("Fetching current location..",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: AppColors.black,
                                          fontFamily: 'Quicksand'))
                                ],
                              ),
                            ),
                          ),
                    Align(
                      child: Padding(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            /// TOP ROW BACK,SEARCH,MENU
                            Row(
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: IconButton(
                                        padding: EdgeInsets.all(2),
                                        icon: Icon(
                                          Icons.chevron_left,
                                          color: Colors.black,
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        })),
                                Expanded(
                                    child: Container(
                                        margin: EdgeInsets.only(
                                            left: 10, right: 10),
                                        padding:
                                            EdgeInsets.only(left: 2, right: 2),
                                        decoration: BoxDecoration(
                                            color: AppColors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(
                                              Icons.search,
                                              size: 20,
                                              color: AppColors.black,
                                            ),
                                            suffixIcon: Icon(
                                              Icons.send,
                                              size: 20,
                                              color: AppColors.black,
                                            ),
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                          ),
                                        ))),
                                Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: IconButton(
                                        padding: EdgeInsets.all(2),
                                        icon: Icon(
                                          Icons.menu,
                                          color: Colors.black,
                                        ),
                                        onPressed: () {})),
                              ],
                            ),

                            SizedBox(
                              height: 30,
                            ),

                            /// ADD LEAD ROW
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.black,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                    child: Icon(
                                      Icons.add,
                                      color: AppColors.colorPrimaryLight,
                                    ),
                                    padding: EdgeInsets.only(
                                        top: 10,
                                        bottom: 10,
                                        left: 12,
                                        right: 12),
                                  ),
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, AppConstants.addLeadScreen);
                                  },
                                ),
                                 InkWell(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.black,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                    child: Icon(
                                      Icons.pin_drop,
                                      color: AppColors.colorPrimaryLight,
                                    ),
                                    padding: EdgeInsets.only(
                                        top: 10,
                                        bottom: 10,
                                        left: 12,
                                        right: 12),
                                  ),
                                  onTap: () {



                                    if (provider.getMapStyleString == null) {
                                      provider.setMapStyleString(
                                          MapboxStyles.SATELLITE_STREETS);
                                    } else {
                                      if (provider.getMapStyleString ==
                                          MapboxStyles.MAPBOX_STREETS)
                                        provider.setMapStyleString(
                                            MapboxStyles.SATELLITE_STREETS);
                                      else
                                        provider.setMapStyleString(
                                            MapboxStyles.MAPBOX_STREETS);
                                    }
                                  },
                                )
                                //_popupMenuWidget()
                              ],
                            )
                          ],
                        ),
                        padding: EdgeInsets.only(top: 40, left: 20, right: 20),
                      ),
                      alignment: Alignment.topCenter,
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }

  showMapBottomSheet() {
    showModalBottomSheet(
        backgroundColor: Colors.white.withOpacity(0.01),
        context: context,
        builder: (BuildContext context) {
          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: EdgeInsets.all(20),
            child: InkWell(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      child: Container(
                        width: 30,
                        height: 4,
                        decoration: BoxDecoration(
                            color: AppColors.black.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      onTap: () {
                        //   Navigator.pop(context);
                        Navigator.pushNamed(
                            context, AppConstants.leadDetailScreen);
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Hero(
                          child: ClipRRect(
                            child: Image.asset(
                              "assets/images/solarpanel.jpeg",
                              height: 90,
                              fit: BoxFit.fill,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          tag: "lead_image",
                        )),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "124 33rd St Apt 3R",
                              style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 16.0,
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "Brooklyn, NY",
                              style: TextStyle(
                                  color: AppColors.grey,
                                  fontSize: 11.0,
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Juan Leon",
                              style: TextStyle(
                                  color: AppColors.grey,
                                  fontSize: 11.0,
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "42 years old, M-Renter",
                              style: TextStyle(
                                  color: AppColors.grey,
                                  fontSize: 11.0,
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                          mainAxisSize: MainAxisSize.min,
                        ))
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    DPAAMenuWidget(),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.pop(context);

                Navigator.pushNamed(context, AppConstants.leadDetailScreen);
              },
            ),
          );
        });
  }

  Widget _popupMenuWidget() => Theme(data: Theme.of(context).copyWith(
    cardColor: Colors.white,
  ), child: PopupMenuButton<int>(
    itemBuilder: (context) => [
      PopupMenuItem(
        value: 1,
        child: Text("Street View",
            style: TextStyle(
                fontSize: 15,
                color: AppColors.black,
                fontFamily: 'Quicksand')),
      ),
      PopupMenuDivider(
        height: 5,
      ),
      PopupMenuItem(
        value: 1,
        child: Text("Satellite View",
            style: TextStyle(
                fontSize: 15,
                color: AppColors.black,
                fontFamily: 'Quicksand')),
      ),
    ],
    onSelected: (value) {
      print("Value $value");
    },
    initialValue: 1,
    child: Container(
      decoration: BoxDecoration(
          color: AppColors.black,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Icon(
        Icons.pin_drop,
        color: AppColors.colorPrimaryLight,
      ),
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 12, right: 12),
    ),
    offset: Offset(0, 100),
  ));
}
