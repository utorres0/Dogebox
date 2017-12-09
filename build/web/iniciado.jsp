<%-- 
    Document   : iniciado
    Created on : 9/11/2016, 08:40:34 PM
    Author     : oneee
--%>
<%@page import=" javax.servlet.http.HttpSession" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%
        if (request.getSession().getAttribute("email") == (null)) {
            response.sendRedirect("index.jsp");
        }%>
    <head>
        <!-- Configuraciones para compatibilidad de dispositivos-->
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximun-scale=1.0, minimum-scale=1.0">


        <!-- Título de la página -->
        <title>Bienvenid@ a Dogebox</title>

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
        
        <script language="JavaScript">
            function pregunta() {
                if (confirm('¿Estas seguro de eliminar su cuenta? Perderá todos sus archivos activos e inactivos. Ya no los podrá recuperar')) {
                    document.tuformulario.submit()
                } else
                    return false;
            }
        </script>

    </head>


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


            <center> <h1>Bienvenid@ <%=request.getSession().getAttribute("nombre")%></h1> </center>

            <div class="container">
                <div class="row">
                    <div class="col-sm-4">
                        <img src="images/png/upload.png"  width="150" height="150" alt="Subir archivo">      
                        <form action="subirArchivo.jsp" method="post" >
                            <input class= "fsSubmitButton" type="submit" value="Subir Archivo"/><br><br>
                        </form>
                    </div>
                    <div class="col-sm-4">
                        <img src="images/png/contact.png"  width="150" height="150" alt="Contactos">  
                        <form action="MostrarContactos" method="post">
                            <input class = "fsSubmitButton" type="submit" value="Contactos"/><br><br>
                        </form>
                    </div>
                    <div class="col-sm-4">
                        <img src="images/png/estadistica.png"  width="150" height="150" alt="Estadísticas">  
                        <form action="Estadisticas" method="post">
                            <input class = "fsSubmitButton" type="submit" value="Estadisticas"/><br><br>
                        </form>
                    </div>
                </div>
            </div>

            <div class="container">
                <div class="row">
                    <div class="col-sm-4">
                        <img src="images/png/misarchivos.png"  width="150" height="150" alt="Mis archivos">  
                        <form action="VerArchivos" method="post">
                            <input class= "fsSubmitButton" type="submit" value="Mis archivos"/><br><br>
                        </form>
                    </div>
                    <div class="col-sm-4">
                        <img src="img/kawaii.gif"  width="150" height="150" alt="Hola">  
                        <form action="EliminarUsuario" method="post">
                            <input class= "fsSubmitButton" type="submit" value="Eliminar cuenta" onclick="return pregunta()"/><br><br>
                        </form>
                    </div>
                    <div class="col-sm-4">
                        <img src="images/png/out.png"  width="150" height="150" alt="Cerrar sesión">  
                        <form action="logout" method="post">
                            <input class= "fsSubmitButton" type="submit" name="cmdCerrar" value="Cerrar Sesión"> <br><br>
                        </form> 
                    </div>
                </div>
            </div>

        </section>








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