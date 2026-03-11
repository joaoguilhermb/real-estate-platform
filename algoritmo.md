# Algoritmo do sistema

Esse documento descreve o funcionamento lógico da plataforma de imóveis.
## Página principal
- O usuário acessa a pagina inicial dos imóveis
- Na página vai conter o filtro disponível para filtragem dos imóveis;
- Abaixo, na mesma pagina, terá os imóveis em destaque exibidos em card, formato carrossel.
- O usuário poderá escolher o imóvel de sua preferência e clicar para ser levado à pagina de detalhes do imóvel.

## Detalhes do imóvel 
- Ao ser direcionado à página do imóvel, a pagina irá puxar os dados do card escolhido através de um parâmetro.
- O sistema envia o ID do imóvel para a página de detalhes
- A página consulta o banco de dados
- Nela conterá mais informações sobre o imóvel, como:
  título, preço, n° de quartos, banheiros, garagem, descrição, localização.
- E um botão "Tenho interesse" que direcionará ao contato do corretor. 

  
