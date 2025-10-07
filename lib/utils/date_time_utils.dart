import 'package:intl/intl.dart';

String formatDateToString(DateTime dateTime) {
  final formatter = DateFormat('d MMMM y', 'id_ID');

  return formatter.format(dateTime);
}