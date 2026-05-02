*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Click Element por Nombre
    # Presionar 20 veces el boton con el texto (usando xpath) del argumento
    [Arguments]    ${nombre}
    wait until element is visible    xpath=//button[text()='${nombre}']
    FOR    ${i}    IN RANGE    20
        click Element    xpath=//button[text()='${nombre}']
    END

Invertir Checkboxes
    # Seleccionar el primer Checkbox y No Seleccionar el segundo
    [Arguments]    ${checkbox-1}    ${checkbox-2}
    # Uso de css selector para obtener el 'n' input dentro del elemento con el id 'checkboxes'
    select checkbox    css=#checkboxes input:nth-of-type(${checkbox-1})
    select checkbox    css=#checkboxes input:nth-of-type(${checkbox-2})
    checkbox should be selected    css=#checkboxes input:nth-of-type(${checkbox-2})

Buscar Gallery Y Recargar Si Falla
    # Regresar verdadero si la pagina contiene el elemento con el texto 'Gallery' y falso y recargar la pagina si no
    ${existe}=    Run Keyword And Return Status    Page Should Contain Element    xpath=//a[text()='Gallery']
    IF    not ${existe}
        Reload Page
        Fail
    END

Mover Columnas
    # Arrastrar el elemento con el id 'column-a' al elemento con id 'column-b' y verificar el cambio de texto de ambos elementos
    [Arguments]    ${texto-columna-a}    ${texto-columna-b}
    drag and drop    id=column-a    id=column-b
    element text should be    id=column-a    ${texto-columna-a}
    element text should be    id=column-b    ${texto-columna-b}

Iniciar Sesion Formulario
    # Introducir el 'user' y 'password' en los inputs correspondientes y
    # presionar el boton dentro del elemento con id 'login' usando css selector
    [Arguments]    ${user}    ${password}
    input text    id=username    ${user}
    input text    id=password    ${password}
    click element    css:#login > button

Validar Inicio Sesion Valido Formulario
    # Esperar a estar en la pantalla 'Secure Area' y presionar el elemento con href '/logout'.page should contain.
    # También verificar los textos correspondientes a inicio y cierre de sesión
    wait until page contains    Secure Area
    Wait Until Element Contains    id=flash    You logged into a secure area!
    click element    xpath=//a[@href='/logout']
    Wait Until Element Contains    id=flash     You logged out of the secure area!
    page should contain    Login Page

Verificar Presionar Tecla
    # Hacer click en el elemento con id 'target' y presionar la tecla dada en el argumento
    [Arguments]    ${nombre-tecla}
    click element    id=target
    Press Keys    id=target    ${nombre-tecla}
    Wait Until Element Contains    id=result    You entered: ${nombre-tecla}