import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_skyplight/helper/AppColors.dart';
import 'package:flutter_skyplight/helper/AppConstants.dart';
import 'package:flutter_skyplight/helper/AppSharedPreference.dart';
import 'package:flutter_skyplight/helper/Utility.dart';
import 'package:flutter_skyplight/model/SaveDataInfo.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPhotoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RegisterPhotoState();
  }
}

class RegisterPhotoState extends State<RegisterPhotoScreen> {
  final userNameController = TextEditingController();
  final passWordController = TextEditingController();
  final FocusNode usernameFocus = FocusNode();
  final FocusNode passFocus = FocusNode();
  final FocusNode photoFocus = FocusNode();
  File file, file2;
  bool isImageAvailable = false;
  bool showLoader = false;
  File imageFile;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  imagePicker(String type) async {
    type == 'Camera'
        ? file = await ImagePicker.pickImage(source: ImageSource.camera)
        : file = await ImagePicker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      print(file.path);
      setState(() {
        imageFile = File(file.path);
        isImageAvailable = true;
        AppConstants.photo=file.path;
      });
    }
  }

  showAlertDialog(BuildContext context) {
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
                imagePicker('Camera');
              },
              child: new Text('Camera'),
            ),
            new FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
                imagePicker('Gallery');
              },
              child: new Text('Gallery'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
            child: SingleChildScrollView(
                child: Stack(children: <Widget>[
          Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 45.0, left: 15.0, right: 15.0),
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      AppConstants.register,
                      style: TextStyle(
                        fontSize: 30.0,
                        color: AppColors.colorText,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 18.0, top: 8.0, bottom: 8.0),
                  alignment: Alignment.centerLeft,
                  color: AppColors.grey_50,
                  margin: EdgeInsets.only(top: 10.0),
                  child: Text(
                    AppConstants.profileInfo.toUpperCase(),
                    style: TextStyle(
                      fontSize: 12.0,
                      color: AppColors.colorText,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                    margin:
                        EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
                    child: Column(children: [
                      Padding(
                        padding:
                            EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                        child: TextField(
                          controller: userNameController,
                          textInputAction: TextInputAction.next,
                          focusNode: usernameFocus,
                          onChanged: (value){
                            setState(() {
                              AppConstants.username=value;
                              print("@@"+AppConstants.username);

                            });
                          },
                          onSubmitted: (value) {
                            if (value.isNotEmpty) {
                              setState(() {
                                Utility.fieldFocusChange(context, usernameFocus, passFocus);
                              });
                            }
                          },
                          keyboardType: TextInputType.text,
                          cursorColor: AppColors.colorText,
                          decoration: InputDecoration(
                            focusedBorder: new UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: AppColors.black)),
                            labelStyle: TextStyle(
                                color: AppColors.black,
                                fontSize: 15.0,
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.w300),
                            labelText: AppConstants.userName,
                            hasFloatingPlaceholder: true,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                        child: TextField(
                          textInputAction: TextInputAction.next,
                          focusNode: passFocus,
                          maxLength: 10,
                          onChanged: (value){
                            setState(() {
                              AppConstants.pass=value;
                              print("@@"+AppConstants.pass);

                            });
                          },

                          onSubmitted: (term) {
                            Utility.fieldFocusChange(context, usernameFocus, passFocus);
                            if (userNameController.text == "") {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text(AppConstants.msgEnterUser)));
                            } else if (passWordController.text == "") {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text(AppConstants.msgEnterPassword)));
                            }else if (passWordController.text.length<6 ) {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text(AppConstants.msgEnterValidPassword)));
                            } else {
                              Map map = new Map();
                              map['userName'] =
                                  userNameController.text.toString();
                              map['password'] =
                                  passWordController.text.toString();


                              String str = jsonEncode(map);
                              print("@@@" + str);
                              try {
                                AppSharedPreference().saveProfileInfo(str);
                              }catch(e){
                                Utility.showToast("error"+e.toString());
                              }
                            }
                          },
                          controller: passWordController,
                          keyboardType: TextInputType.text,
                          cursorColor: AppColors.colorText,
                          obscureText: true,
                          decoration: InputDecoration(
                            focusedBorder: new UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: AppColors.black)),
                            labelStyle: TextStyle(
                                color: AppColors.black,
                                fontSize: 15.0,
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.w300),
                            labelText: AppConstants.password,
                            hasFloatingPlaceholder: true,
                          ),
                        ),
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          margin:
                              EdgeInsets.only(top: 25, left: 16, right: 16.0),
                          height: 80.0,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.0)),
                              color: AppColors.buttonColor),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,

                            children: [
                              IconButton(
                                onPressed: () {
                                  showAlertDialog(context);
                                },
                                icon: Image.asset(
                                    'assets/images/eva_camera_outline.png'),
                                iconSize: 24,
                                splashColor: Colors.blue[50],
                              ),
                              SizedBox(
                                  width: 150,
                                  child: Text(
                                    AppConstants.uploadPhoto,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: AppColors.colorPrimaryLight),
                                  )),
                            ],
                          )),
                      isImageAvailable
                          ? Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1.0, color: AppColors.grey_50)),
                              margin: EdgeInsets.all(15.0),
                              width: MediaQuery.of(context).size.width / 2,
                              height: 120.0,
                              child: file != null
                                  ? Image.file(imageFile)
                                  : Container(),
                            )
                          : Container()
                    ])),
              ])),
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
        ]))));
  }
  saveRegisterPhoto(){
    Map map = new Map();
    map['userName'] =
        userNameController.text.toString();
    map['password'] =
        passWordController.text.toString();


    String str = jsonEncode(map);
    print("@@@" + str);
    AppSharedPreference().saveProfileInfo(str);
  }


}
