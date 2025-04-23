*** Settings ***
Library    FakerLibrary

*** Keywords ***
Criar email
    [Arguments]    ${nome}    ${sobrenome}
    ${string}=    FakerLibrary.Word
    ${email}    Set Variable     ${nome}${sobrenome}${string}@testerobot.com
    [Return]    ${email}


Gera email Faker
    ${nome}         FakerLibrary.first_name
    ${sobrenome}    FakerLibrary.last_name
    ${emailGerado}    Criar email     ${nome}    ${sobrenome}
    Log To Console    ${emailGerado}

*** Test Cases ***
Gera email
    Gera email Faker
    Gera email Faker
    Gera email Faker
    Gera email Faker