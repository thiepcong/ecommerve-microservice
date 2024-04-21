import 'package:intl/intl.dart';

extension DoubleX on double {
  String formatCurrency() {
    String formattedValue = toStringAsFixed(0);
    final formatter = NumberFormat("#,##0", "en_US");
    return formatter.format(double.parse(formattedValue));
  }
}
