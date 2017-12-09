<%-- 
    Document   : registro
    Created on : 6/11/2016, 12:59:30 AM
    Author     : oneee
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

        <!-- Configuraciones para compatibilidad de dispositivos-->
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximun-scale=1.0, minimum-scale=1.0">

        <!-- Título de la página -->
        <title>Dogebox - Registro</title>

        <!-- CSS de Bootstrap y mi estilo personalizado, fuentes -->
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="stylesheet.css" type="text/css"/>
        <link rel="stylesheet" href="css/estilos.css">
        <link href="https://fonts.googleapis.com/css?family=Rubik" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Muli" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Josefin+Sans" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet">

        <!-- Javascripts -->
        <script src="jquery-latest.js"></script>


    </head>

    <!-- Fondo del body -->
    <body  background="img/footer_lodyas.png">

        <!-- Nuestro header, con su icono y menú -->
        <header class="header">
            <div class="wrapper">
                <div class="logo">
                    <a href="index.jsp"> <img src="img/dogecoin.png" alt="Logotipo" width="95" height="95"> </div> </a>

                    <a href="index.jsp"> <div class="logo">Dogebox </div> </a>

                </div>
        </header>


        <!-- Sección personalizada -->
        <section class="contenido wrapper fondo">

            <br>
            <br>
            <br>
            <br>
            <br>
            <br>

            <center> <div class="roundtest">

                </div> 
            </center>


        </section>
    <center>
        <h1>Sus datos, por favor</h1>
        <form action="Registro" method="post" class="fondoregistro">
            <br>
            <h2><label>Nombre:</label></h2>
            <input type="text" name="txtNombre" required maxlength="50"><br>
            <h2><label>Email</label></h2>
            <input type="email" name="txtEmail" required maxlength="50"><br>
            <h2><label>Contraseña: </label></h2>
            <h1b><label>(Un máximo de 30 caracteres)</label></h1b>
            <input type="password" name="txtContrasena" maxlength="30" required>
            <h2><label>Verifique Contraseña </label></h2>
            <input type="password" name="txtVerificar" maxlength="30" required><br>
            <h1b> Al registrar, acepto los términos y condiciones.</h1b><br> 




            <input class="fsSubmitButton" type="submit" name="cmdRegistro" value="Registrar">   
            <a href="index.jsp" class="fsSubmitButton">Cancelar</a>
        </form> 
        
    </center>

    <br>
    <br>
    <br>
    <br>
    <div class="footer"> Para preguntas,comentarios,asistencia u otros motivos pertinentes contacte a <a href="mailto:dogebox.adm@gmail.com">dogebox.adm@gmail.com</a>
        <br> 
        Copyright © 2016 Dogebox™, Todos los derechos reservados. 
    </div>

</body>

</html>
