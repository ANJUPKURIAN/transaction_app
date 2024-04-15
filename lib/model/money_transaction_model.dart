class MoneyTransactionModel {
  int id;
  String transactionMode;
  String title;
  String category;
  String date;
  int amount;

  MoneyTransactionModel(
      {
        required this.id,
      required this.transactionMode,
      required this.title,
      required this.category,
      required this.date,
      required this.amount});
}

