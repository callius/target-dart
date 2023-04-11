extension TargetStringExtensions on String {
  int? toIntOrNull({int? radix}) => int.tryParse(this, radix: radix);
}
