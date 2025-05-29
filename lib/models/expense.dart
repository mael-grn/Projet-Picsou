class Expense {
  final int id;
  final String name;
  final String description;
  final DateTime date;
  final double amount;
  final int stockParts;

  const Expense(
      this.id,
      this.name,
      this.description,
      this.date,
      this.amount,
      this.stockParts,
      );

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      json['id'],
      json['name'],
      json['description'],
      DateTime.parse(json['date']),
      (json['amount'] as num).toDouble(),
      json['stock_parts'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'date': date.toIso8601String(),
      'amount': amount,
      'stock_parts': stockParts,
    };
  }

  static bool checkNameFormat(String? name) {
    if (name == null ||
        name.isEmpty ||
        name.length < 2 ||
        name.length > 50 ||
        name.contains(" ")) {
      return false;
    }
    return true;
  }

  static String? checkNameFormatValidator(String? name) =>
      checkNameFormat(name)
          ? null
          : "Le nom doit contenir entre 2 et 50 caractères et ne doit pas contenir d'espaces.";

  static bool checkDateFormat(DateTime? date) {
    if (date == null || date.isBefore(DateTime.now())) {
      return false;
    }
    return true;
  }

  static String? checkDateFormatValidator(DateTime? date) =>
      checkDateFormat(date)
          ? null
          : "La date doit être postérieure à aujourd'hui.";

  static bool checkAmountFormat(double? amount) {
    if (amount == null || amount <= 0) {
      return false;
    }
    return true;
  }

  static String? checkAmountFormatValidator(double? amount) =>
      checkAmountFormat(amount)
          ? null
          : "Le montant doit être supérieur à 0.";

  static bool checkStockPartsFormat(int? stockParts) {
    if (stockParts == null || stockParts <= 1) {
      return false;
    }
    return true;
  }

  static String? checkStockPartsFormatValidator(int? stockParts) =>
      checkStockPartsFormat(stockParts)
          ? null
          : "Le nombre de parts doit être supérieur à 1.";


}