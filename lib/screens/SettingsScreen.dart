import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skyplight/helper/AppColors.dart';
import 'package:flutter_skyplight/helper/AppConstants.dart';

class SettingsScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SettingsState();
  }

}

class SettingsState extends State<SettingsScreen>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      appBar: AppBar(
        title: Text(AppConstants.drawerSettings.toString()),
        backgroundColor: AppColors.colorPrimaryDark,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
      body: Center(
        child: Text(AppConstants.drawerSettings,textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold ,color:AppColors.colorText ),),
      ),
    );
  }

}