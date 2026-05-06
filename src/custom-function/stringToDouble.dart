// stringToDouble.dart
//
// Used in: BuscaAvancada — On TextField Submit for precoMinFiltro and precoMaxFiltro
//
// TextFields always return String in FlutterFlow.
// This function converts the user's price input to double before storing in Page State.
//
// Returns null when the field is empty — this preserves the Page State default value
// (0 for min, 99999999 for max) instead of overwriting it with an invalid value.

double? stringToDouble(String? value) {
  if (value == null || value.isEmpty) return null;
  return double.tryParse(value);
}
