import 'package:expenses/models/expense.dart';
import 'package:flutter/material.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key, required this.addExpense});

  final void Function(Expense expense) addExpense;

  @override
  State<AddExpense> createState() {
    return _AddExpense();
  }
}

class _AddExpense extends State<AddExpense> {
  var controllerExpenseTitle = TextEditingController();
  var controllerExpenseAmount = TextEditingController();
  DateTime? selectedDate;
  Category _selectedCategory = Category.food;

  void viewDatePicker() async {
    var now = DateTime.now();
    var inDate = DateTime(now.year - 1, now.month, now.day);
    var pickedDate = await showDatePicker(
        context: context, initialDate: now, firstDate: inDate, lastDate: now);
    setState(() {
      selectedDate = pickedDate;
    });
  }

  void subExpenseData() {
    var enteredAmount = double.tryParse(controllerExpenseAmount.text);
    var amountIsValid = enteredAmount == null || enteredAmount <= 0;
    if (controllerExpenseTitle.text.trim().isEmpty ||
        amountIsValid ||
        selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Input Failed'),
          content: const Text('Provide Valid data'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }
    widget.addExpense(Expense(
        name: controllerExpenseTitle.text,
        amount: enteredAmount,
        dateTime: selectedDate!,
        categoty: _selectedCategory));
  }

  @override
  void dispose() {
    controllerExpenseTitle.dispose();
    controllerExpenseAmount.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            maxLength: 30,
            controller: controllerExpenseTitle,
            decoration: const InputDecoration(
              label: Text('Expene'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: controllerExpenseAmount,
                  decoration: const InputDecoration(
                    prefix: Text('\$'),
                    label: Text('Amount'),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(selectedDate == null
                        ? 'Select Date'
                        : dateFormat.format(selectedDate!)),
                    IconButton(
                      onPressed: viewDatePicker,
                      icon: const Icon(Icons.calendar_month),
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              DropdownButton(
                  value: _selectedCategory,
                  items: Category.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category.name.toString()),
                        ),
                      )
                      .toList(),
                  onChanged: (item) {
                    if (item == null) {
                      return;
                    }
                    setState(() {
                      _selectedCategory = item;
                    });
                  }),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  subExpenseData();
                },
                child: const Text('Save'),
              )
            ],
          )
        ],
      ),
    );
  }
}
