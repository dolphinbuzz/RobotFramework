*** Settings ***
Resource    ../resources/api.testing_usuarios.resource


*** Variables ***

*** Test Cases ***
Cenário 01: Cadastrar um novo usuário com sucesso na ServeRest
    ${email}    Criar um usuario novo
    Cadastrar o usuario criado na ServeRest    email=${email}  estatusEsperado=201
    Conferir se o usuario foi cadastrado corretamente

Cenário 02: Cadastrar um usuario ja existente
    ${email}    Criar um usuario novo
    Cadastrar o usuario criado na ServeRest    email=${email}  estatusEsperado=201
    Tentar cadastrar novamente o usuario
    Valida que nao foi possivel cadastrar usuario ja existente

Cenário 03: Consultar os dados de um novo usuario
    ${email}    Criar um usuario novo
    Cadastrar o usuario criado na ServeRest    email=${email}  estatusEsperado=201
    Consultar os dados do usuario
    Conferir os dados retornados

Cenário 04: Logar com o novo usuário criado
    ${email}    Criar um usuario novo
    Cadastrar o usuario criado na ServeRest    email=${email}  estatusEsperado=201
    Realizar Login com o usuário
    Conferir se o Login ocorreu com sucesso
