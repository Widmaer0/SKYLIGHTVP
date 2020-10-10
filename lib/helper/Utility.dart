import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utility{
   static bool isValidEmail(String em) {

    //String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
   String p= r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }
   static void showToast( String msg){
     Fluttertoast.showToast(
         msg: msg,
         toastLength: Toast.LENGTH_SHORT,
         gravity: ToastGravity.CENTER,
         timeInSecForIosWeb: 1,
         backgroundColor: Colors.grey,
         textColor: Colors.black,
         fontSize: 14.0
     );
   }
  static fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
     currentFocus.unfocus();
     FocusScope.of(context).requestFocus(nextFocus);
   }
}