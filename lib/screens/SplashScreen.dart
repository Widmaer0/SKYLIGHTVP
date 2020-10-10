import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skyplight/helper/AppColors.dart';
import 'package:flutter_skyplight/helper/AppConstants.dart';
import 'package:flutter_skyplight/helper/AppSharedPreference.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SplashScreenWidget();
  }
}

class SplashScreenWidget extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() async {
    bool isLoggedIn = await AppSharedPreference().getIsLoggedIn();
    if (isLoggedIn != null && isLoggedIn) {
      Navigator.pushNamed(context, AppConstants.homeScreen);
    } else {
      Navigator.pushNamed(context, AppConstants.loginScreen);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      body: Container(
        color: AppColors.white_80,
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width / 1.5,
                child: new Image.asset(
                  'assets/images/skylight_logo_black.png',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
