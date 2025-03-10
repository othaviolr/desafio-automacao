*** Settings ***
Resource          ../resources/keywords.robot
Library           SeleniumLibrary

*** Test Cases ***
Cadastro bem-sucedido com todos os campos preenchidos
    Dado que o usuário acessa a página de cadastro
    E preenche o formulário de cadastro corretamente
    Quando submete o formulário
    Então o sistema deve exibir a mensagem de sucesso

*** Keywords ***
Dado que o usuário acessa a página de cadastro
    Abrir o navegador e acessar o sistema

E preenche o formulário de cadastro corretamente
    Preencher o formulário de cadastro
    Clicar no botão de Impressão Digital
    Aguardar e rolar para próximo campo
    Selecionar idioma Francês
    Selecionar nível de privacidade Alto

Quando submete o formulário
    Submeter o formulário

Então o sistema deve exibir a mensagem de sucesso
    Validar o cadastro realizado com sucesso

Clicar no botão de Impressão Digital
    Wait Until Element Is Visible    xpath=//button[@id='impressao-digital']    timeout=5s
    Click Element    xpath=//button[@id='impressao-digital']
    Sleep    1s  # Pequena espera para evitar que a automação fique presa

Aguardar e rolar para próximo campo
    Execute Javascript    window.scrollBy(0, 300)
    Sleep    1s  # Tempo para garantir que o próximo campo esteja visível

Selecionar idioma Francês
    Select From List By Value    xpath=//*[@id='idioma']    fr

Selecionar nível de privacidade Alto
    Select From List By Value    xpath=//*[@id='privacidade']    alto
