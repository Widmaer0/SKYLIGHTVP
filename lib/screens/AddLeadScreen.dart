import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_skyplight/helper/AppColors.dart';
import 'package:flutter_skyplight/helper/AppConstants.dart';
import 'package:flutter_skyplight/helper/AppDBHelper.dart';
import 'package:flutter_skyplight/helper/LeadFormItemWidget.dart';
import 'package:flutter_skyplight/providers/AddLeadsProvider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddLeadScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddLeadScreenState();
  }
}

class AddLeadScreenState extends State<AddLeadScreen> {
  var _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  var _firstNameController = TextEditingController();
  var _lastNameController = TextEditingController();
  var _notesController = TextEditingController();
  var _phoneController = TextEditingController();
  var _utilityCompanyController = TextEditingController();
  var _countyController = TextEditingController();
  var _secondPhoneController = TextEditingController();
  var _addressController = TextEditingController();
  var _cityController = TextEditingController();
  var _stateController = TextEditingController();
  var _pinController = TextEditingController();
  var _yearlyUsageController = TextEditingController();
  var _monthlyUsageController = TextEditingController();
  var leadType = ['Residential', 'Commercial'];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddLeadsProvider(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            key: _scaffoldKey,
            backgroundColor: AppColors.backgroundColor,
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              title: Text(
                AppConstants.txtAddLead.toString(),
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
            body: Container(
                child: SingleChildScrollView(
              child: Form(
                child: Consumer<AddLeadsProvider>(
                  builder: (context, provider, child) {
                    return Column(
                      children: [
                        /// ABOUT YOU LAYOUT
                        _aboutWidget(),

                        /// HOUSEHOLD QUESTIONS LAYOUT
                        _houseHoldQuestionsWidget(provider),

                        /// FINANCIAL INFORMATION LAYOUT
                        _financialInfoWidget(provider),

                        /// BOTTOM BUTTONS LAYOUT
                        _bottomButtonsWidget(provider)
                      ],
                    );
                  },
                ),
                key: _formKey,
              ),
            )),
          );
        },
      ),
    );
  }

  _aboutWidget() {
    return Card(
      elevation: 1,
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
      child: Container(
        margin: EdgeInsets.all(2),
        padding: EdgeInsets.all(20),
        color: AppColors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppConstants.txtClientInformation.toUpperCase(),
              style: TextStyle(color: AppColors.black, fontSize: 16),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: LeadFormItemWidget(AppConstants.firstName, "Juan",
                        AppConstants.msgEnterFname, _firstNameController)),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: LeadFormItemWidget(AppConstants.lastName, "Leon",
                        AppConstants.msgEnterLname, _lastNameController)),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: LeadFormItemWidget(
                        AppConstants.phoneNumber,
                        "XXX-XXX-XXXX",
                        AppConstants.msgEnterPhone,
                        _phoneController,
                        maxLength: 10,
                        onlyNumber: true)),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: LeadFormItemWidget(
                        AppConstants.txtSecondPhoneNumber,
                        "XXX-XXX-XXXX",
                        "",
                        _secondPhoneController,
                        maxLength: 10,
                        onlyNumber: true)),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: LeadFormItemWidget(
                  AppConstants.txtAddress,
                  "123 abc, xyz, NZ",
                  AppConstants.msgEnterAddress,
                  _addressController),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: LeadFormItemWidget(AppConstants.city, "Brooklyn",
                        AppConstants.msgEnterCity, _cityController)),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: LeadFormItemWidget(AppConstants.state, "NY",
                        AppConstants.msgEnterState, _stateController)),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: LeadFormItemWidget(
                  AppConstants.postalCode,
                  "xxxxxx",
                  AppConstants.msgEnterPostal,
                  _pinController,
                  maxLength: 6,
                  onlyNumber: true,
                )),
              ],
            )
          ],
        ),
      ),
    );
  }

  _houseHoldQuestionsWidget(AddLeadsProvider provider) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
      child: Container(
        margin: EdgeInsets.all(2),
        padding: EdgeInsets.all(20),
        color: AppColors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppConstants.txtHouseholdQuestions.toUpperCase(),
              style: TextStyle(color: AppColors.black, fontSize: 16),
            ),
            SizedBox(
              height: 20,
            ),

            /// DEFAULT LAYOUT
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width / 5,
              decoration: BoxDecoration(
                  color: AppColors.black,
                  borderRadius: BorderRadius.circular(10)),
              child: InkWell(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.camera_alt,
                      color: AppColors.colorPrimaryLight,
                      size: 26,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Upload Photos",
                      style: TextStyle(
                          color: AppColors.colorPrimaryLight, fontSize: 12),
                    )
                  ],
                  mainAxisSize: MainAxisSize.min,
                ),
                onTap: () {
                  showImagePickerDialog(provider);
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),

            /// AFTER IMAGE SELECTED
            provider.imageFile != null
                ? Container(
                    child: InkWell(
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width / 4,
                          child: Image.file(
                            provider.imageFile,
                            fit: BoxFit.cover,
                          )),
                      onTap: () {
                        _showFullImageDialog(provider);
                      },
                    ),
                  )
                : Container(),

            SizedBox(
              height: 15,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: LeadFormItemWidget(
                AppConstants.txtYearlyUsage,
                AppConstants.txtAnnualUsage,
                AppConstants.msgEnterYearlyAverageUsage,
                _yearlyUsageController,
                suffixText: "kwh",
              ),
            ),
            SizedBox(
              height: 12,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: LeadFormItemWidget(
                  AppConstants.txtAverageMonthlyBill,
                  AppConstants.txtAverageMonthlyBill,
                  AppConstants.msgEnterMonthlyAverageBill,
                  _monthlyUsageController),
            ),
          ],
        ),
      ),
    );
  }

  _financialInfoWidget(AddLeadsProvider provider) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
      child: Container(
        margin: EdgeInsets.all(2),
        padding: EdgeInsets.all(20),
        color: AppColors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppConstants.txtFinancialInformation.toUpperCase(),
              style: TextStyle(color: AppColors.black, fontSize: 16),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Real Time",
                        style: TextStyle(
                            fontSize: 14,
                            color: AppColors.black,
                            fontFamily: 'Quicksand'),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        provider.fiTime == "1"
                            ? Icons.check_circle
                            : Icons.check_circle_outline,
                        size: 16,
                        color: provider.fiTime == "1"
                            ? AppColors.colorPrimaryLight
                            : AppColors.grey_2,
                      )
                    ],
                  ),
                  onTap: () {
                    provider.setFiTime("1");
                  },
                ),
                InkWell(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Next Day",
                        style: TextStyle(
                            fontSize: 14,
                            color: AppColors.black,
                            fontFamily: 'Quicksand'),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        provider.fiTime == "2"
                            ? Icons.check_circle
                            : Icons.check_circle_outline,
                        size: 16,
                        color: provider.fiTime == "2"
                            ? AppColors.colorPrimaryLight
                            : AppColors.grey_2,
                      )
                    ],
                  ),
                  onTap: () {
                    provider.setFiTime("2");
                  },
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width,
                child: LeadFormItemWidget(
                    AppConstants.txtUtilityCompany,
                    "select",
                    AppConstants.msgEnterUtilityCompany,
                    _utilityCompanyController)),
            SizedBox(
              height: 8,
            ),
            Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Max Offset",
                        style: TextStyle(
                            fontSize: 12,
                            color: AppColors.black,
                            fontFamily: 'Quicksand'),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        provider.maxOffset == "1"
                            ? Icons.check_circle
                            : Icons.check_circle_outline,
                        size: 16,
                        color: provider.maxOffset == "1"
                            ? AppColors.colorPrimaryLight
                            : AppColors.grey_2,
                      )
                    ],
                  ),
                  onTap: () {
                    if (provider.maxOffset == "0")
                      provider.setMaxOffset("1");
                    else
                      provider.setMaxOffset("0");
                  },
                )),
            SizedBox(
              height: 20,
            ),
            Text(
              AppConstants.txtLeadType,
              style: TextStyle(color: AppColors.black, fontSize: 13),
            ),
            DropdownButton(
                isExpanded: true,
                value: provider.selectedLeadType,
                items: getLeadTypeList(),
                onChanged: (value) {
                  provider.setlectedLeadType(value);
                }),
            SizedBox(
              height: 20,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width,
                child: LeadFormItemWidget(AppConstants.txtCounty, "select",
                    AppConstants.msgEnterCounty, _countyController)),
            SizedBox(
              height: 20,
            ),
            Text(
              AppConstants.txtNext,
              style: TextStyle(color: AppColors.black, fontSize: 13),
            ),
            SizedBox(
              height: 5,
            ),
            TextFormField(
              controller: _notesController,
              style: TextStyle(fontSize: 12, fontFamily: 'Quicksand'),
              minLines: 4,
              maxLines: 4,
              maxLength: 1000,
              validator: (value) {
                if (value.isEmpty)
                  return "";
                else
                  return null;
              },
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8),
                hintStyle: TextStyle(fontSize: 12, fontFamily: 'Quicksand'),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.borderColor,
                    ),
                    borderRadius: BorderRadius.circular(5)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.borderColor,
                    ),
                    borderRadius: BorderRadius.circular(5)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.borderColor,
                    ),
                    borderRadius: BorderRadius.circular(5)),
              ),
            )
          ],
        ),
      ),
    );
  }

  imagePicker(String type, AddLeadsProvider provider) async {
    File file;
    type == 'Camera'
        ? file = await ImagePicker.pickImage(source: ImageSource.camera)
        : file = await ImagePicker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      print(file.path);

      provider.setImageFile(file);
    }
  }

  showImagePickerDialog(AddLeadsProvider provider) {
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Choose Image"),
          content: Text("Please select image"),
          actions: <Widget>[
            new FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
                imagePicker('Camera', provider);
              },
              child: new Text('Camera'),
            ),
            new FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
                imagePicker('Gallery', provider);
              },
              child: new Text('Gallery'),
            ),
          ],
        );
      },
    );
  }

  _showFullImageDialog(AddLeadsProvider provider) {
    showDialog(
        context: context,
        child: Dialog(
          child: Container(
            child: Stack(
              children: [
                Image.file(
                  provider.imageFile,
                  fit: BoxFit.fill,
                ),
                Positioned(
                  child: IconButton(
                    icon: Icon(
                      Icons.cancel,
                      size: 32,
                      color: AppColors.colorPrimaryLight,
                    ),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                  ),
                  top: 10,
                  right: 10,
                )
              ],
            ),
          ),
        ));
  }

  _bottomButtonsWidget(AddLeadsProvider provider) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
              child: RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: Icon(
                        Icons.lock,
                        size: 14,
                        color: AppColors.grey_2,
                      ),
                    ),
                    TextSpan(
                        text:
                            "  Your details will remain 100% private and secure",
                        style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 10,
                            color: AppColors.black)),
                  ],
                ),
              )),
          Row(
            children: [
              Expanded(
                  child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                padding: EdgeInsets.only(top: 12, bottom: 12),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    if (provider.imageFile == null) {
                      _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text("Please select household image")));
                    } else if (provider.fiTime == null) {
                      _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text(
                              "Please select financial information time")));
                    } else if (provider.selectedLeadType == null) {
                      _scaffoldKey.currentState.showSnackBar(
                          SnackBar(content: Text("Please select lead type")));
                    } else {


                      saveLeadData(provider);
                    }
                  }
                },
                color: AppColors.colorPrimaryLight,
                child: Text(
                  "Save",
                  style: TextStyle(color: AppColors.black),
                ),
              )),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                padding: EdgeInsets.only(top: 12, bottom: 12),
                onPressed: () {
                  _scaffoldKey.currentState.showSnackBar(SnackBar(
                      content: Text("Submit functionality still in pending")));
                },
                color: AppColors.black,
                child: Text(
                  "Submit",
                  style: TextStyle(color: AppColors.colorPrimaryLight),
                ),
              )),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          )
        ],
      ),
    );
  }

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

  List<DropdownMenuItem<String>> getLeadTypeList() {
    List<DropdownMenuItem<String>> menuItem = List();

    for (int i = 0; i < leadType.length; i++) {
      menuItem.add(
        DropdownMenuItem(
          child: Text(
            leadType[i],
            style: TextStyle(
                fontSize: 12, color: AppColors.black, fontFamily: 'Quicksand'),
          ),
          value: leadType[i],
        ),
      );
    }

    return menuItem;
  }

  saveLeadData(AddLeadsProvider provider) async {
    try {
      int i = await AppDBHelper.instance.addLead({
        AppDBHelper.colLeadFName: _firstNameController.text,
        AppDBHelper.colLeadLName: _lastNameController.text,
        AppDBHelper.colLeadAddress: _addressController.text,
        AppDBHelper.colLeadCity: _cityController.text,
        AppDBHelper.colLeadState: _stateController.text,
        AppDBHelper.colLeadPostalCode: _pinController.text,
        AppDBHelper.colLeadPhone: _phoneController.text,
        AppDBHelper.colLeadSecPhone: _secondPhoneController.text,
        AppDBHelper.colLeadHouseholdImage: provider.imageFile.path,
        AppDBHelper.colLeadHouseholdYUsage: _yearlyUsageController.text,
        AppDBHelper.colLeadHouseholdMUsage: _monthlyUsageController.text,
        AppDBHelper.colLeadFinancialInfoTime: provider.fiTime,
        AppDBHelper.colLeadType: provider.selectedLeadType,
        AppDBHelper.colLeadUtilityCompany: _utilityCompanyController.text,
        AppDBHelper.colLeadUtilityCompanyMaxOffset: provider.maxOffset,
        AppDBHelper.colLeadCounty: _countyController.text,
        AppDBHelper.colLeadNotes: _notesController.text,
        AppDBHelper.colTime: DateTime.now().toString()
      });

      if (i > 0) {
        _scaffoldKey.currentState
            .showSnackBar(
            SnackBar(content: Text("Lead data saved successfully!")));
      clearFullData();
      }
      else {
        _scaffoldKey.currentState.showSnackBar(
            SnackBar(content: Text("Error on inserting lead data")));
      }
    } catch (e) {
      print(e.toString());
    }
  }
  clearFullData()
  {

    Navigator.pop(context);
  }
}
