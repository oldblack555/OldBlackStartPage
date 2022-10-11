import 'package:intl/intl.dart';

class DateUtil {
  static const String _dateFormat = 'yyyy-MM-dd';

  static String getCurrentDate() {
    DateTime dateTime = DateTime.now();
    DateFormat dateFormat = DateFormat(_dateFormat);
    return dateFormat.format(dateTime);
  }

  static const String _dateRegx =
      r"$([0-9]{3}[1-9]|[0-9]{2}[1-9][0-9]{1}|[0-9]{1}[1-9][0-9]{2}|[1-9][0-9]{3})-(((0[13578]|1[02])-(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)-(0[1-9]|[12][0-9]|30))|(02-(0[1-9]|[1][0-9]|2[0-8])))^";

  static bool isTrueDate(String date) {
    RegExp regExp = RegExp(_dateRegx);
    return regExp.hasMatch(date);
  }
}
