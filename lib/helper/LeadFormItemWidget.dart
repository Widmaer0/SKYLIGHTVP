import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_skyplight/helper/AppColors.dart';

class LeadFormItemWidget extends StatelessWidget {
  String headerText;
  String hintText;
  String suffixText;
  String validationMessage;
  TextEditingController controller;
  int maxLength = -1;
  bool onlyNumber = false;

  LeadFormItemWidget(
      this.headerText, this.hintText, this.validationMessage, this.controller,
      {this.suffixText, this.maxLength, this.onlyNumber});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          headerText,
          style: TextStyle(color: AppColors.black, fontSize: 12),
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: controller,
          style: TextStyle(fontSize: 12, fontFamily: 'Quicksand'),
          validator: (value) {
            if (value.isEmpty && validationMessage.length > 0)
              return validationMessage;
            else
              return null;
          },
          maxLength: maxLength == -1 ? maxLength : 50,
          inputFormatters: (onlyNumber != null && onlyNumber)
              ? [WhitelistingTextInputFormatter.digitsOnly]
              : null,
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8),
            suffix: suffixText != null ? Text(suffixText) : null,
            hintText: hintText,
            counterText: "",
            hintStyle: TextStyle(fontSize: 12, fontFamily: 'Quicksand'),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.borderColor,
                ),
                borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.borderColor,
                ),
                borderRadius: BorderRadius.circular(10)),
            border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.borderColor,
                ),
                borderRadius: BorderRadius.circular(10)),
          ),
        )
      ],
    );
  }
}
