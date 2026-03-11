# Banco de Dados

O banco de dados da plataforma é hospedado no Supabase utilizando PostgreSQL.

## Tabela: imoveis

Armazena as informações principais dos imóveis cadastrados na plataforma.

Campos:

- imovel_id -> identificador único do imóvel
- corretor_id -> id do corretor responsável pelo imóvel
- titulo -> título do anúncio do imóvel
- descricao -> descrição completa do imóvel
- tipo -> tipo do imóvel (casa, apartamento, lote)
- finalidade -> venda ou aluguel
- valor -> valor do imóvel
- area -> metragem do imóvel
- quartos -> quantidade de quartos
- banheiros -> quantidade de banheiros
- garagem -> quantidade de vagas de garagem
- cidade -> cidade do imóvel
- bairro -> localização mais específica dentro da cidade
- imagem -> URL da imagem principal do imóvel
- disponivel -> booleano indicando se o imóvel está disponível

## Tabela: leads

Armazena contatos enviados por usuários interessados em um imóvel.

Campos:

- lead_id -> identificador do lead
- imovel_id -> imóvel de interesse
- corretor_id -> corretor responsável pelo imóvel
- nome -> nome da pessoa interessada
- telefone -> telefone para contato
- email -> email do interessado
- mensagem -> mensagem enviada pelo usuário

obs: Não estou utilizando essa tabela nesse site por enquanto

## Tabela: usuarios

Armazena usuários da plataforma (corretores ou administradores).

Campos:

- user_id -> identificador único do usuário
- nome -> nome do usuário
- email -> email de login
- foto_perfil -> imagem de perfil do usuário

## Relação entre tabelas

usuarios
↓
imoveis
↓
leads

Explicação:

Um usuário (corretor) pode cadastrar vários imóveis.
Um imóvel pode gerar vários leads.
Cada lead está relacionado a um imóvel específico.
