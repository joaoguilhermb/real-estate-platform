// optionalMinFilterFromString.dart
//
// Used in: BuscaAvancada ListView query (quartos >= quartosFiltro)
// Relation: >=
//
// Dropdowns in FlutterFlow return String values.
// This function converts the String to int for use with integer columns.
// Returns 0 when value is null or empty — matching all records (no filter applied).

int optionalMinFilterFromString(String? value) {
  if (value == null || value.isEmpty) return 0;
  return int.tryParse(value) ?? 0;
}
