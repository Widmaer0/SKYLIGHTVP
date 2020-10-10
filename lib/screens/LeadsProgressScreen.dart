import 'package:flutter/material.dart';
import 'package:flutter_skyplight/helper/AppColors.dart';
import 'package:flutter_skyplight/helper/AppConstants.dart';
import 'package:flutter_skyplight/helper/ProgressItemWidget.dart';
import 'package:flutter_skyplight/model/LeadModel.dart';

class LeadsProgressScreen extends StatefulWidget {
  LeadModel leadModel;

  LeadsProgressScreen({Key key, this.leadModel}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LeadsProgressScreenState();
  }
}

class LeadsProgressScreenState extends State<LeadsProgressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          AppConstants.txtInProgress,
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
                //_showOverlay(context);
              })
        ],
        bottomOpacity: 1,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ADDRESS WIDGET
            Card(
                elevation: 0.2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "ADDRESS",
                        style: TextStyle(
                            color: AppColors.black,
                            fontSize: 12.0,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        widget.leadModel.leadAddress,
                        style: TextStyle(
                            color: AppColors.black,
                            fontSize: 18.0,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.leadModel.leadCity+", "+widget.leadModel.leadState,
                        style: TextStyle(
                            color: AppColors.black,
                            fontSize: 12.0,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                    mainAxisSize: MainAxisSize.min,
                  ),
                  padding:
                      EdgeInsets.only(top: 20, bottom: 20, left: 15, right: 15),
                )),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.only(top: 20, left: 5),
                      child: Text(
                        "Progress",
                        style: TextStyle(
                            color: AppColors.black,
                            fontSize: 15.0,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.w600),
                      )),
                  ProgressItemWidget(
                      "Account Created",
                      "assets/images/light_bulb.svg",
                      "Step 1",
                      "04/23/2020",
                      () {},
                      0.5),
                  ProgressItemWidget("Docs Signed".toUpperCase(),
                      "assets/images/light_bulb.svg", "Step 2", "-", () {}, 0),
                  ProgressItemWidget("Site Survey Complete".toUpperCase(),
                      "assets/images/light_bulb.svg", "Step 3", "-", () {}, 0),
                  ProgressItemWidget("Design Packet Complete".toUpperCase(),
                      "assets/images/light_bulb.svg", "Step 4", "-", () {}, 0),
                  ProgressItemWidget("Approval".toUpperCase(),
                      "assets/images/light_bulb.svg", "Step 5", "-", () {}, 0),
                ],
              ),
            ))
          ],
        ),
        padding: EdgeInsets.all(20),
      ),
      backgroundColor: AppColors.backgroundColor,
    );
  }
}
