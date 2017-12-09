<%-- 
    Document   : cambiarPass
    Created on : 5/11/2016, 11:55:49 PM
    Author     : oneee
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>    
    <%
        String email = (String) request.getSession().getAttribute("email");
        String idArchivo = request.getParameter("idArchivo");
        if (email == null || idArchivo == null) {
            response.sendRedirect("iniciado.jsp");
        } else {
    %>
    <head>
        <script language="JavaScript">
            function pregunta() {
                if (confirm('¿Estas seguro de editar el contacto?')) {
                    document.tuformulario.submit()
                } else
                    return false;
            }
        </script>
        <!-- Configuraciones para compatibilidad de dispositivos-->  
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximun-scale=1.0, minimum-scale=1.0">
        <title>Editar archivo</title>

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

                        <a href="subirArchivo.jsp">Subir archivo</a>
                        <a href="VerArchivos">Mis archivos</a>
                        <a href="Estadisticas">Estadísticas</a>

                    </nav>
                </div>
        </header>


        <!-- Sección personalizada -->
        <section class="contenido wrapper fondo">
            <br>
            <br>



            <center><h1><p> Tus archivos contigo, en todo dispositivo y lugar</p> </h1>  </center>

            <center> <img alt="Wow!"
                          src="img/office-dog.jpg"
                          style="background: url(img/office-dog.jpg.jpg) 90% / cover;
                          border-radius: 50%;
                          padding-left:none;
                          width:400px;">

            </center>

            <br>


        </section>
        <form method="post" action="EditarPass">
            <input type="hidden" value="<%=idArchivo%>" name="archivo">

            <h1b>Nueva Contraseña (Máximo 30 caracteres):</h1b> <input type="text" name="txtPass" maxlength="30"><br>
            <br>
            <input type="submit" class="fsSubmitButton" value="Editar contraseña" onclick="return pregunta()">
        </form>

        <script src="http://code.jquery.com/jquery.js"></script>

        <!-- Todos los plugins JavaScript de Bootstrap (también puedes
             incluir archivos JavaScript individuales de los únicos
             plugins que utilices) -->
        <script src="js/jquery.js"></script>
        <script src="js/bootstrap.min.js"></script>

        <br>
        <br>
        <br>


        <div class="footer"> Para preguntas,comentarios,asistencia u otros motivos pertinentes contacte a <a href="mailto:dogebox.adm@gmail.com">dogebox.adm@gmail.com</a>
            <br> 
            Copyright © 2016 Dogebox™, Todos los derechos reservados. 
        </div>

    </body>

</html>
<%}%>