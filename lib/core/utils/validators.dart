class Validators {
  Validators._();

  static String? required(String? v) =>
      (v == null || v.trim().isEmpty) ? 'requiredField' : null;

  static String? name(String? v) {
    if (v == null || v.trim().isEmpty) return 'requiredField';
    if (v.trim().length < 3) return 'invalidName';
    return null;
  }

  static String? phone(String? v) {
    if (v == null || v.trim().isEmpty) return 'requiredField';
    final digits = v.replaceAll(RegExp(r'\D'), '');
    if (digits.length < 9 || digits.length > 15) return 'invalidPhone';
    return null;
  }
}