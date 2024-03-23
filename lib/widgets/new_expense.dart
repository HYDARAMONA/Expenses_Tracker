import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:expenses_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  NewExpense({super.key, required this.addingExpenses});
  final void Function(Expense) addingExpenses;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _enteredTitle = TextEditingController();
  final _enteredAmount = TextEditingController();

  // var _enteredTitle = '';
  // void _saveTitleInput(String inputValue) {
  //   _enteredTitle = inputValue;
  // }
  DateTime? _selectedDate;
  var _selectedCategory = Category.leisure;
  void _dateSeclectingPannel() async {
    final todayDate = DateTime.now();
    final firstSelectDate = DateTime(
      todayDate.year - 1,
      todayDate.month,
      todayDate.day,
    );

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: todayDate,
      firstDate: firstSelectDate,
      lastDate: todayDate,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final titleValidChecker = _enteredTitle.text.trim().isEmpty;
    final amountConverter = double.tryParse(_enteredAmount.text);
    final amountValidChecker = amountConverter == null || amountConverter <= 0;
    if (titleValidChecker || amountValidChecker || _selectedDate == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
              'Please make sure to enter valid Title, Amount and date.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }
    widget.addingExpenses(Expense(
        Title: _enteredTitle.text,
        Ammount: amountConverter,
        Date: _selectedDate!,
        category: _selectedCategory));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _enteredTitle.dispose();
    _enteredAmount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _enteredTitle,
            // onChanged: _saveTitleInput,
            maxLength: 50,
            maxLengthEnforcement: MaxLengthEnforcement.none,
            keyboardType:
                TextInputType.text, //which is the default keyboard type
            decoration: InputDecoration(label: Text('Title')),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _enteredAmount,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: '\$',
                    // prefix: Text('\$'),
                    label: Text('Amount'),
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_selectedDate == null
                        ? 'No Date Selected'
                        : formatter.format(_selectedDate!)),
                    IconButton(
                      onPressed: _dateSeclectingPannel,
                      icon: Icon(Icons.date_range),
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              DropdownButton(
                  value: _selectedCategory,
                  items: Category.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(
                            category.name.toUpperCase(),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    // print(value);
                    setState(() {
                      _selectedCategory = value;
                    });
                  }),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cansel'),
              ),
              ElevatedButton(
                onPressed: _submitExpenseData,
                child: const Text('Save Expense'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
