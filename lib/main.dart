import 'package:flutter/material.dart';
import 'package:flutter_skyplight/screens/AddLeadScreen.dart';
import 'package:flutter_skyplight/screens/AddNotesScreen.dart';
import 'package:flutter_skyplight/screens/ConnectScreen.dart';
import 'package:flutter_skyplight/screens/DispositionItemsScreen.dart';
import 'package:flutter_skyplight/screens/DispositionScreen.dart';
import 'package:flutter_skyplight/screens/FlexScreen.dart';
import 'package:flutter_skyplight/screens/HomeScreen.dart';
import 'package:flutter_skyplight/screens/LeadDetailScreen.dart';
import 'package:flutter_skyplight/screens/LeadsProgressScreen.dart';
import 'package:flutter_skyplight/screens/LeadsScreen.dart';
import 'package:flutter_skyplight/screens/LoginScreen.dart';
import 'package:flutter_skyplight/screens/RegisterScreen.dart';
import 'package:flutter_skyplight/screens/SettingsScreen.dart';
import 'package:flutter_skyplight/screens/SignupScreen.dart';
import 'package:flutter_skyplight/screens/SplashScreen.dart';
import 'package:flutter_skyplight/screens/TrainningScreen.dart';
import 'package:flutter_skyplight/screens/TurfScreen.dart';

import 'helper/AppConstants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Quicksand',
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: _getRoute,
      initialRoute: '/',
    );
  }
}

Route<dynamic> _getRoute(RouteSettings settings) {
  if (settings.name == AppConstants.splashScreen) {
    return _buildRoute(settings, SplashScreen());
  }
  if (settings.name == AppConstants.loginScreen) {
    return _buildRoute(settings, LoginScreen(val: AppConstants.passedName));
  }
  if (settings.name == AppConstants.homeScreen) {
    return _buildRoute(settings, HomeScreen(val: AppConstants.passedName));
  }
  if (settings.name == AppConstants.signupScreen) {
    return _buildRoute(settings, SignupScreen());
  }
  if (settings.name == AppConstants.turfScreen) {
    return _buildRoute(settings, TurfScreen());
  }
  if (settings.name == AppConstants.flexScreen) {
    return _buildRoute(settings, FlexScreen());
  }
  if (settings.name == AppConstants.leadScreen) {
    return _buildRoute(settings, LeadsScreen());
  }
  if (settings.name == AppConstants.connectScreen) {
    return _buildRoute(settings, ConnectScreen());
  }
  if (settings.name == AppConstants.trainningScreen) {
    return _buildRoute(settings, TrainningScreen());
  }
  if (settings.name == AppConstants.settingsScreen) {
    return _buildRoute(settings, SettingsScreen());
  }
  if (settings.name == AppConstants.registerScreen) {
    return _buildRoute(settings, RegisterScreen());
  }
  if (settings.name == AppConstants.addLeadScreen) {
    return _buildRoute(settings, AddLeadScreen());
  }
  if (settings.name == AppConstants.leadDetailScreen) {
    return _buildRoute(settings, LeadDetailScreen());
  }
  if (settings.name == AppConstants.leadProgressScreen) {
    return _buildRoute(
        settings,
        LeadsProgressScreen(
          leadModel: settings.arguments,
        ));
  }
  if (settings.name == AppConstants.dispositionScreen) {
    return _buildRoute(settings, DispositionScreen());
  }
  if (settings.name == AppConstants.dispositionItemScreen) {
    return _buildRoute(
        settings,
        DispositionItemsScreen(
          itemName: settings.arguments,
        ));
  }

  if (settings.name == AppConstants.addNotesScreen) {
    return _buildRoute(settings, AddNotesScreen());
  }
}

MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
  return new MaterialPageRoute(
    settings: settings,
    builder: (ctx) => builder,
  );
}
