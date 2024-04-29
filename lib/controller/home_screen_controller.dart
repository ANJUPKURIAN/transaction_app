import 'dart:developer';
import 'package:transaction_app/model/money_transaction_model.dart';
import 'package:sqflite/sqflite.dart';

class HomeScreenController {
  static late Database database;
  static List<Map<String, Object?>> data = [];
  static List<MoneyTransactionModel> transactionList = [];

  static int balanceAmount = 0;
  static int totalIncome = 0;
  static int totalExpense = 0;

  //to initalise database
  static Future<void> initDb() async {
    // open the database
    database = await openDatabase('sample.db', version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Details(id INTEGER PRIMARY KEY, type TEXT, title TEXT, category TEXT, date TEXT, amount INTEGER, totalBalance INTEGER, totalIncome INTEGER, totalExpense INTEGER)');
      log('table created');
    });
  }

  static Future addDatas(
      {
        required String mode,
        required String title,
       required String category,
       required String date,
       required int amount}) async {
    // if (mode == "Income") 
    // {
    //   totalIncome = totalIncome + amount;
    // } 
    // else
    //  {
    //   totalExpense = totalExpense + amount;
    // }

    // balanceAmount = totalIncome - totalExpense;

    await database.rawInsert(
        'INSERT INTO Details(mode, title, category, date, amount) VALUES(?, ?, ?, ?, ?,)',
        [
          mode,
          title,
          category,
          date,
          amount,
          // balanceAmount,
          // totalIncome,
          // totalExpense
        ]);
    }

  //get all data from database
  static Future getDatas() async {
    data = await database.rawQuery('SELECT * FROM Details');
    transactionList = data
        .map((e) => MoneyTransactionModel(
            id: int.parse(e["id"].toString()),
            transactionMode: e['mode'].toString(),
            title: e['title'].toString(),
            category: e['category'].toString(),
            date: e['date'].toString(),
            amount: int.parse(e["amount"].toString()),
            // balanceAmount: int.parse(e['totalBalance'].toString()),
            // totalIncome: int.parse(e['totalIncome'].toString()),
            // totalExpense: int.parse(e['totalExpense'].toString()),
             ))
        .toList();
     log(data.toString());
     calculate();
  }

  // static addIncome() {
  //   for (int i = 0; i < transactionList.length; i++) {
  //     totalIncome = totalIncome + transactionList[i].amount;
  //     log(totalIncome.toString());
  //   }

   // static addExpense() {
  //   for (int i = 0; i < transactionList.length; i++) {
  //     totalExpense = totalExpense + transactionList[i].amount;
  //     log(totalExpense.toString());
  //   }
  // }



 static calculate() {
    balanceAmount = 1000;
    totalIncome = 0;
    totalExpense = 0;
    for (var i = 0; i < transactionList.length; i++) {
      if (transactionList[i].transactionMode == "Income") {
        totalIncome = totalIncome + transactionList[i].amount;
      } else {
        totalExpense = totalExpense + transactionList[i].amount;
      }
    }
    balanceAmount = 1000 + totalIncome - totalExpense;
    log(balanceAmount.toString());
    log(balanceAmount.toString());

    }

}