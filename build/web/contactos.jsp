<%-- 
    Document   : Contactos
    Created on : 28/10/2016, 09:51:01 AM
    Author     : Gustavo Urbina
--%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import ="modelo.Usuario"%>
<%@page import ="controlador.MostrarContactos"%>
<%
    String usuario = (String) session.getAttribute("email");
    String nombreUser = (String) session.getAttribute("nombre");
    String contactos = "";
    String nombre = "";
    String email = "";
    String idContacto = "";
    if (usuario != null) {
        List<LinkedHashMap<String, String>> lista = (List) session.getAttribute("contactos");
        for (int i = 1; i <= lista.size(); i++) {
            LinkedHashMap<String, String> mapa = lista.get(i - 1);
            //for (int j = 0; j <= mapa.size(); j++) {
            idContacto = mapa.get("CO_ID");
            nombre = mapa.get("CO_Nombre");
            email = mapa.get("CO_Email");

            contactos += "<tr><td><h1b> " + nombre + " </h1b></td><td><h1b>" + email + " </h1b></td><td><h1b>\n"
                    + "<a href=\"EliminarContacto?id=" + idContacto + "\" onclick=\"return pregunta()\">Eliminar</a></h1b><br>\n"
                    + "<h1b><a href=\"editarContacto.jsp?id=" + idContacto + "\">Editar</a></h1b></td></tr>\n";
        }


%>



<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%        if (request.getSession().getAttribute("email") == (null)) {
            response.sendRedirect("index.jsp");
        }

    %>

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

        <title>Contactos - Dogebox</title>
        <script language="JavaScript">
            function pregunta() {
                if (confirm('¿Estas seguro de eliminar el contacto?')) {
                    document.tuformulario.submit()
                } else
                    return false;
            }
        </script>
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

    <center> <h1> Bienvenid@ <%= nombreUser%> </h1></center>
    <center><form>


            <table border="3" style="text-align:center;">
                <thead>
                <th class="bco" colspan="4" scope="col"><center><h1b>CONTACTOS</h1b></center></th>
                </thead> 
                <tr>

                    <td class="bco"><h1b>NOMBRE</h1b></td>
                <td class="bco"><h1b>CORREO </h1b></td>
                <td class="bco"> <h1b>ACCIONES </h1b></td>

                </tr>
                <tr class="bco">

                    <%= contactos%>

                </tr>
            </table> <br><br>


        </form></center>

    <form action="InsertarContactos" method="post" id="agregar"></form>



    <center> <table border="3" style="text-align:center;">
            <thead>
            <th class="bco" colspan="3" scope="col" ><center><h1b>Agregar contacto</h1b></center></th>
            <tr>
                <td class="bco"><h1b>Nombre</h1b></td> 
            <td class="bco"><h1b>Correo</h1b></td>
            <td class="bco"><h1b>Guardar</h1b></td>
            </tr> 
            <tr>
                <td><input  type="text" name="txtNombre" maxlength="50" required form="agregar"/></td>
                <td><input type="email" name="txtCorreo" maxlength="50" required form="agregar"/></td>
                <td><input type="submit" value="Agregar contacto" form="agregar"  class="fsSubmitButton"/></td>

            </tr>
            </thead>

        </table> </center>


    <center><form action="iniciado.jsp" method="post">
            <br><br><input type="submit" class="fsSubmitButton"  value="Volver al menú"/><br>
        </form> </center>

<br><br><br><br><br><br><br><br>
    <div class="footer" > Para preguntas,comentarios,asistencia u otros motivos pertinentes contacte a <a href="mailto:dogebox.adm@gmail.com">dogebox.adm@gmail.com</a>
        <br> 
        Copyright © 2016 Dogebox™, Todos los derechos reservados. 
    </div>

</body>

</html>
<%} else {
        response.sendRedirect("index.jsp");
    }%>