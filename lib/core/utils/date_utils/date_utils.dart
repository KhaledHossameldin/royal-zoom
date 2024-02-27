import 'package:intl/intl.dart';

class DateUtil {
  static String dateWithTime(DateTime date) {
    return DateFormat('dd/MM/yyyy hh:mm a').format(date);
  }
}
