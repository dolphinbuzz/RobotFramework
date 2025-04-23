*** Variables ***
&{MESES_DIAS}       janeiro=31    fevereiro=28    marco=31    abril=30    maio=31    junho=30  julho=31    agosto=31    setembro=30    
...                 outubro=31    novembro=30    dezembro=31    

*** Keywords ***
Imprime mes e quantidade de dias ${indice}
    Log To Console    O mes de ${indice} tem ${MESES_DIAS.${indice}} dias!!

*** Test Cases ***
Imprime dias e meses
    Imprime mes e quantidade de dias janeiro
    Imprime mes e quantidade de dias fevereiro
    Imprime mes e quantidade de dias marco
    Imprime mes e quantidade de dias abril
    Imprime mes e quantidade de dias maio
    Imprime mes e quantidade de dias junho
    Imprime mes e quantidade de dias julho
    Imprime mes e quantidade de dias agosto
    Imprime mes e quantidade de dias setembro
    Imprime mes e quantidade de dias outubro
    Imprime mes e quantidade de dias novembro
    Imprime mes e quantidade de dias dezembro