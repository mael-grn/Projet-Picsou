import 'package:projet_picsou/models/participant.dart';

import 'contributor.dart';
import 'group.dart';

class Expense {
  final int? id;
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
      DateTime.parse(json['created_at']),
      (json['montant'] as num).toDouble(),
      json['stock_parts'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'created_at': date.toIso8601String().split('.').first,
      'montant': amount, //ostie de tabarnak
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

class DetailedExpense {
  final Expense expense;
  final List<Contributor> contributors;
  final List<Participant> participants;
  final Group? group;

  const DetailedExpense(
      this.expense,
      this.contributors,
      this.participants,
      this.group
      );

  factory DetailedExpense.fromJson(Map<String, dynamic> json) {
    return DetailedExpense(
      Expense.fromJson(json['expense']),
      (json['contributors'] as List)
          .map((contributor) => Contributor.fromJson(contributor))
          .toList(),
      (json['participants'] as List)
          .map((participant) => Participant.fromJson(participant))
          .toList(),
      Group.fromJson(json['group']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'contributors': contributors.map((c) => c.toJson()).toList(),
      'participants': participants.map((p) => p.toJson()).toList(),
      'expense': expense.toJson()
    };
  }
}

class VeryDetailedExpense {
  final Expense expense;
  final List<DetailedContributor> contributors;
  final List<DetailedParticipant> participants;
  final Group? group;

  const VeryDetailedExpense(
      this.expense,
      this.contributors,
      this.participants,
      this.group
      );

  factory VeryDetailedExpense.fromJson(Map<String, dynamic> json) {
    return VeryDetailedExpense(
      Expense.fromJson(json['expense']),
      (json['contributors'] as List)
          .map((contributor) => DetailedContributor.fromJson(contributor))
          .toList(),
      (json['participants'] as List)
          .map((participant) => DetailedParticipant.fromJson(participant))
          .toList(),
      Group.fromJson(json['group']),
    );
  }
}