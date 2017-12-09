<%-- 
    Document   : Descripcion_Archivo
    Created on : 28/10/2016, 09:52:50 AM
    Author     : Gustavo Urbina
--%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.List"%>
<%@page import ="controlador.VerArchivos"%>



<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%
        String email = (String) request.getSession().getAttribute("email");

        String ruta = request.getServletContext().getRealPath("/") + "codigosQR\\" + email;
        if (email == (null)) {
            response.sendRedirect("index.jsp");
        } else {
            String nombre = "", tamano = "", recortado = "", status = "", mostrar = "", idArchivo = "", zeldaQR = "";
            List<LinkedHashMap<String, String>> lista = (List) request.getAttribute("listaArchivos");
            for (int i = 1; i <= lista.size(); i++) {
                LinkedHashMap<String, String> mapa = lista.get(i - 1);
                //for (int j = 0; j <= mapa.size(); j++) {
                nombre = mapa.get("AR_Nombre");
                tamano = mapa.get("AR_Tamano");
                recortado = mapa.get("AR_ZeldaCorto");
                status = mapa.get("AR_Status");
                idArchivo = mapa.get("AR_ID");
                zeldaQR = mapa.get("AR_Zelda");

                mostrar += "<tr><td><h1b>" + nombre + "</h1b></td><td><h1b>" + tamano + "</h1b></td><td><h1b><a href=\"" + recortado + "\">" + recortado + "</a></h1b></td><td><h1b>" + status + "</h1b></td><td><h1b>"
                        + "<a href=\"EliminarArchivo?idArchivo=" + idArchivo + "&nombreArchivo=" + nombre + "\" onclick=\"return pregunta()\">Eliminar</a><br>"
                        + "<a href=\"EditarStatus?idArchivo=" + idArchivo + "&status=" + status + "\" onclick=\"return preguntaEditar()\">Editar status</a><br>"
                        + "<a href=\"cambiarPass.jsp?idArchivo=" + idArchivo + "&nombreArchivo=" + nombre + "\">Editar Contraseña</a></h1b></td><td><h1b>"
                        + "<form method=\"get\"><img src=\"ObtenerQR?path=" + ruta + "\\" + zeldaQR + ".png\" height=\"50\" width=\"50\"></form><br><a href=\"ObtenerQR?path=" + ruta + "\\" + zeldaQR + ".png\">"
                        + "Tamaño normal</a></h1b></td><td><h1b>"
                        + "<form method=\"post\" action=\"RecompartirArchivo\">"
                        + "<input type=\"submit\" value=\"Recompartir\" class=\"fsSubmitButton\">"
                        + "<input type=\"hidden\" value=\"" + ruta + "\\" + zeldaQR + ".png\" name=\"qr\">"
                        + "<input type=\"hidden\" value=\"" + recortado + "\" name=\"recortado\">"
                        + "</form>"
                        + "</hlb></td></tr>";
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
        <script language="JavaScript">
            function pregunta() {
                if (confirm('¿Estas seguro de eliminar el archivo?')) {
                    document.tuformulario.submit()
                } else
                    return false;
            }
        </script>
        <script language="JavaScript">
            function preguntaEditar() {
                if (confirm('¿Estas seguro de editar el status?')) {
                    document.tuformulario.submit()
                } else
                    return false;
            }
        </script>

        <title>Mis archivos</title>
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



    <center>   <h1>Mis archivos</h1>
        <table border="3" style="text-align:center;">
            <thead>
            <th colspan="8" scope="col"><center><h1b>Archivos disponibles</h1b></center></th>
            </thead> 
            <tr>
                <!--
                <td>ID</td>   
                -->
                <td class="bco"><h1b>NOMBRE</h1b></td>
            <td class="bco"><h1b>TAMAÑO(KB)</h1b></td>
            <td class="bco"><h1b>URL</h1b></td>
            <td class="bco"><h1b>STATUS</h1b></td>
            <td class="bco"><h1b>ACCIONES</h1b></td>
            <td class="bco"><h1b>CODIGO QR</h1b></td>
            <td class="bco"><h1b>RECOMPARTIR</h1b></td>

            </tr>

            <%= mostrar%>
        </table> <br><br> 

        <form action="iniciado.jsp" method="post">
            <input class="fsSubmitButton" type="submit" value="Volver al menú"/><br>
        </form>
    </center>


    <script src="http://code.jquery.com/jquery.js"></script>

    <!-- Todos los plugins JavaScript de Bootstrap (también puedes
         incluir archivos JavaScript individuales de los únicos
         plugins que utilices) -->
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>

    <br>
    <br>
    <br>


    
</body>



</html>
<%}%>