import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final uuid = Uuid();

enum Category { food, travel, leisure, work }

final formatter = DateFormat.yMd();

final Map categoryIcons = {
  Category.food: Icons.dining,
  Category.travel: Icons.flight,
  Category.work: Icons.work,
  Category.leisure: Icons.movie,
};

class Expense {
  Expense({
    required this.Title,
    required this.Ammount,
    required this.Date,
    required this.category,
  }) : id = uuid.v4();
  final String id;
  final String Title;
  final double Ammount;
  final DateTime Date;
  final Category category;

  String get formattedDate {
    return formatter.format(Date);
  }
}

class ExpensesBucket {
  ExpensesBucket({
    required this.category,
    required this.expenses,
  });

  ExpensesBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpense {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.Ammount;
    }

    return sum;
  }
}
