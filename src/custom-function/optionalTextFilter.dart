// optionalTextFilter.dart
//
// Used in: BuscaAvancada ListView query (finalidade, tipo, Cidade filters)
// Relation: LIKE
//
// Returns '%' when value is null or empty.
// In a LIKE query, '%' matches any string — effectively skipping the filter.
// When value is present, returns the value as-is for exact LIKE matching.

String optionalTextFilter(String? value) {
  if (value == null || value.isEmpty) {
    return '%';
  }
  return value;
}
