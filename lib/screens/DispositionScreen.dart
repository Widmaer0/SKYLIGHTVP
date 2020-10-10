import 'package:flutter/material.dart';
import 'package:flutter_skyplight/helper/AppColors.dart';
import 'package:flutter_skyplight/helper/AppConstants.dart';

class DispositionScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DispositionState();
  }
}

class DispositionState extends State<DispositionScreen> {
  var items = ["Consumer", "Interested", "Not Interested", "Unsure"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          AppConstants.txtDisposition,
          style: TextStyle(
              fontSize: 15, color: AppColors.black, fontFamily: 'Quicksand'),
        ),
        backgroundColor: AppColors.backgroundColor,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.black,
                size: 20,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
        actions: [
          IconButton(
              padding: EdgeInsets.only(right: 10),
              icon: Icon(
                Icons.menu,
                color: AppColors.black,
                size: 20,
              ),
              onPressed: () {
                //_showOverlay(context);
              })
        ],
      ),
      body: Container(
        child: ListView.builder(
          itemBuilder: (context, position) {
            return Card(
                margin: EdgeInsets.only(top: 15),
                elevation: 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  contentPadding:
                      EdgeInsets.only(left: 14, right: 14, top: 4, bottom: 4),
                  title: Text(
                    items[position],
                    style: TextStyle(
                        color: AppColors.black,
                        fontSize: 13.0,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.w600),
                  ),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: AppColors.black,
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                        context, AppConstants.dispositionItemScreen,
                        arguments: items[position]);
                  },
                ));
          },
          itemCount: items.length,
        ),
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      ),
    );
  }
}
