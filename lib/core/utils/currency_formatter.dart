import 'package:intl/intl.dart';

class CurrencyFormatter {
  static final _formatter = NumberFormat.currency(
    symbol: '\u20A6',
    decimalDigits: 2,
  );

  static final _compactFormatter = NumberFormat.compactCurrency(
    symbol: '\u20A6',
    decimalDigits: 0,
  );

  static String format(double amount) => _formatter.format(amount);

  static String formatCompact(double amount) =>
      _compactFormatter.format(amount);

  static String formatWithSign(double amount) {
    final formatted = _formatter.format(amount.abs());
    return amount >= 0 ? '+$formatted' : '-$formatted';
  }
}
