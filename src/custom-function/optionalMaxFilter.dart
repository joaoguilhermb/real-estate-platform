// optionalMaxFilter.dart
//
// Used in: BuscaAvancada ListView query (Valor <= precoMaxFiltro)
// Relation: <=
//
// Returns 99999999 when value is null — so the query becomes "Valor <= 99999999"
// which effectively sets no upper limit, skipping the filter.

double optionalMaxFilter(double? value) {
  return value ?? 99999999;
}
