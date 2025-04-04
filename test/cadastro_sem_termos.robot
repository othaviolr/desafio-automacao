*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}                     https://desafio-equipe.vercel.app/
${BROWSER}                 Chrome
${NOME_COMPLETO}           id=nome
${DATA_NASCIMENTO}         xpath=//*[@id="dataNascimento"]
${IMPRESSAO_DIGITAL}       xpath=//*[@id="impressao-digital"]
${PREFERENCIAS_NAVEGACAO}  xpath=//*[@id="preferenciasNavegacao"]
${FOTO_PERFIL}             xpath=//*[@id="fotoPerfil"]
${CONSENTIMENTO}           xpath=//*[@id="consentimento"]
${BOTAO_FINALIZAR}         xpath=/html/body/div[1]/form/div[9]/button[1]
${MENSAGEM_ERRO}           xpath=//div[contains(text(),'Erro')]

*** Test Cases ***
Cadastro sem aceitação dos termos
    Dado que o usuário acessa a página de cadastro
    E preenche o formulário de cadastro corretamente sem aceitar os termos
    Quando submete o formulário
    Então o sistema deve exibir a mensagem de erro

*** Keywords ***
Dado que o usuário acessa a página de cadastro
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

E preenche o formulário de cadastro corretamente sem aceitar os termos
    Input Text    ${NOME_COMPLETO}    Othávio Lara
    Input Text    ${DATA_NASCIMENTO}    05-02-2003
    Wait Until Element Is Visible    ${IMPRESSAO_DIGITAL}    timeout=10s
    Click Element    ${IMPRESSAO_DIGITAL}
    Sleep    2s
    Wait Until Element Is Visible    ${PREFERENCIAS_NAVEGACAO}    timeout=15s
    Wait Until Element Is Enabled    ${PREFERENCIAS_NAVEGACAO}    timeout=10s
    Click Element    ${PREFERENCIAS_NAVEGACAO}
    Sleep    1s
    Input Text    ${PREFERENCIAS_NAVEGACAO}    Bring Me The Horizon
    Sleep    1s
    Choose File    ${FOTO_PERFIL}    ${EXECDIR}/test/resources/foto_teste.jpg
    # SEM MARCAR O TERMO
    Sleep    1s

Quando submete o formulário
    Click Element    ${BOTAO_FINALIZAR}

Então o sistema deve exibir a mensagem de erro
    Wait Until Element Is Visible    ${MENSAGEM_ERRO}    timeout=10s
    Element Should Contain    ${MENSAGEM_ERRO}    "Marque esta caixa se deseja continuar."
