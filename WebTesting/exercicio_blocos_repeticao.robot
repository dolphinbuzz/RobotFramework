*** Variables ***
@{NUMEROS}    1    23    5432    335    121    112    10    9    58    7    4    1    3    5    105

*** Keywords ***
Imprime numeros
    FOR    ${ELEMENT}    IN    @{NUMEROS}
        IF    ${ELEMENT} in (5, 10)
            Log To Console    Eu sou o número ${ELEMENT}!
        ELSE
            Log To Console   ${ELEMENT} - Eu não sou o numero 5 e nem o 10!
        END
    END

*** Test Cases ***

Imprimindo numeros 5 e 10
    Imprime numeros