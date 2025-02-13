class SafeCast {
  static String? asString(dynamic value) {
    return value is String ? value : null;
  }

  static String asStringOr(dynamic value, String defaultValue) {
    return value is String ? value : defaultValue;
  }

  static int? asInt(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    if (value is double) return value.toInt();
    return null;
  }

  static int asIntOr(dynamic value, int defaultValue) {
    return asInt(value) ?? defaultValue;
  }

  static double? asDouble(dynamic value) {
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  static double asDoubleOr(dynamic value, double defaultValue) {
    return asDouble(value) ?? defaultValue;
  }

  static bool? asBool(dynamic value) {
    if (value is bool) return value;
    if (value is String) {
      value = value.toLowerCase();
      if (value == 'true') return true;
      if (value == 'false') return false;
    }
    return null;
  }

  static bool asBoolOr(dynamic value, bool defaultValue) {
    return asBool(value) ?? defaultValue;
  }

  static List<T>? asList<T>(dynamic value) {
    if (value is List) {
      try {
        return value.cast<T>();
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  static Map<K, V>? asMap<K, V>(dynamic value) {
    if (value is Map) {
      try {
        return value.cast<K, V>();
      } catch (_) {
        return null;
      }
    }
    return null;
  }
}
