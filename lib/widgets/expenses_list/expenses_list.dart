import 'package:expenses_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:expenses_tracker/models/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expensesList, required this.expensesRemover});
  final List<Expense> expensesList;
  final void Function(Expense) expensesRemover;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expensesList.length,
      itemBuilder: (buildContext, index) {
        return Dismissible(
          background: Container(
            color: Theme.of(context)
                .colorScheme
                .copyWith()
                .error
                .withOpacity(0.75),
            margin: Theme.of(context).cardTheme.margin,
          ),
          onDismissed: (dismissDirection) {
            expensesRemover(expensesList[index]);
          },
          key: ValueKey(expensesList[index]),
          child: ExpenseItem(
            expensesList[index],
          ),
        );
      },
    );
  }
}
