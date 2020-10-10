import 'dart:io';

import 'package:flutter_skyplight/helper/AppConstants.dart';
import 'package:flutter_skyplight/helper/UserModel.dart';
import 'package:flutter_skyplight/model/LeadModel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;
import 'package:sqflite/sqflite.dart';

class AppDBHelper {
  AppDBHelper._privateConstructor();

  static final AppDBHelper instance = AppDBHelper._privateConstructor();
  static String dbName = "Skylight.db";
  static String tableName = "signup";
  static String tableRegister = "register";
  static String columnId = "id";
  static String columnUName = "user_name";
  static String columnPassWord = "password";
  static String columnStatus = "status";
  static String columnFirstName = "firstName";
  static String columnLastName = "lastName";
  static String columnStreetAddress = "streetAddress";
  static String columnCity = "city";
  static String columnState = "state";
  static String columnPostalCode = "postalCode";
  static String columnPhoneNumber = "phoneNumber";
  static String columnEmail = "email";
  static String columnIdLicense = "idLicense";
  static String columnRoutingNum = "routingNum";
  static String columnAccountNumber = "accountNumber";
  static String columnBankName = "bankName";
  static String columnUserName = "userName";
  static String columnPassword = "password";
  static String columnPhoto = "photo";

  ////////////////////////////////////////
  ///////////// LEADS TABLE /////////////
  static String tableLeads = "leads";
  static String colIdLead = "leadId";
  static String colLeadFName = "leadFirstName";
  static String colLeadLName = "leadLastName";
  static String colLeadPhone = "leadPhone";
  static String colLeadSecPhone = "leadSecPhone";
  static String colLeadAddress = "leadAddress";
  static String colLeadCity = "leadCity";
  static String colLeadState = "leadState";
  static String colLeadPostalCode = "leadPinCode";
  static String colLeadHouseholdImage = "householdPhoto";
  static String colLeadHouseholdYUsage = "householdYUsage";
  static String colLeadHouseholdMUsage = "householdMUsage";
  static String colLeadFinancialInfoTime = "financialInfoTime";
  static String colLeadUtilityCompany = "utilityCompany";
  static String colLeadUtilityCompanyMaxOffset = "maxOffset";
  static String colLeadType = "leadType";
  static String colLeadCounty = "leadCounty";
  static String colLeadNotes = "leadNotes";
  static String colTime = "leadCreatedTime";

  ////////////////////////////////////////
  ////////////////////////////////////////

  static int dbVersion = 2;
  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    } else {
      return _database = await initDatabase();
    }
  }

  initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbName);
    return await openDatabase(path, version: dbVersion, onCreate: onCreate);
  }

  Future onCreate(Database db, int version) {
    db.execute('''
    CREATE TABLE $tableName (
    $columnId INTEGER,
    $columnUName TEXT NOT NULL,
    $columnEmail TEXT PRIMARY KEY,
    $columnPassWord TEXT,
    $columnStatus TEXT
    ) ''');

    db.execute('''
    CREATE TABLE $tableRegister (
    $columnId INTEGER AUTO_INCREMENT,
    $columnFirstName TEXT,
    $columnLastName TEXT,
    $columnStreetAddress TEXT,
    $columnCity TEXT,
    $columnState TEXT,
    $columnPostalCode TEXT,
    $columnPhoneNumber TEXT,
    $columnEmail TEXT PRIMARY KEY,
    $columnIdLicense TEXT,
    $columnRoutingNum TEXT,
    $columnAccountNumber TEXT,
    $columnBankName TEXT,
    $columnUserName TEXT NOT NULL,
    $columnPassword TEXT,
    $columnPhoto TEXT
    ) ''');

    db.execute('''
    CREATE TABLE $tableLeads (
    $colIdLead INTEGER AUTO_INCREMENT,
    $colLeadFName TEXT,
    $colLeadLName TEXT,
    $colLeadAddress TEXT,
    $colLeadCity TEXT,
    $colLeadState TEXT,
    $colLeadPostalCode TEXT,
    $colLeadPhone TEXT,
    $colLeadSecPhone TEXT,
    $colLeadHouseholdImage TEXT,
    $colLeadHouseholdYUsage TEXT,
    $colLeadHouseholdMUsage TEXT,
    $colLeadFinancialInfoTime TEXT,
    $colLeadType TEXT,
    $colLeadUtilityCompany TEXT,
    $colLeadUtilityCompanyMaxOffset TEXT,
    $colLeadCounty TEXT,
    $colLeadNotes TEXT,
    $colTime TEXT
    ) ''');
  }

  Future<int> insert(Map<String, dynamic> itemRow) async {
    Database database = await instance.database;
    return await database.insert(tableName, itemRow);
  }

  Future<int> insertRegister(Map<String, dynamic> itemRow) async {
    Database database = await instance.database;
    return await database.insert(tableRegister, itemRow);
  }

  Future<List<Map<String, dynamic>>> queryRegisterAll(String tableName) async {
    Database database = await instance.database;
    return await database.query(tableName);
  }

  Future<List<Map<String, dynamic>>> getUserName() async {
    Database database = await instance.database;
    return await database.rawQuery('select $columnUserName from $tableName');
  }

  Future<List<Map<String, dynamic>>> queryAll(String tableName) async {
    Database database = await instance.database;
    return await database.query(tableName);
  }

  Future<List<Map<String, dynamic>>> querySelectOne(String email) async {
    Database database = await instance.database;
    return await database
        .query(tableRegister, where: '$columnEmail = ? ', whereArgs: [email]);
  }

  Future<int> update(Map<String, dynamic> itemRow) async {
    Database database = await instance.database;
    String email = itemRow[columnEmail];
    return await database.update(tableName, itemRow,
        where: '$columnEmail = ? ', whereArgs: [email]);
  }

  Future<int> delete(String tableName, String email) async {
    Database database = await instance.database;
    return await database
        .delete(tableName, where: '$columnEmail = ? ', whereArgs: [email]);
  }

//  Future<UserModel> getLogin(String email, String password) async {
//    Database database = await instance.database;
//    var res = await database.rawQuery("SELECT * FROM $tableName WHERE $columnEmail = '$email' and $columnPassWord = '$password'");
//
//    if (res.length > 0) {
//      return new UserModel.fromMap(res.first);
//    }
//    return null;
//  }
  Future<UserModel> getLogin(String email, String password) async {
    Database database = await instance.database;
    var res = await database.rawQuery(
        "SELECT * FROM $tableRegister WHERE $columnEmail = '$email' and $columnPassword = '$password'");

    if (res.length > 0) {
      return new UserModel.fromMap(res.first);
    }
    return null;
  }

  Future<int> addLead(Map<String, dynamic> itemRow) async {
    Database database = await instance.database;
    return await database.insert(tableLeads, itemRow);
  }
  Future<List<LeadModel>> getLeads() async {
    Database database = await instance.database;
    var res = await database.rawQuery(
        "SELECT * FROM $tableLeads");

    List<LeadModel> leadsList=List();

    if (res.length > 0) {

      leadsList=res.map((item) => LeadModel.fromJson(item)).toList();
    }
    return leadsList;
  }
  Future<List<LeadModel>> searchLeads(String searchText) async {
    Database database = await instance.database;
    var res = await database.rawQuery(
        "SELECT * FROM $tableLeads WHERE leadFirstName LIKE '$searchText%'");

    List<LeadModel> leadsList=List();

    if (res.length > 0) {

      leadsList=res.map((item) => LeadModel.fromJson(item)).toList();

    }
    return leadsList;
  }

}
