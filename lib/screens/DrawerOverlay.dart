import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skyplight/helper/AppColors.dart';
import 'package:flutter_skyplight/helper/AppConstants.dart';

class DrawerOverlay extends ModalRoute<void> {
  @override
  Duration get transitionDuration => Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.8);

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    List list = new List();
    list.add(AppConstants.drawerTurf);
    list.add(AppConstants.drawerConnect);
    list.add(AppConstants.drawerFlex);
    list.add(AppConstants.drawerChat);
    list.add(AppConstants.drawerLead);
    list.add(AppConstants.drawerSettings);
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(10.0),
          height: 20.0,
          alignment: Alignment.topRight,
          width: MediaQuery.of(context).size.width,
          child: IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
    Center(
        child:
    Container(
            margin: EdgeInsets.only(left:10.0,right: 10.0,top:150.0),

            alignment:Alignment.center,
            width: MediaQuery.of(context).size.width/2,
        child: new ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return ListTile(
                          title:Padding(
                            padding: EdgeInsets.all(8.0),
                            child:
                           new Text(list[index].toString().toUpperCase(),textAlign:TextAlign.center,
                            style: TextStyle(color: AppColors.white, fontSize:18.0,fontFamily: 'Quicksand',
                                fontWeight: FontWeight.w500),),),
                          onTap: () {
                            Navigator.pop(context);
                          });
                    })

                )),
      ],
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}
