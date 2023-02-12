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

Meu ambiente estava sendo testado no Macbook Monterey 12.5, estava tendo alguns problemas com IP's locais e portas, com isso, por vezes, o a conexão entre os containers do postgres e do rails era perdida.

Porém, provavelmente você não terá problemas executando esses passos:

Provavelmente, você tem que definir no arquivo de hosts da sua máquina, que `db` ou `db_test` estão sendo executado na por `0.0.0.0`. Você também pode alterar isso. No arquivo `/etc/hosts` do macbook, fica algo como:

```sh
127.0.0.1 localhost
255.255.255.255 broadcasthost
::1 localhost
0.0.0.0 db
```

Depois, o docker consegue entender as referências ao banco postgres dockerizado.

```sh
docker-compose up
```

Se o compose padrão rodar sem problemas a bateria de testes e subir a aplicação, está tudo ok! Caso ele não rode os testes informando que `defenseless_test` não existe, o container do postgres provavelmente está com problemas e isso é uma incognita.

Entretanto, ao executar `docker-compose run web rake db:create` no seu terminal, ele vai bater na trave, provavelmente, a mensagem que vai aparecer é que o `defenseless_development` já existe. O que queriamos na verdade era desbloquear alguma ponte de conexão que estava atrapalhando nossa conversa entre os containers e esse comando por algum motivo resolve.

```sh
docker-compose run web_test rake db:create
```

Isso deve criar o defenseless_test

```sh
docker-compose run web_test
```

Isso deve rodar os testes agora! Eu prefiro usar o terminal na maior parte do tempo, mas, por vezes, tive que usar o app docker desktop para ligar containers manualmente.

O ideal era separar em dois composers.yml diferentes, mas, esse é o MVP da dockerização dessa API, busquei ser lean no momento!

## Swagger

Você pode acessar a documentação dessa API no endpoint `/api-docs/index.html` usei gems de integração com a interface do Swagger.ui

E em relação as rotas geradas automaticamente pelo `devise_token_auth`, coloquei as três mais usadas, pois, as outras já tem a documentação na própria gem e são pouco utilizadas nessa API. São elas:

- `/auth`
- `/auth/sign_in`
- `/auth/sign_out`

Para fazer os testes no swagger-ui, envie um POST para `/auth`, pegue as informações para autenticação e troque o access-token a cada novo teste nos outros endpoints

<img width="1465" alt="image" src="https://user-images.githubusercontent.com/43969809/218338436-f4c01536-51d9-4025-a6d5-8275b2251a9d.png">

<img width="821" alt="image" src="https://user-images.githubusercontent.com/43969809/218338543-9cd683e0-dac1-4700-a470-23939e422faa.png">


