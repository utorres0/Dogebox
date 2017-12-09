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
        <title>Dogebox</title>

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

        <!-- Formulario de inicio -->
    <center> 

        <h2>
            <form action="InciarSesion" method="post" class="fondologin">
                <br>
                <label>Correo:</label>
                <h3> 
                    <input type="email" name="txtUsuario" maxlength="50" required> </h3>
                <label>Contraseña: </label>
                <h3> <input type="password" name="txtContrasena" maxlength="30" required><br><br> </h3>

                <input class="fsSubmitButton" type="submit" name="cmdIniciar" value="Iniciar Sesión "><br> 

            </form> 
        </h2>

        <center><h1><p> ¿No estás registrado?</p> </h1>  </center>

        <form action="registro.jsp">
            <input class="fsSubmitButton" type="submit" value="Registrarme" />
        </form>  

        <br>

        <form action="InicioAnonimo">
            <input class="fsSubmitButton" type="submit" value="Utilizar como anónimo" />
        </form>  
        <br>
        <br>
        <br>

    </center>  
    <!-- Librería jQuery requerida por los plugins de JavaScript -->
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