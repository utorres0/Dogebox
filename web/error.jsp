<%-- 
    Document   : errorInicio
    Created on : 27/11/2016, 03:26:32 PM
    Author     : oneee
--%>
<%
    String res = (String) request.getAttribute("errorLogin");
    String redirect = (String) request.getAttribute("redireccionar");
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

        <!-- Configuraciones para compatibilidad de dispositivos-->  
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximun-scale=1.0, minimum-scale=1.0">
        <meta http-equiv="refresh" content="5; url=<%=redirect%>" />
        
        <title>Error - Dogebox</title>

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
        <section class="contenido wrapper fondo">
            <br>
            <center><h2>Redirección automática en 5 segundos...</h2></center>
            <br>
            <br>
            <center><img src="img/giphy.gif" width="200" height="200" alt=""></center>
            <center> <h1>¡Ha ocurrido un error!</h1></center>
            <br>
            <br>
            <%
                if (res == "2") {%>

            <center><h1>Necesita activar su cuenta. Verifique su bandeja de correo electrónico, el mensaje podría aparecer en la bandeja de SPAM</h1></center>

            <%} else if (res == "pass") {%>

            <center><h1>La contraseña está incorrecta, por favor verifique</h1></center>

            <%} else if (res == "email") {%>

            <center><h1>El usuario proporcionado no existe, verifique sus datos</h1></center>

            <%} else if (res == "regContra") {%>

            <center><h1>La confirmación de contraseñas no coincide,favor de verificarlas</h1></center>

            <%} else if (res == "regUser") {%>

            <center><h1>El email que ingresó ya se encuentra registrado, favor de verificarlo</h1></center>

            <%}%>
        </section>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>


    </body>
       
</html>
