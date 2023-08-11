import 'package:expenses/expense_item_view.dart';
import 'package:expenses/models/expense.dart';
import 'package:flutter/material.dart';

class ExpensesAdapter extends StatelessWidget {
  ExpensesAdapter(
      {super.key, required this.expenses, required this.removeExpense});
  List<Expense> expenses;
  final void Function(Expense expense) removeExpense;

  @override
  Widget build(context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(expenses[index]),
        child: ExpenseItemView(expenses[index]),
        onDismissed: (direction) => {removeExpense(expenses[index])},
      ),
    );
  }
}
