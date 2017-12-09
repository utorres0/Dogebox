<%-- 
    Document   : verificado
    Created on : 18/11/2016, 07:28:00 PM
    Author     : oneee
--%>
<%
    String res = (String) request.getAttribute("respuesta");
    if (res == null) {
        response.sendRedirect("index.jsp");
    }

%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

        <!-- Configuraciones para compatibilidad de dispositivos-->
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximun-scale=1.0, minimum-scale=1.0">
        <meta http-equiv="refresh" content="5; url=index.jsp" />

        <!-- Título de la página -->
        <title>Dogebox - Verificación </title>

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


            <center><h2>Redirección automática en 5 segundos...</h2></center>

            <br>
            <br>
            <center><img src="img/giphy.gif" width="200" height="200" ></center>
            <center> <h1><%=res%></h1></center>
            <br>
            <br>
            <center><h1>Muchas gracias por completar tu registro en Dogebox, esperamos que el servicio sea de tu agrado</h1></center>




        </section>
        <br>
        <br>
        <br>
        <br>
        <br>
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
