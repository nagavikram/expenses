import 'package:expenses/expenses_list.dart';
import 'package:expenses/models/add_expense.dart';
import 'package:expenses/models/expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<StatefulWidget> createState() {
    return _Expenses();
  }
}

class _Expenses extends State {
  List<Expense> expensesData = [];
  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('No Expenses are available'),
    );
    if (expensesData.isNotEmpty) {
      mainContent = ExpensesAdapter(
        expenses: expensesData,
        removeExpense: removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
          title: const Text('Expense Tracker'),
          backgroundColor: const Color.fromARGB(102, 5, 75, 133),
          actions: [
            IconButton(
                onPressed: () {
                  openAddExpenseView();
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ))
          ]),
      body: Column(children: [
        Expanded(
          child: mainContent,
        ),
      ]),
    );
  }

  void openAddExpenseView() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => AddExpense(addExpense: addExpense));
  }

  void addExpense(Expense expense) {
    setState(() {
      expensesData.add(expense);
    });
    Navigator.pop(context);
  }

  void removeExpense(Expense expense) {
    setState(() {
      expensesData.remove(expense);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense Deleted'),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                expensesData.add(expense);
              });
            }),
      ),
    );
  }
}
