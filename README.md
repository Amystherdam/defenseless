# Defenseless

## _API de cadastro, consulta e exclusão de vulnerabilidades de software_

![Ruby](https://img.shields.io/badge/ruby-%23CC342D.svg?style=for-the-badge&logo=ruby&logoColor=white)![Rails](https://img.shields.io/badge/rails-%23CC0000.svg?style=for-the-badge&logo=ruby-on-rails&logoColor=white)

| Tabelas                 |
| ----------------------- |
| users                   |
| vulnerabilities         |
| vulnerability_histories |

Mais informaçnões sobre as tabelas em `db/schema.rb`

## Modificações

Devido a silepse (concordância com a ideia que se pretende transmitir), achei melhor fazer um de/para em alguns termos do DB:

| De                         | Para           |
| -------------------------- | -------------- |
| Nível de impacto           | Impacto        |
| Solução da vulnerabilidade | Solução        |
| Status quo                 | Status vigente |

Todos os termos estão em inglês no código

| Funcionalidades até agora                                                                  |
| ------------------------------------------------------------------------------------------ |
| Autenticação com [devise_token_auth](https://github.com/lynndylanhurley/devise_token_auth) |
| Cobertura de testes com [Rspec](https://relishapp.com/rspec/rspec-rails/docs)              |
| Quando uma vulnerabilidade é criada, o histórico recebe o primeiro registro                |
| Quando o status de uma vulnerabilidade é atualizado, o histórico recebe um novo registro   |

## Endpoints

`vulnerability_histories/vulnerability/:id`

```sh
Retorna {creator, creation_date, data }
```

- creator: Usuário que criou a vulnerabilidade
- creation_date: Data de criação da vulnerabilidade
- data: Array de objetos, onde cada objeto é uma registro no histórico relacionado a criaçnao ou mudança de status de um registro

`/vulnerability_histories`

- Não existe nenhum endpoint aninhado a esse que insira dados, o histórico é populado via callbacks relacionados ao modelo `Vulnerability`

## Autenticação

A autenticação está sendo feito com o [devise_token_auth](https://github.com/lynndylanhurley/devise_token_auth), toda requisição precisa de três informações para validar um usuário:

| Informações para autenticação |
| ----------------------------- |
| access-token                  |
| client                        |
| uid                           |

Quando o usuário faz um POST para `/auth` com os atributos de email e senha para criação da conta ou para `/auth/sign_in` visando o login, o servidor devolve essas três informações se a requisição for um sucesso. Quando uma nova requisição for feita, é necessário passar essas informaçnões no header da requisição. A resposta do servidor trará um novo access-token que deve ser enviado de volta ao servidor e assim por diante.

## Utiliza Docker?

Existem dois arquivos de comfiguração Docker Compose, um para rodar a aplicação e outro para executar os testes Rspec, são respectivamente `docker-compose.yml` e `docker-compose-test.yml`

Agora, a sessão networks do Docker Compose está sendo usada, excluindo a necessidade de configurar algum possível aquivo de nomes de hosts locais como `etc/hosts`.

Para executar os testes Rspec, execute no terminal:

```sh
docker-compose -f docker-compose-test.yml up
```

Para executar a aplicação, execute no terminal:

```sh
docker-compose up
```

Para persistir no banco as migrações pendentes e executar o `seed.rb` você pode executar no terminal:

```sh
docker exec -it defenseless-web-1 bash
```

Quando o terminal do container abrir, execute os comando pertinentes do rails. Se preferir, você também pode abrir a aba terminal do app Docker Desktop se estiver instalado em sua máquina. Lembre-se de verificar se a imagem Docker Compose tem realmente o nome `defenseless-web-1`

Para debugar em linha, com o `byebug` por exemplo, terá que subir os containers em segundo plano e se conectar ao terminal com `attach`:

```sh
docker-compose up -d
docker ps
docker attach :container_id
```

Pegue o ID do container web com o `docker ps` e informe ao `attach`. Utilize `docker-compose stop` para interromper os containers em execução.

## Swagger

Você pode acessar a documentação dessa API no endpoint `/api-docs/index.html` usei gems de integração com a interface do Swagger.ui

E em relação as rotas geradas automaticamente pelo `devise_token_auth`, coloquei as três mais usadas, pois, as outras já tem a documentação na própria gem e são pouco utilizadas nessa API. São elas:

- `/auth`
- `/auth/sign_in`
- `/auth/sign_out`

Para fazer os testes no swagger-ui, envie um POST para `/auth`, pegue as informações para autenticação e troque o access-token a cada novo teste nos outros endpoints

<img width="1465" alt="image" src="https://user-images.githubusercontent.com/43969809/218338436-f4c01536-51d9-4025-a6d5-8275b2251a9d.png">

<img width="821" alt="image" src="https://user-images.githubusercontent.com/43969809/218338543-9cd683e0-dac1-4700-a470-23939e422faa.png">
