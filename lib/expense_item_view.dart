import 'package:expenses/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItemView extends StatelessWidget {
  Expense expense;
  ExpenseItemView(this.expense, {super.key});
  @override
  Widget build(context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(children: [
          Text(expense.name),
          Row(
            children: [
              Text(expense.amount.toString()),
              const Spacer(),
              Row(
                children: [
                  const Icon(Icons.calendar_month),
                  Text(expense.formattedDate),
                  const SizedBox(width: 8),
                  const Icon(Icons.work),
                  const SizedBox(width: 8),
                  Text(expense.amount.toString()),
                ],
              )
            ],
          )
        ]),
      ),
    );
  }
}
