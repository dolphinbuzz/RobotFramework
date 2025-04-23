*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BROWSER}              chrome
${URL}                  https://www.amazon.com.br
${MENU_ELETRONICOS}     //a[text()='Eletrônicos']
${BUSCA}                //input[@id='twotabsearchtextbox']
${SUBMIT}               //input[@type='submit']
${ADD_CARRINHO}         //input[@id='add-to-cart-button']
${TITULO_ADICIONADO}    //h1[contains(text(),'Adicionado ao carrinho')]
${CARRINHO}             //a[@id='nav-cart']
${RECUSA_GARANTIA}      //span[contains(text(),'Não, obrigado(a)')]//parent::span//input[@type='submit']
${EXCLUIR}              //span//input[@value='Excluir']
${MENSAGEM_EXCLUIDO}    //span[(text()=' foi removido de Carrinho de compras. ')]
${CARRINHO_VAZIO}       //span[contains(text(),'0 produtos')]
${CARRINHO_GARANTIA}    //span[contains(text(),'Carrinho')]//parent::span//input[@type='submit']

*** Keywords ***
Abrir o navegador
    Open Browser    browser=${BROWSER}
    Maximize Browser Window

Fechar o navegador
    Capture Page Screenshot
    Close Browser
Acessar a home page do site Amazon.com.br
    Go To    url=${URL}
    Sleep    10s
    
Entrar no menu "Eletrônicos"
    Capture Element Screenshot    ${MENU_ELETRONICOS}
    Click Element    ${MENU_ELETRONICOS}
    
Verificar se o título da página fica "${TEXTO}"
    Title Should Be     title=${TEXTO}

Verificar se aparece a frase "${FRASE}"
    Wait Until Page Contains    text=${FRASE}
    
Verificar se aparece a categoria "${CATEGORIA}"
    Element Should Be Visible   //ul//li//span//a//span[text()='${CATEGORIA}']

Digitar o nome de produto "${PRODUTO}" no campo de pesquisa
    Input Text    ${BUSCA}    ${PRODUTO}
    
Clicar no botão de pesquisa
    Click Element    ${SUBMIT}

Verificar o resultado da pesquisa se está listando o produto ${PRODUTO}
    Wait Until Element Is Visible    //h2//span[text()='${PRODUTO}']

    
Adicionar o produto "${PRODUTO}" no carrinho
    Click Element    //h2//span[text()='${PRODUTO}']
    ${present}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${ADD_CARRINHO}
    Run Keyword If    ${present}    Click Element    ${ADD_CARRINHO}
    Sleep    4s
    ${garantia}=    Run Keyword And Return Status    Element Should Be Visible    ${RECUSA_GARANTIA}
    Run Keyword If    ${garantia}   Recusa garantia
    Set Suite Variable    ${garantia}
    Sleep    2s

Recusa garantia
    Click Element    ${RECUSA_GARANTIA}
    Wait Until Element Is Visible    ${CARRINHO_GARANTIA}
    Click Element    ${CARRINHO_GARANTIA}
Valida add produto e acessa carrinho
    Wait Until Element Is Visible    ${TITULO_ADICIONADO}
    Click Element    ${CARRINHO}

Verificar se o produto "${PRODUTO}" foi adicionado com sucesso
    Run Keyword If    ${garantia}!=True    Valida add produto e acessa carrinho    
    Wait Until Page Contains Element    //span[contains(text(),'${PRODUTO}')]
   
Remover o produto "${PRODUTO}" do carrinho
    Click Element    ${EXCLUIR}
    ${locator}    Catenate  SEPARATOR=    ${MENSAGEM_EXCLUIDO}  //a[contains(text(), '${PRODUTO}')]
    Page Should Contain Element    ${locator}
    
Verificar se o carrinho fica vazio
    Sleep    1s
    Page Should Contain Element    ${CARRINHO_VAZIO}


Dado que estou na home page da Amazon.com.br
    Acessar a home page do site Amazon.com.br

 Quando adicionar o produto "${PRODUTO}" no carrinho
    Digitar o nome de produto "${PRODUTO}" no campo de pesquisa
    Clicar no botão de pesquisa
    Verificar o resultado da pesquisa se está listando o produto "${PRODUTO}"
    Adicionar o produto "${PRODUTO}" no carrinho

Então o produto "${PRODUTO}" deve ser mostrado no carrinho
    Verificar se o produto "${PRODUTO}" foi adicionado com sucesso

E existe o produto "${PRODUTO}" no carrinho
    Quando adicionar o produto "${PRODUTO}" no carrinho

Quando remover o produto "${PRODUTO}" do carrinho
    Remover o produto "${PRODUTO}" do carrinho
Então o carrinho deve ficar vazio
    Verificar se o carrinho fica vazio