// optionalMinFilter.dart
//
// Used in: BuscaAvancada ListView query (Valor >= precoMinFiltro, banheiros >= banheirosFiltro)
// Relation: >=
//
// Returns 0 when value is null — so the query becomes "field >= 0"
// which matches all records, effectively skipping the filter.

double optionalMinFilter(double? value) {
  return value ?? 0;
}
