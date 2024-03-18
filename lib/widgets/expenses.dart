import 'package:expenses_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expenses_tracker/Moduls/expense.dart';
import 'package:expenses_tracker/widgets/expenses_list/expenses_list.dart';

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
        Ammount: 34,
        Date: DateTime.now(),
        category: Category.food),
    Expense(
        Title: 'work',
        Ammount: 34,
        Date: DateTime.now(),
        category: Category.work)
  ];
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
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
      body: Column(children: [
        const Text('The Chart'),
        Expanded(child: mainContent),
      ]),
    );
  }
}
