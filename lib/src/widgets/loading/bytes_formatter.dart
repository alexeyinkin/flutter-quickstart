import 'package:progress_future/progress_future.dart';

enum BytesUnit {
  byte('B', 1),
  kilo('kB', 1024),
  mega('MB', 1024 * 1024),
  giga('GB', 1024 * 1024 * 1024),
  tera('TB', 1024 * 1024 * 1024 * 1024),
  ;

  final String symbol;
  final int bytes;

  const BytesUnit(this.symbol, this.bytes);
}

BytesUnit _getUnit(int n) => switch (n) {
      < 1024 => BytesUnit.byte,
      < 1024 * 1024 => BytesUnit.kilo,
      < 1024 * 1024 * 1024 => BytesUnit.mega,
      < 1024 * 1024 * 1024 * 1024 => BytesUnit.giga,
      _ => BytesUnit.tera,
    };

String _format(int n, {required bool addUnit}) {
  return _formatWithUnit(n, unit: _getUnit(n), addUnit: addUnit);
}

String _formatWithUnit(
  int n, {
  required BytesUnit unit,
  required bool addUnit,
}) {
  return _formatDouble(n / unit.bytes, 2) + (addUnit ? ' ${unit.symbol}' : '');
}

String _formatDouble(double value, int n) {
  final formatted = value.toStringAsFixed(n);
  return formatted.replaceAll(RegExp(r'\.?0*$'), '');
}

/// Returns the formatted string of the [future]'s progress in the appropriate
/// byte units.
String bytesFormatter<R>(ProgressFuture<R, int> future) {
  final progress = future.progress;
  final total = future.total;

  if (total == null) {
    return _format(progress, addUnit: true);
  }

  final progressUnit = _getUnit(progress);
  final totalUnit = _getUnit(total);

  final parts = [
    _format(progress, addUnit: totalUnit != progressUnit),
    _format(total, addUnit: true),
  ];

  return parts.join(' / ');
}
