App Architecture
Pages
1. HomePage
The entry point of the app. Contains a simplified filter bar for quick searches.
Widgets:
`DropDown` — finalidade (venda / aluguel)
`DropDown` — tipo (casa, apartamento, lote, etc.)
`DropDown` — cidade
`DropDown` — quartos
`Button` — "Pesquisar"
Logic:
The dropdowns store their selected values in Widget State automatically
No actions are needed on the dropdowns themselves
All logic is concentrated on the "Pesquisar" button
Pesquisar Button Actions:
Navigate to `BuscaAvancada`
Pass parameters: `finalidade`, `tipo`, `cidade`, `quarto`
---
2. BuscaAvancada (Advanced Search / Results Page)
Receives parameters from HomePage, manages its own filter state, and displays results via a Supabase-powered ListView.
Page Parameters (received from HomePage):
`finalidade` — String
`tipo` — String
`cidade` — String
`quarto` — String
Page State variables (internal filter state):
Variable	Type	Default
`finalidadeFiltro`	String	`""`
`tipoFiltro`	String	`""`
`cidadeFiltro`	String	`""`
`quartosFiltro`	String	`""`
`banheirosFiltro`	Integer	`0`
`precoMinFiltro`	Double	`0`
`precoMaxFiltro`	Double	`99999999`
On Page Load Actions:
Updates each Page State variable with the corresponding received parameter:
`finalidadeFiltro` ← parameter `finalidade`
`tipoFiltro` ← parameter `tipo`
`cidadeFiltro` ← parameter `cidade`
`quartosFiltro` ← parameter `quarto`
Widgets:
`DropDown` — finalidade
`DropDown` — tipo
`DropDown` — cidade
`DropDown` — quartos
`DropDown` — banheiros
`TextField` — preço mínimo
`TextField` — preço máximo
`Button` — "Pesquisar"
`Button` — "Limpar Filtros"
`ListView` — results
Pesquisar Button Actions:
Update Page State with current widget values
Rebuild ListView
Limpar Filtros Button Actions:
Navigate to `BuscaAvancada` without passing any parameters
This triggers On Page Load with null values
Page State resets to defaults
ListView reloads with no filters active
---
3. Details Page
Displays full details for a selected property.
Page Parameters:
`imovelSelecionado` — the selected property row from Supabase
---
Data Flow Diagram
```
┌─────────────────────────────────────────────────┐
│                   HomePage                       │
│                                                  │
│  \[Dropdown: finalidade]  \[Dropdown: tipo]        │
│  \[Dropdown: cidade]      \[Dropdown: quartos]     │
│                                                  │
│              \[Button: Pesquisar]                 │
└──────────────────────┬──────────────────────────┘
                       │ Navigate + Pass Parameters
                       │ (finalidade, tipo, cidade, quarto)
                       ▼
┌─────────────────────────────────────────────────┐
│               BuscaAvancada                      │
│                                                  │
│  On Page Load                                    │
│  └── Update Page State ← Parameters             │
│                                                  │
│  \[Filters UI: dropdowns + text fields]           │
│                                                  │
│  Page State: finalidadeFiltro, tipoFiltro,       │
│              cidadeFiltro, quartosFiltro,         │
│              banheirosFiltro, precoMin, precoMax  │
│                                                  │
│  ListView                                        │
│  └── Supabase Query on "imoveis"                 │
│        └── Filters from Page State               │
│              (via Custom Functions)              │
└─────────────────────────────────────────────────┘
```
---
State Management Summary
Concept	What it is	Used for
Widget State	Value stored inside a widget	Dropdown selected value, TextField input
Page State	Variables scoped to the page	Driving Supabase queries
Page Parameters	Values passed between pages on navigation	Carrying filter selections from HomePage to BuscaAvancada
