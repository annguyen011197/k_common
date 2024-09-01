extension StringOpEx on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
}

extension StringEx on String {}

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
