import 'package:flutter/material.dart';
import 'package:flutter_skyplight/helper/AppColors.dart';
import 'package:flutter_skyplight/providers/DispositionItemProvider.dart';
import 'package:provider/provider.dart';

class DispositionItemsScreen extends StatefulWidget {
  String itemName;

  DispositionItemsScreen({Key key, this.itemName}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return DispositionItemsState();
  }
}

class DispositionItemsState extends State<DispositionItemsScreen> {
  DispositionProvider dispositionProvider;

  @override
  void initState() {
    super.initState();
    dispositionProvider = DispositionProvider();

    if (widget.itemName == "Not Interested") {
      dispositionProvider.setItems([
        "Electrical Panel Not Supported",
        "Credit Repair",
        "Roof Integrity",
        "Not Interested",
        "Shading",
        "Rentor",
        "Wrong Number",
        "Do Not Contact"
      ]);
    } else if (widget.itemName == "Consumer") {
      dispositionProvider
          .setItems(["Installed", "Competitor", "Progressing Account"]);
    } else if (widget.itemName == "Interested") {
      dispositionProvider.setItems([
        "Come Back",
        "Set Appointment",
        "Request Call Back",
        "Acknowledged"
      ]);
    } else {
      dispositionProvider.setItems(["Not Home", "No Answer"]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => dispositionProvider,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: Text(
              widget.itemName,
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
          body: Consumer<DispositionProvider>(
              builder: (context, provider, child) {
            if (provider.itemsList != null) {
              return Container(
                child: ListView.builder(
                  itemBuilder: (context, position) {
                    return Card(
                        margin: EdgeInsets.only(top: 15),
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                          contentPadding: EdgeInsets.only(
                              left: 14, right: 14, top: 4, bottom: 4),
                          title: Text(
                            provider.itemsList[position],
                            style: TextStyle(
                                color: AppColors.black,
                                fontSize: 13.0,
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.w600),
                          ),
                          trailing: (provider.selectedItem != null &&
                                  provider.selectedItem ==
                                      provider.itemsList[position])
                              ? Icon(
                                  Icons.check,
                                  color: AppColors.black,
                                )
                              : Container(
                                  width: 0,
                                  height: 0,
                                ),
                          onTap: () {
                            provider
                                .setSelectedItem(provider.itemsList[position]);
                          },
                        ));
                  },
                  itemCount: provider.itemsList.length,
                ),
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
              );
            }
            return Container();
          }),
        ));
  }
}
