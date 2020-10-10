import 'package:flutter/material.dart';
import 'package:flutter_skyplight/helper/AppColors.dart';

class AdditionalInfoItemWidget extends StatelessWidget {
  String text1;
  String text2;
  bool divider;

  AdditionalInfoItemWidget(this.text1, this.text2,{this.divider});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text1,
          style: TextStyle(
              color: AppColors.black,
              fontSize: 10.0,
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.w500),
        ),
        Row(children: [

          Expanded(child: Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(top: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.grey_2.withOpacity(0.2), width: 1)),
              child: Text(text2,
                  style: TextStyle(
                      color: AppColors.black.withOpacity(0.7),
                      fontSize: 12.0,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.w200)))),

          (divider!=null && divider)?SizedBox(width: 10,):Container()

        ],)
      ],
    );
  }
}
