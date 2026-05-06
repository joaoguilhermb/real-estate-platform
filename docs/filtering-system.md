# Filtering System

## Overview

The filtering system works in two stages:

1. **Stage 1 — HomePage**: Simple filter with 4 dropdowns
2. **Stage 2 — BuscaAvancada**: Full advanced filter with 7 filter fields

---

## The Core Problem: FlutterFlow Applies All Filters Unconditionally

FlutterFlow's native query builder applies every filter you add to a ListView — always. There is no built-in toggle like "apply this filter only if the user filled it in."

This means that if a filter field is empty (null or `""`), the query still runs with that empty value, which causes:
- `Cidade LIKE null` → query error or zero results
- `quartos >= null` → query breaks
- `Valor >= null` → loading forever

**Solution: Custom Dart Functions as filter wrappers.**

---

## How Optional Filters Work

### For text fields (finalidade, tipo, cidade)

The query uses `LIKE` relation with the `optionalTextFilter` function:

```
finalidade LIKE optionalTextFilter(finalidadeFiltro)
```

**How it works:**
- User selected "venda" → function returns `"venda"` → query filters by `finalidade LIKE 'venda'`
- User selected nothing → function returns `"%"` → query runs `finalidade LIKE '%'` → matches everything → no filter applied

### For numeric minimum fields (quartos, banheiros, precoMin)

The query uses `>=` relation:

```
quartos >= optionalMinFilterFromString(quartosFiltro)
banheiros >= optionalMinFilter(banheirosFiltro)
Valor >= optionalMinFilter(precoMinFiltro)
```

**How it works:**
- User selected "2" → function returns `2` → query filters `quartos >= 2`
- User selected nothing → function returns `0` → query runs `quartos >= 0` → matches everything → no filter applied

### For numeric maximum fields (precoMax)

```
Valor <= optionalMaxFilter(precoMaxFiltro)
```

- User typed "500000" → returns `500000` → filters `Valor <= 500000`
- User typed nothing → returns `99999999` → effectively no upper limit

---

## Filter Query Configuration

| Field | Relation | Function | Page State variable |
|---|---|---|---|
| `finalidade` | LIKE | `optionalTextFilter` | `finalidadeFiltro` |
| `tipo` | LIKE | `optionalTextFilter` | `tipoFiltro` |
| `Cidade` | LIKE | `optionalTextFilter` | `cidadeFiltro` |
| `quartos` | >= | `optionalMinFilterFromString` | `quartosFiltro` |
| `banheiros` | >= | `optionalMinFilter` | `banheirosFiltro` |
| `Valor` | >= | `optionalMinFilter` | `precoMinFiltro` |
| `Valor` | <= | `optionalMaxFilter` | `precoMaxFiltro` |

> ⚠️ All filters use **AND** logic (`isOrQuery: false`). Using OR with mixed types (text + numeric) causes Supabase to fail silently.

---

## TextField → Page State flow for price fields

TextFields always return `String`. The `Valor` column in Supabase is `numeric`. A conversion step is needed:

```
User types in TextField (String)
        ↓
On TextField Submit
        ↓
Update Page State using stringToDouble(TextFieldValue)
        ↓
Page State (Double) stores converted value
        ↓
Query uses optionalMinFilter / optionalMaxFilter on Page State
```

If the TextField is empty, `stringToDouble` returns `null`, and the Page State keeps its default value (`0` or `99999999`).

---

## Clear Filters Flow

Resetting filters via "Update Page State" had a persistence bug in the FlutterFlow editor (changes were not being saved to YAML). The reliable workaround:

```
User clicks "Limpar Filtros"
        ↓
Navigate to BuscaAvancada (no parameters passed)
        ↓
On Page Load runs with null parameters
        ↓
Page State variables stay at their defaults:
  finalidadeFiltro = ""
  tipoFiltro = ""
  cidadeFiltro = ""
  quartosFiltro = ""
  banheirosFiltro = 0
  precoMinFiltro = 0
  precoMaxFiltro = 99999999
        ↓
ListView queries with all optional filters = no restrictions
        ↓
All available properties are shown
```

---

## Empty State

When the Supabase query returns zero results (valid query but no matching properties), the ListView displays an empty state widget (`Container_sxyunduq`) with a "no results found" message. This is configured via the ListView's `emptyListWidget` property in FlutterFlow.
