import 'package:flutter/material.dart';

class DispositionProvider extends ChangeNotifier
{
  List<String> _itemsList;
  String _selectedItem;

void setItems(List<String> itemsList)
{
  _itemsList=itemsList;

  notifyListeners();
}
void setSelectedItem(String selectedItem)
{
  _selectedItem=selectedItem;
  notifyListeners();
}




  List<String> get itemsList=>_itemsList;
  String get selectedItem=> _selectedItem;



}