import 'package:expenses_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expenses_tracker/models/expense.dart';
import 'package:expenses_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expenses_tracker/widgets/chart/chart.dart';

class Expenses extends StatefulWidget {
  Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        Title: 'burger',
        Ammount: 35,
        Date: DateTime.now(),
        category: Category.food),
    Expense(
        Title: 'work',
        Ammount: 25,
        Date: DateTime.now(),
        category: Category.work)
  ];
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
      context: context,
      isScrollControlled: true,
      builder: (context) => NewExpense(addingExpenses: _newExpensesAdder),
    );
  }

  void _newExpensesAdder(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _expensesRemover(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Expense Deleted'),
      duration: const Duration(seconds: 3),
      action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          }),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final hight = MediaQuery.of(context).size.height;
    Widget mainContent = const Center(
      child: Text('No Expences Are There, Add Some'),
    );
    if (_registeredExpenses.isNotEmpty) {
      setState(() {
        mainContent = ExpensesList(
          expensesList: _registeredExpenses,
          expensesRemover: _expensesRemover,
        );
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: hight > width
          ? Column(children: [
              Chart(expenses: _registeredExpenses),
              Expanded(child: mainContent),
            ])
          : Row(children: [
              Expanded(child: Chart(expenses: _registeredExpenses)),
              Expanded(child: mainContent),
            ]),
    );
  }
}
