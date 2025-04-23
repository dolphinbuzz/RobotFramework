*** Settings ***
Library    RequestsLibrary
Library    String
Library    Collections
Library    FakerLibrary

*** Variables ***
${urlBase}          https://serverest.dev
${urlUsuarios}      /usuarios
${urlLogin}         /login

${nome}  Fulano da Silva
${senha}    1234
${adm}    true

*** Keywords ***
Criar um usuario novo
    ${email}        FakerLibrary.email
    ${numero}       FakerLibrary.Random Number      digits=3
    ${palavra2}     Generate Random String          length=6    chars=[LETTERS]
    ${palavra2}     Convert To Lower Case           ${PALAVRA2} 
    ${email}        Convert To Lower Case           ${email}

    Set Test Variable    ${email}    ${palavra2}${numero}${email}
    Log    ${email}
    RETURN    ${email}


Cadastrar o usuario criado na ServeRest
    [Arguments]    ${email}    ${estatusEsperado}
    ${body}    Create Dictionary    
    ...    nome=${nome}
    ...    email=${email}
    ...    password=${senha}
    ...    administrador=${adm}

    Log    ${body}
    Criar sessao na ServeRest
    ${resposta}    POST On Session    
    ...    alias=ServeRest
    ...    url=${urlUsuarios}
    ...    json=${body}
    ...    expected_status=${estatusEsperado}

    Log    ${resposta.json()}

    IF    ${resposta.status_code} == 201
       Set Test Variable    ${idUsuario}   ${resposta.json()["_id"]}
    END
    
    Set Test Variable    ${resposta}    ${resposta.json()}


Criar sessao na ServeRest
    ${headers}    Create Dictionary    accept=application/json    Content-Type=application/json
    Create Session    alias=ServeRest    url=${urlBase}    headers=${headers}

Conferir se o usuario foi cadastrado corretamente
    Log    ${resposta}
    Dictionary Should Contain Item    ${resposta}    message    Cadastro realizado com sucesso
    Dictionary Should Contain Key    ${resposta}    _id

Tentar cadastrar novamente o usuario
    Cadastrar o usuario criado na ServeRest    ${email}    estatusEsperado=400

Valida que nao foi possivel cadastrar usuario ja existente
    Log     ${resposta}

    Dictionary Should Contain Item      ${resposta}    message    Este email já está sendo usado
    Dictionary Should Not Contain Key   ${resposta}    _id

Consultar os dados do usuario
    ${resposta_consulta}    GET On Session    
    ...    alias=ServeRest    
    ...    url=${urlUsuarios}/${idUsuario}
    ...    expected_status=200
    Log    ${resposta_consulta.status_code}
    Log    ${resposta_consulta.reason}
    Log    ${resposta_consulta.headers}
    Log    ${resposta_consulta.elapsed}
    Log    ${resposta_consulta.text}
    Log    ${resposta_consulta.json()}

    Set Test Variable    ${resposta_consulta}    ${resposta_consulta.json()}

Conferir os dados retornados
    Dictionary Should Contain Item    ${resposta_consulta}    nome    ${nome}
    Dictionary Should Contain Item    ${resposta_consulta}    email    ${email}
    Dictionary Should Contain Item    ${resposta_consulta}    password    ${senha}
    Dictionary Should Contain Item    ${resposta_consulta}    administrador    ${adm}
    Dictionary Should Contain Item    ${resposta_consulta}    _id    ${idUsuario}

Realizar Login com o usuário
    ${body}    Create Dictionary
    ...    email=${email}
    ...    password=${senha}

    ${responseLogin}    POST On Session
    ...    alias=ServeRest
    ...    json=${body}
    ...    url=${urlLogin}
    ...    expected_status=200
    Set Test Variable    ${responseLogin}    ${responseLogin.json()}
    Set Test Variable    ${token}    ${responseLogin["authorization"]}
    Log    ${responseLogin["message"]}

Conferir se o Login ocorreu com sucesso
    Dictionary Should Contain key    ${responseLogin}    authorization    ${token}
    Dictionary Should Contain Item    ${responseLogin}    message    Login realizado com sucesso