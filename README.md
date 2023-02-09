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
- data: Array de objetos, onde cada objeto é uma registro no histórico relacionado a criação ou mudança de status de uma vulnerabilidade

`/vulnerability_histories`

- Não existe nenhum endpoint aninhado a esse que insira dados, o histórico é populado via callbacks relacionados ao modelo `Vulnerability`

## Autenticação

A autenticação está sendo feito com o [devise_token_auth](https://github.com/lynndylanhurley/devise_token_auth), toda requisição precisa de três informações para validar um usuário:

| Informações para autenticaçnao |
| ------------------------------ |
| access-token                   |
| client                         |
| uid                            |

Quando o usuário faz um POST para `/auth` com os atributos de email e senha para criação da conta ou para `/auth/sign_in` visando o login, o servidor devolve essas três informações se a requisição for um sucesso. Quando uma nova requisição for feita, é necessário passar essas informaçnões no header da requisição. A resposta do servidor trará um novo access-token que deve ser enviado de volta ao servidor e assim por diante.
