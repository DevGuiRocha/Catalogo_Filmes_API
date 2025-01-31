
# API Catálogo de Filmes

Esta API possui como principal dois endpois, sendo eles um POST onde é enviado um arquivo CSV com todos os dados necessários dos filmes a serem gravados e o outro um GET onde é selecionado todos os filmes na base de dados.


## Rodando localmente

Primeiramente faça o clone do repositório para seu ambioente local

```bash
  git clone https://github.com/DevGuiRocha/Catalogo_Filmes_API.git
```

Entre no diretório do projeto

```bash
  cd Catalogo_Filmes_API
```

Instale as dependências necessárias para a execução do projeto

```bash
  bundle install
```

Se necessário, edite o arquivo ```config/database.yml``` para alterar as configurações para seu ambiente local, assim como usuario e senha do PostgreSQL para conexões

Rode os seguintes comandos para que seja criado as bases de desenvolvimento/testes e a criação das tabelas

```bash
  rails db:create
  rails db:migrate
```

Inicie o servidor

```bash
  rails s
```

Com o comando acima, o rails irá executar na porta padrão 3000. Contudo, se desejar alterar a porta de execução, basta rodar o seguinte comando

```bash
  rails s -p porta_de_sua_escolha
```

Lembre-se da porta que escolher para a execução dos comandos necessários posteriormente ;)


## Documentação da API

Os registros abaixo são descritos para o Insomnia, mas funcionam também para o Postman ou qualquer outro software para testes em API:

### 1. Configuração Inicial
#### 1.1 Abra o Insomnia e crie uma nova coleção:

- Clique em Create > New Request Collection.
- Nomeie a coleção como "Catálogo de Filmes API".

#### 1.2 Dentro da coleção, crie três requisições:

- Importar CSV,
- Listar Filmes,
- Listar Filmes com Paginação.

### 2. Importar Catálogo de Filmes
- Método: ```POST```
- Endpoint: ```/api/v1/movies/import_csv```
- Como configurar no Insomnia:
  - 1.Clique em New Request e nomeie como "Importar CSV".
  - 2.Selecione o método POST.
  - 3.Insira a URL completa: ```http://localhost:3000/api/v1/movies/import_csv```
    - Caso tenha escolhido outra porta para iniciar o servidor rails, lembre-se de alterar o ```3000``` para a porta que escolheu
  - 4.Na aba Body, escolha o tipo de corpo como Multipart Form.
  - 5.Adicione um campo com o nome file.
    - Clique em Choose File para selecionar o arquivo CSV de importação.
  - 6.Clique em Send para enviar a requisição.
- Resposta esperada:
  - Uma mensagem de sucesso será exibida na aba de resposta:
```bash
  {
    "message": "Filmes importados com sucesso"
  }
```
- Possíveis Erros:
  - Se o arquivo não for fornecido ou estiver malformado, você verá uma mensagem de erro com status ```422 Unprocessable Entity.```

### 3. Listar Filmes
- Método: ```GET```
- Endpoint: ```/api/v1/movies```
- Como configurar no Insomnia:
  - 1.Clique em New Request e nomeie como "Listar Filmes".
  - 2.Selecione o método GET.
  - 3.Insira a URL completa: ```http://localhost:3000/api/v1/movies```.
    - Caso tenha escolhido outra porta para iniciar o servidor rails, lembre-se de alterar o ```3000``` para a porta que escolheu
  - 4.Para adicionar filtros:
    - 4.1 Clique na aba Query.
    - 4.2 Adicione parâmetros opcionais, como:
      - year: Filtra pelo ano de lançamento (ex.: 2020).
      - genre: Filtra pelo gênero do filme (ex.: "Drama").
      - country: Filtra pelo país de origem (ex.: "United States").
  - 5.Clique em Send para visualizar a listagem dos filmes.
- Resposta esperada:
  - Um array de filmes no formato JSON será exibido na aba de resposta:
```bash
[
  {
    "id": "s1",
    "title": "13 Reasons Why",
    "genre": "TV Show",
    "year": 2020,
    "country": "United States",
    "published_at": "2020-05-07",
    "description": "A classmate receives a series of tapes that unravel the mystery of her tragic choice."
  },
  ...
]
```
- Possíveis Erros:
    - Se houver algum problema inesperado no servidor, você verá uma mensagem de erro com status ```500 Internal Server Error```.

### 4. Listar Filmes com Paginação
- Método: ```GET```
- Endpoint: ```/api/v1/movies```
- Como configurar no Insomnia:
  - 1.Clique em New Request e nomeie como "Listar Filmes com Paginação".
  - 2.Selecione o método GET.
  - 3.Insira a URL completa: ```http://localhost:3000/api/v1/movies```.
    - Caso tenha escolhido outra porta para iniciar o servidor rails, lembre-se de alterar o ```3000``` para a porta que escolheu
  - 4.Na aba Query, adicione os parâmetros:
    - 4.1 page: Define a página atual (ex.: 1).
    - 4.2 Parâmetros opcionais:
      - 4.2.1 year, genre, country: Mesmo filtro opcional descrito anteriormente.
  - 5.Clique em Send para visualizar a listagem paginada.
- Resposta esperada:
  - Um array de filmes paginado no formato JSON será exibido na aba de resposta:
```bash
[
  {
    "id": "s1",
    "title": "17 Again",
    "genre": "Movie",
    "year": 2019,
    "country": "United States",
    "published_at": "2019-03-10",
    "description": "A man magically gets to relive his teenage years."
  },
  ...
]
```
- Possíveis Erros:
Se houver um problema inesperado no servidor, você verá uma mensagem de erro com status ```500 Internal Server Error```


## Rodando os testes

Para a execução dos testes, basta rodar o seguinte comando:

```bash
  bundle exec rspec
```
Foram desenvolvidos um total de 7 testes para esta API, um número significativo dado a finalidade do projeto.

Os testes do models podem ser encontrados no arquivo ```movie_spec.rb```, encontrado no seguinte caminho

```bash
  spec/models/movie_spec.rb
```

Os testes para o controller da API podem ser encontrados no arquivo ```movies_spec.rb```, encontrado no seguinte caminho

```bash
  spec/requests/api/v1/movies_spec.rb
```


## Stack utilizada

Por se tratar de uma API, não foi contruído nada referente a telas então não se tem tecnologias para Front-end. Foram utilizadas apenas tecnologias de Back-end e banco de dados, descritas abaixo:

**Back-end:** 
Ruby versão 3.0.0, Rails versão 7.0.8.5

**Gems em destaque:**
Kaminari para paginação do json, RSpec para testes da API

**Banco de Dados:** 
PostgreSQL versão 16

**Testes em API:** 
Insomnia (Software)


## Aprendizados

Ao realizar a criação desa API, pude ter uma certeza que é com essa tecnologioa que quero seguir a minha vida de programador. Ruby e Rails são tecnologioas ágeis e intuitivas, o que faz com que uma seção de programação seja extremamente divertida e gratificante. Construir esta API também me fez perceber a importância destas no mundo da tecnologia, e o quão grande pode se tornar uma simples ideia. Espero seguir adiante sempre com novos desafios, garantindo uma boa qualidade nos meus projetos e me tornar um desenvolvedor que não apenas ajude outros no futuro, mas que torne um exemplo a ser seguido futuramente.
