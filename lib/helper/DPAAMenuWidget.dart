import 'package:flutter/material.dart';
import 'package:flutter_skyplight/helper/AppConstants.dart';
import 'package:flutter_svg/svg.dart';

import 'AppColors.dart';

class DPAAMenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: InkWell(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: SvgPicture.asset(
                  "assets/images/light_bulb.svg",
                  color: AppColors.colorPrimaryLight,
                  width: 28,
                  height: 28,
                ),
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, left: 12, right: 12),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Disposition",
                style: TextStyle(
                    color: AppColors.black,
                    fontSize: 10.0,
                    fontFamily: 'Quicksand'),
              ),
            ],
            mainAxisSize: MainAxisSize.min,
          ),
          onTap: () {
            Navigator.of(context).pushNamed(AppConstants.dispositionScreen);
          },
        )),
        Expanded(
            child: InkWell(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: SvgPicture.asset(
                  "assets/images/light_bulb.svg",
                  color: AppColors.colorPrimaryLight,
                  width: 28,
                  height: 28,
                ),
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, left: 12, right: 12),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Pre-Qualify",
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 10.0,
                  fontFamily: 'Quicksand',
                ),
              ),
            ],
            mainAxisSize: MainAxisSize.min,
          ),
          onTap: () {},
        )),
        Expanded(
            child: InkWell(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: SvgPicture.asset(
                  "assets/images/light_bulb.svg",
                  color: AppColors.colorPrimaryLight,
                  width: 28,
                  height: 28,
                ),
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, left: 12, right: 12),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Add Lead",
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 10.0,
                  fontFamily: 'Quicksand',
                ),
              ),
            ],
            mainAxisSize: MainAxisSize.min,
          ),
          onTap: () {
            Navigator.of(context).pushNamed(AppConstants.addLeadScreen);
          },
        )),
        Expanded(
            child: InkWell(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: SvgPicture.asset(
                  "assets/images/light_bulb.svg",
                  color: AppColors.colorPrimaryLight,
                  width: 28,
                  height: 28,
                ),
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, left: 12, right: 12),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Add Notes",
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 10.0,
                  fontFamily: 'Quicksand',
                ),
              ),
            ],
            mainAxisSize: MainAxisSize.min,
          ),
          onTap: () {
            Navigator.of(context).pushNamed(AppConstants.addNotesScreen);
          },
        ))
      ],
    );
  }
}
