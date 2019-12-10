import 'package:intl/intl.dart';

abstract class TextUtils {
  static var _formatter = DateFormat('yyyy-MM-dd HH:mm');

  static String formatDate(DateTime date) {
    return _formatter.format(date);
  }
}