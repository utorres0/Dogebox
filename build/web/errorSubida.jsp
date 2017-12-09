<%-- 
    Document   : index
    Created on : 5/11/2016, 11:55:49 PM
    Author     : oneee
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>    
    <%
        if (request.getSession().getAttribute("email") != (null)) {
            response.sendRedirect("iniciado.jsp");
        }
    %>
    <head>
        <!-- Configuraciones para compatibilidad de dispositivos-->  
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximun-scale=1.0, minimum-scale=1.0">
        <meta http-equiv="refresh" content="5; url=index.jsp" />
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


        <!-- Sección personalizada -->
        <section class="contenido wrapper fondo">
            <br>
            <br>

            <center><h2>Redirección automática en 5 segundos...</h2></center>

            <center><img src="img/giphy.gif" width="200" height="200" ></center>
            <center> <h1>¡Ha ocurrido un error!</h1></center>
            <center><h1>Hemos detectado que su dirección IP ha alcanzado el límite de archivos subidos al día. Intentelo mas tarde.</h1></center>


            <br>

        </section>

        <!-- Formulario de inicio -->
<br><br><br><br><br>

        

    </body>


</html>