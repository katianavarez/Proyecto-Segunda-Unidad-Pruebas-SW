*** Settings ***
Library    SeleniumLibrary
Resource    ../Data/variables.robot
Resource    ../Resources/keywords.robot

*** Test Cases ***
TC_001 Agregar/Quitar Elementos
    # Abir Navegador
    open browser    ${URL_Agregar_Quitar_Elementos}    ${BROWSER}
    # Verificar que el titulo de la pagina se muestre
    page should contain    Add/Remove Elements
    # Hacer click 20 veces al elemento con el nombre del argumento ('Add Element')
    click element por nombre    Add Element
    # Verificar que haya 20 elementos con el texto 'Delete'
    ${cantidad}=    Get Element Count    xpath=//button[text()='Delete']
    Should Be Equal As Integers    ${cantidad}    20
    # Hacer click 20 veces al elemento con el nombre del argumento ('Delete')
    click element por nombre    Delete
    # Verificar que no haya elementos con el texto 'Delete'
    page should not contain element    xpath=//button[text()='Delete']
    # Cerrar Navegador
    close browser

TC_002 Autenticación Básica
    # Abrir Navegador con el 'user' y 'password' en la URL. También abrir en incognito el navegador para no tener datos guardados
    Open Browser    https://${user-basic}:${password-basic}@the-internet.herokuapp.com/basic_auth    ${BROWSER}    options=add_argument("--incognito")
    # Verificar que exista el texto 'Basic Auth' en pantalla
    page should contain    Basic Auth
    # Verificar que exista el texto 'Congratulations! You must have the proper credentials.' en pantalla
    page should contain    Congratulations! You must have the proper credentials.
    # Cerrar Navegador
    close browser

TC_003 Checkboxes
    # Abir Navegador
    open browser    ${URL_Checboxes}    ${BROWSER}
    # Verificar que el titulo de la pagina se muestre
    page should contain    Checkboxes
    # Seleccionar el Checkbox del primer argumento y no seleccionar el del segundo argumento
    invertir checkboxes    1    2
    invertir checkboxes    2    1
    # Cerrar Navegador
    close browser

TC_004 Context Menu
    # Abir Navegador
    open browser    ${URL_Context_Menu}    ${BROWSER}
    # Verificar que el titulo de la pagina se muestre
    page should contain    Context Menu
    wait until element is visible    id=hot-spot
    # Poner el cursor encima del elemento
    mouse Over    id=hot-spot
    # Hacer click derecho en el elemento
    open context menu     id=hot-spot
    # Esperar a la alerta
    alert Should Be Present    text=You selected a context menu
    # Cerrar Navegador
    close browser

TC_005 Elementos que Desaparecen
    # Abir Navegador
    open browser    ${URL_Elementos_Desaparecen}    ${BROWSER}
    page should contain    Disappearing Elements
    Wait Until Keyword Succeeds    5x    2s    Buscar Gallery Y Recargar Si Falla
    close browser

TC_006 Drag and Drop
    # Abir Navegador
    open browser    ${URL_Drag_and_Drop}    ${BROWSER}
    page should contain    Drag and Drop
    mover columnas    B    A
    mover columnas    A    B
    # Cerrar Navegador
    close browser

TC_007 Controles Dinámicos
    # Abir Navegador
    open browser    ${URL_Dynamic_Controls}    ${BROWSER}
    # Verificaoms que cargó bien la página
    page should contain    Dynamic Controls
    # Quitamos el checkbox con el botón Remove
    click element    xpath=//button[text()='Remove']
    # Esperamos que el checkbox desaparezca
    wait until element is not visible    id=checkbox
    # Confirmamos con el mensaje de que ya se eliminó
    page should contain    It's gone!
    # Habilitamos el input con el botón Enable
    click element    xpath=//button[text()='Enable']
    # Esperamos hasta que aparezca el botón Disable, lo cual es señal de que terminó
    wait until element is visible    xpath=//button[text()='Disable']
    # Aquí el input ya debería estar activo
    element should be enabled    css=#input-example > input
    page should contain    It's enabled!
    # Cerrar Navegador
    close browser

TC_008 Menú Flotante
    # Abir Navegador
    open browser    ${URL_Menu_Flotante}    ${BROWSER}
    # Nos vamos al final de la página para activar el menú flotante
    page should contain    Floating Menu
    Press Keys    None    END
    # Recorremos los links del menú y verificamos que existan
    FOR    ${texto}    IN    @{MENU_LINKS}
        Page Should Contain Element    xpath=//a[text()='${texto}']
    END
    # Cerrar Navegador
    close browser

TC_009 Autenticación con Formulario
    # Abrimos en incógnito para evitar datos guardados de sesiones anteriores
    open browser    ${URL_Autenticacion_Formulario}    ${BROWSER}    options=add_argument("--incognito")
    page should contain    Login Page
    # Primero intentamos con credenciales válidas
    Iniciar Sesion Formulario    ${user-formulario-valido}    ${pass-formulario-valido}
    Validar Inicio Sesion Valido Formulario
    # Después intentamos con usuario incorrecto y contraseña válida
    Iniciar Sesion Formulario    ${user-formulario-invalido}    ${pass-formulario-valido}
    # Esperamos el mensaje de error
    Wait Until Element Contains    id=flash    Your username is invalid!
    Iniciar Sesion Formulario    ${user-formulario-valido}    ${pass-formulario-invalido}
    # Por último intentamos con usuario válido pero contraseña incorrecta
    Wait Until Element Contains    id=flash    Your password is invalid!
    close browser

TC_010 Teclas Presionadas
    # Abir Navegador
    open browser    ${URL_Teclas_Presionadas}    ${BROWSER}
    page should contain    Key Presses
    # Probamos con la tecla Escape primero
    Verificar Presionar Tecla    ESCAPE
    # Luego con espacio
    Verificar Presionar Tecla    SPACE
    # Cerrar Navegador
    close browser


