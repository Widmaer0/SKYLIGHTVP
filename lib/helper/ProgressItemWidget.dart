import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'AppColors.dart';

class ProgressItemWidget extends StatelessWidget {
  String name;
  String icon;
  String step;
  String updatedTime;
  Function clickFunction;
  double progress;

  ProgressItemWidget(
      this.name, this.icon, this.step, this.updatedTime, this.clickFunction,this.progress);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 10),
      child:  InkWell(child: Container(
        padding: EdgeInsets.all(15),
        child:Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: AppColors.black,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: SvgPicture.asset(
                icon,
                color: AppColors.colorPrimaryLight,
                width: 32,
                height: 32,
              ),
              padding:
              EdgeInsets.only(top: 10, bottom: 10, left: 12, right: 12),
            ),
            VerticalDivider(
              width: 10,
            ),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                          color: AppColors.black,
                          fontSize: 13.0,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 10,
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          child: LinearProgressIndicator(
                            backgroundColor: AppColors.black_50.withOpacity(0.05),
                            value: progress,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.colorPrimaryLight),
                          )),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          step,
                          style: TextStyle(
                            color: AppColors.black_50,
                            fontSize: 10,
                            fontFamily: 'Quicksand',
                          ),
                        ),
                        Text(
                          "Updated " + updatedTime,
                          style: TextStyle(
                            color: AppColors.black_50,
                            fontSize: 10,
                            fontFamily: 'Quicksand',
                          ),
                        ),
                      ],
                    )
                  ],
                ))
          ],
        )),onTap: clickFunction,),

    );
  }
}
