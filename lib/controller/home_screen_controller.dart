import 'dart:developer';
import 'package:transaction_app/model/money_transaction_model.dart';
import 'package:sqflite/sqflite.dart';

class HomeScreenController {
  static late Database database;
  static List<Map<String, Object?>> data = [];
  static List<MoneyTransactionModel> transactionList = [];

  //to initalise database
  static Future<void> initDb() async {
    // open the database
    database = await openDatabase('sample.db', version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Details (id INTEGER PRIMARY KEY, type TEXT, title TEXT, category TEXT, date TEXT, amount INTEGER)');
      log('message');
    });
  }

  static Future insertDatas() async {
    await database.rawInsert(
        'INSERT INTO Details(type, title, category, date, amount) VALUES(?, ?, ?, ?, ?)',
        ['Income', 'A-one food', 'food', 'monday', 2104]);
  }

  //get all data from database
  static Future getDatas() async {
    data = await database.rawQuery('SELECT * FROM Details');
    transactionList = data
        .map((e) => MoneyTransactionModel(
            id: int.parse(e["id"].toString()),
            transactionMode: e['type'].toString(),
            title: e['title'].toString(),
            category: e['category'].toString(),
            date: e['date'].toString(),
            amount: int.parse(e["amount"].toString())))
        .toList();
    log(data.toString());
  }
}