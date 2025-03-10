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
${MENSAGEM_SUCESSO}        xpath=//div[contains(text(),'Cadastro realizado com sucesso')]
${IDIOMA}                  xpath=//*[@id="idioma"]
${PRIVACIDADE}             xpath=//*[@id="privacidade"]

*** Keywords ***
Abrir o navegador e acessar o sistema
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Preencher o formulário de cadastro
    Input Text    ${NOME_COMPLETO}    Othávio Lara
    Input Text    ${DATA_NASCIMENTO}    05-02-2003
    # Clicar na impressão digital
    Wait Until Element Is Visible    ${IMPRESSAO_DIGITAL}    timeout=10s
    Click Element    ${IMPRESSAO_DIGITAL}
    Sleep    2s  # Aguarda a interação
    # Preencher as preferências de navegação
    Wait Until Element Is Visible    ${PREFERENCIAS_NAVEGACAO}    timeout=15s
    Wait Until Element Is Enabled    ${PREFERENCIAS_NAVEGACAO}    timeout=10s
    Click Element    ${PREFERENCIAS_NAVEGACAO}
    Sleep    1s  # Aguarda a interação
    # Caso as preferências de navegação sejam um campo de texto ou de seleção, vamos tentar preenchê-lo
    # Se for um campo de texto, simula digitação
    Input Text    ${PREFERENCIAS_NAVEGACAO}    Bring Me The Horizon
    Sleep    1s  # Aguarda a digitação
    # Escolher a foto de perfil
    Choose File    ${FOTO_PERFIL}    ${EXECDIR}/test/resources/foto_teste.jpg
    # Selecionar o idioma Francês
    Select From List By Value    ${IDIOMA}    fr
    Sleep    1s
    # Selecionar o nível de privacidade Alto
    Select From List By Value    ${PRIVACIDADE}    alto
    Sleep    1s
    # Marcar o consentimento para coleta de dados
    Wait Until Element Is Visible    ${CONSENTIMENTO}    timeout=10s
    Click Element    ${CONSENTIMENTO}
    Sleep    2s
    # Finalizar o cadastro
    Click Element    ${BOTAO_FINALIZAR}

Submeter o formulário
    Click Button    ${BOTAO_FINALIZAR}

Validar o cadastro realizado com sucesso
    Wait Until Element Is Visible    ${MENSAGEM_SUCESSO}    timeout=10s
