class MoneyTransactionModel {
  int id;
  String transactionMode;
  String title;
  String category;
  String date;
  int amount;
  int balanceAmount;
  int totalIncome;
  int totalExpense;

  MoneyTransactionModel(
      {required this.id,
      required this.transactionMode,
      required this.title,
      required this.category,
      required this.date,
      required this.amount,
      this.balanceAmount = 1000,
      this.totalIncome = 0,
      this.totalExpense = 0});
}