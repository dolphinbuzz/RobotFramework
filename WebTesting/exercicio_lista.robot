*** Variables ***
@{meses}    janeiro    fevereiro    marco    abril    maio    junho    julho    agosto    setembro    outubro    novembro    dezembro


*** Keywords ***
Imprime mes ${numero}
    Log To Console    ${meses[${numero}]}

*** Test Cases ***
Imprime todos os meses
    Imprime mes 0
    Imprime mes 1
    Imprime mes 2
    Imprime mes 3
    Imprime mes 4
    Imprime mes 5
    Imprime mes 6
    Imprime mes 7
    Imprime mes 8
    Imprime mes 9
    Imprime mes 10
    Imprime mes 11