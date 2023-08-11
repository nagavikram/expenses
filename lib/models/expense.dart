import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
var dateFormat = DateFormat('dd-MMM-yyyy');

enum Category { food, travel, home, other }

class Expense {
  Expense(
      {required this.name,
      required this.amount,
      required this.dateTime,
      required this.categoty})
      : id = uuid.v4();

  String id;
  String name;
  double amount;
  DateTime dateTime;
  Category categoty;

  String get formattedDate {
    return dateFormat.format(dateTime);
  }
}
