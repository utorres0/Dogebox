<%-- 
    Document   : subirArchiv
    Created on : 6/11/2016, 10:01:23 PM
    Author     : oneee
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%
        String liga = (String) request.getAttribute("liga");
        String nombre = (String) request.getAttribute("nombre");
        String email = (String) request.getSession().getAttribute("email");
        String anonimo = (String) request.getSession().getAttribute("usuarioAnonimo");

        if (email == null && anonimo == null && liga == null) {
            response.sendRedirect("index.jsp");
        } else{
    %>
    <head>
        <!-- Configuraciones para compatibilidad de dispositivos-->
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximun-scale=1.0, minimum-scale=1.0">


        <!-- Título de la página -->
        <title>Subir archivo - Dogebox</title>

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
                    <nav>

                        <a href="Publicidad">Subir archivo</a>
                        <a href="VerArchivos">Mis archivos</a>
                        <a href="Estadisticas">Estadísticas</a>

                    </nav>


                </div>
        </header>
    <center><h1>Subir Archivo</h1></center>

        <%            if (email != null) {
        %>
    <center>

        <form action="SubirArchivo" method="post" enctype="multipart/form-data" >
            <h1>Puede agregar una contraseña. Esto para que pueda controlar quien descarga su archivo </h1><br><br>
            <h1b>Contraseña (Máximo 30 caracteres):</h1b> <input type="password" name="txtPass" maxlength="30"><br><br>
            <h1b>Verifique contraseña: </h1b> <input type="password" name="txtValidar" maxlength="30"><br><br>

            <h1b> <input type="file" name="upload" required dropzone ><br><br>
                <input type="submit" name="cmdEnviar" value="Subir Archivo" class="fsSubmitButton"><br><br>
                </form>  </h1b>


            <form action="iniciado.jsp" method="post" >
                <input type="submit" class="fsSubmitButton" value="Ir a menú principal"><br>
            </form>
    </center>
    <%
    } else {

    %>
    <center><h1b><form action="SubirArchivo" method="post" enctype="multipart/form-data">
                <input type="file" name="upload" required dropzone><br><br>
                <input type="submit" class="fsSubmitButton" name="cmdEnviar" value="Subir Archivo"><br><br>

            </form></h1b>

        <form method="post">            
            <a href="http://<%=liga%>">
                <img src="images/<%=nombre%>" width="200" height="200" >
            </a>
        </form>
        <form action="logout" method="post" >
            <br>
            <input type="submit" class="fsSubmitButton" value="Cancelar e ir al inicio"><br>
        </form> </center>
        <%}%>
<br><br><br><br><br><br><br><br><br><br><br><br>
   
</body>
 <div class="footer"> Para preguntas,comentarios,asistencia u otros motivos pertinentes contacte a <a href="mailto:dogebox.adm@gmail.com">dogebox.adm@gmail.com</a>
        <br> 
        Copyright © 2016 Dogebox™, Todos los derechos reservados. 
    </div>
</html>
<%}
%>