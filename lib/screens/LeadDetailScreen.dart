import 'package:flutter/material.dart';
import 'package:flutter_skyplight/helper/AdditionalInfoItemWidget.dart';
import 'package:flutter_skyplight/helper/AppColors.dart';
import 'package:flutter_skyplight/helper/AppConstants.dart';
import 'package:flutter_skyplight/helper/DPAAMenuWidget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LeadDetailScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LeadDetailScreenState();
  }
}

class LeadDetailScreenState extends State<LeadDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          AppConstants.txtHomeDetail.toString(),
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
              onPressed: () {})
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
            child: Column(
          children: [
            Hero(
              child: ClipRRect(
                child: Image.asset(
                  "assets/images/solarpanel.jpeg",
                  height: MediaQuery.of(context).size.width - 180,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              tag: "lead_image",
            ),

            /// ADDRESS WIDGET
            Card(
                elevation: 0.2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.only(top: 20),
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
                        "124 33rd St Apt 3R",
                        style: TextStyle(
                            color: AppColors.black,
                            fontSize: 18.0,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.w200),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Brooklyn, NY",
                        style: TextStyle(
                            color: AppColors.black,
                            fontSize: 12.0,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.w200),
                      ),
                    ],
                    mainAxisSize: MainAxisSize.min,
                  ),
                  padding:
                      EdgeInsets.only(top: 20, bottom: 20, left: 15, right: 15),
                )),

            /// INFORMATION WIDGET
            Card(
                elevation: 0.2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.only(top: 20),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "INFORMATION",
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
                        "Juan Leon",
                        style: TextStyle(
                            color: AppColors.black,
                            fontSize: 18.0,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.w200),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "42 years old, M - Renter",
                        style: TextStyle(
                            color: AppColors.black,
                            fontSize: 12.0,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.w200),
                      ),
                    ],
                    mainAxisSize: MainAxisSize.min,
                  ),
                  padding:
                      EdgeInsets.only(top: 20, bottom: 20, left: 15, right: 15),
                )),

            Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.only(top: 20),
                child: Padding(
                  child: DPAAMenuWidget(),
                  padding:
                      EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
                )),

            /// ADDITIONAL INFORMATION WIDGET
            Card(
                elevation: 0.2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.only(top: 20),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "ADDITIONAL INFORMATION",
                        style: TextStyle(
                            color: AppColors.black,
                            fontSize: 12.0,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      AdditionalInfoItemWidget(
                          "Location Type", "Multi-Family Dwelling"),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: AdditionalInfoItemWidget(
                            "Religion",
                            "Catholic",
                            divider: true,
                          )),
                          Expanded(
                              child: AdditionalInfoItemWidget(
                            "Adults",
                            "1",
                            divider: true,
                          )),
                          Expanded(
                              child:
                                  AdditionalInfoItemWidget("High Tech", "No")),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: AdditionalInfoItemWidget(
                            "Own/Rent",
                            "Home Owner",
                            divider: true,
                          )),
                          Expanded(
                              child: AdditionalInfoItemWidget(
                            "Median Home value",
                            "12345",

                          )),

                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: AdditionalInfoItemWidget(
                            "Year Resident",
                            "2",
                            divider: true,
                          )),
                          Expanded(
                              child: AdditionalInfoItemWidget(
                            "High Tech",
                            "No",
                            divider: true,
                          )),
                        ],
                      )
                    ],
                    mainAxisSize: MainAxisSize.min,
                  ),
                  padding:
                      EdgeInsets.only(top: 20, bottom: 20, left: 15, right: 15),
                )),
          ],
        )),
      ),
    );
  }
}
