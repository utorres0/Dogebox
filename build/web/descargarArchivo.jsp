<%-- 
    Document   : descargarArchivo
    Created on : 8/11/2016, 11:13:09 PM
    Author     : oneee
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximun-scale=1.0, minimum-scale=1.0">

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

        <title>Descargar archivo</title>
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

        <%

            String error = (String) request.getAttribute("error");
            String hash = (String) request.getAttribute("hash");
            if (error != null) {
        %>
    <center> <h1><%=error%></h1>
        <h3> <form action="Descarga" method="post">
                <input type="password" name="txtPass"><br>
                <input type="submit" class="fsSubmitButton" name="cmdDescargar" ><br>
                <input type="hidden" name="archivo" value="<%=hash%>">
            </form>
            <form  method="post" action="index.jsp">
                <input type="submit" class="fsSubmitButton" value="Menú principal">
            </form> </h3> </center>

    <%
        } else {
            response.sendRedirect("index.jsp");
        }%>

    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <div class="footer"> Para preguntas,comentarios,asistencia u otros motivos pertinentes contacte a dogebox.adm@gmail.com
        <br> 
        Copyright © 2016 Dogebox™, Todos los derechos reservados. 
    </div>

</body>

</html>
