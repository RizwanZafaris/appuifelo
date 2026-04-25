import 'package:intl/intl.dart';

String formatMinorMoney({
  required int minor,
  required String currency,
  String locale = 'en',
}) {
  final amount = minor / 100;
  final formatter = NumberFormat.simpleCurrency(name: currency, locale: locale);
  return formatter.format(amount);
}
