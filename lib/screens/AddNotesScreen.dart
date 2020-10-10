import 'package:flutter/material.dart';
import 'package:flutter_skyplight/helper/AppColors.dart';
import 'package:flutter_skyplight/helper/AppConstants.dart';

class AddNotesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddNotesState();
  }
}

class AddNotesState extends State<AddNotesScreen> {
  var notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          AppConstants.txtAddNote,
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
        bottomOpacity: 1,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),

                child: Padding(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        AppConstants.txtCreateNote.toUpperCase(),
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.w500),
                      ),
                      TextFormField(
                        controller: notesController,
                        style: TextStyle(fontSize: 12, fontFamily: 'Quicksand'),
                        validator: (value) {
                          if (value.isEmpty)
                            return "Please write note first.";
                          else
                            return null;
                        },
                        minLines: 6,
                        maxLines: 6,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 8, bottom: 8),
                          hintText: AppConstants.txtWriteSomething,
                          counterText: "",
                          hintStyle:
                              TextStyle(fontSize: 12, fontFamily: 'Quicksand'),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          border: InputBorder.none,
                        ),
                      )
                    ],
                  ),
                  padding: EdgeInsets.all(15),
                )),
            SizedBox(
              height: 20,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  padding: EdgeInsets.only(top: 12, bottom: 12),
                  onPressed: () {},
                  color: AppColors.black,
                  child: Text(
                    AppConstants.txtSubmit,
                    style: TextStyle(color: AppColors.colorPrimaryLight),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
