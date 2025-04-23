# Projeto de Testes Automatizados com Robot Framework

Este é um projeto básico de automação de testes utilizando Robot Framework. Ele contém exemplos de testes para APIs, Web e uso de blocos de repetição.

## Estrutura do Projeto

- `APITesting/tests/`: Testes automatizados para a API [ServeRest](https://serverest.dev)
- `APITesting/resources/`: Arquivos de recursos compartilhados (variáveis, keywords, etc.)
- `WebTesting/`: Testes automatizados no site da Amazon

- `Results/`: Resultados gerados após execução dos testes

---

## Testes de API

Os testes cobrem os seguintes endpoints da API Serverest:

- `POST /login`: Validação de login com dados válidos e inválidos
- `POST /usuarios`: Validação da criação de novos usuários
- `GET /usuarios`: Validação da listagem de usuários

## Testes Web

Os testes web utilizam o site da Amazon e realizam as seguintes ações:

- Pesquisa de produtos
- Adição de itens ao carrinho
- Remoção de itens do carrinho

---

## Bibliotecas Utilizadas

- `String`
- `Collections`
- `FakerLibrary`
- `RequestsLibrary`
- `SeleniumLibrary`

---

## Pré-requisitos

- Python 3.13.2
- Robot Framework 7.2.2
- Instalar as bibliotecas com:
```bash
pip install -r requirements.txt
```
---

# Executando os testes

## Testes Web
```bash
robot -d .\Results .\WebTesting\amazon_testes.robot
```
## Testes de API
```bash
robot -d .\Results .\WebTesting\amazon_testes.robot
```
## Observações
- Os testes web usam o navegador Chrome por padrão.

- Os testes estão organizados de forma simples para facilitar o entendimento de quem está começando com Robot Framework.