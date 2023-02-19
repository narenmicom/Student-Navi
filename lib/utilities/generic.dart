import 'package:intl/intl.dart';

String getTodaysDate() {
  var now = DateTime.now();
  var formatter = DateFormat('yyyy-MM-dd');
  String date = formatter.format(now);
  return date;
}

String getTodaysDateNormal() {
  var now = DateTime.now();
  var formatter = DateFormat('dd-MM-yyyy');
  String date = formatter.format(now);
  return date;
}
