import 'dart:math';

extension StringOpEx on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
}

extension StringEx on String {
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }

  String substringBefore(String delimiter) {
    final index = indexOf(delimiter);
    return index == -1 ? this : substring(0, index);
  }

  String get lastPath => split('/').last;

  String get removeExtension {
    final lastDot = lastIndexOf('.');
    return lastDot != -1 ? substring(0, lastDot) : this;
  }

  String get lastPathWithoutExtension => lastPath.removeExtension;

  String get extension {
    final lastDot = lastIndexOf('.');
    return lastDot != -1 ? substring(lastDot + 1) : '';
  }
}

class StringsUtils {
  static String formatFileSize(int bytes, {int decimals = 1}) {
    if (bytes <= 0) return '0 B';

    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
    final i = (log(bytes) / log(1024)).floor();

    return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }
}

extension IntEx on int {
  Map<String, int> parseDuration() {
    int totalDays = this;
    const int daysInYear = 365;
    const int daysInMonth =
        30; // Approximate, considering all months have 30 days

    int years = totalDays ~/ daysInYear;
    int remainingDays = totalDays % daysInYear;

    int months = remainingDays ~/ daysInMonth;
    remainingDays = remainingDays % daysInMonth;

    Map<String, int> durationMap = {
      'year': years,
      'month': months,
      'day': remainingDays
    };

    return durationMap;
  }

  String toFormatString({int minCharCount = 2}) {
    return toString().padLeft(minCharCount, '0');
  }
}
