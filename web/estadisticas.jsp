<%-- 
    Document   : Reportes
    Created on : 28/10/2016, 09:51:54 AM
    Author     : Gustavo Urbina
--%>
<%@page import="modelo.Fechas"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.List"%>
<%@page import="controlador.Estadisticas" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <%
        if (request.getSession().getAttribute("email") == (null)) {
            response.sendRedirect("index.jsp");
        } else {
            Date fecha = new Date();
            Fechas f = new Fechas();
            String fechaActual = f.fechaActual(fecha);
            String accesos = "", descargas = "", nombre = "", status = "", mostrar = "", idArchivo = "";
            List<LinkedHashMap<String, String>> lista = (List) request.getAttribute("estadisticas");
            for (int i = 1; i <= lista.size(); i++) {
                LinkedHashMap<String, String> mapa = lista.get(i - 1);
                //for (int j = 0; j <= mapa.size(); j++) {
                accesos = mapa.get("AR_Accesos_totales");
                nombre = mapa.get("AR_Nombre");
                descargas = mapa.get("AR_Descarga_totales");
                idArchivo = mapa.get("AR_ID");

                mostrar += "<tr><td><h1b>" + nombre + "</h1b></td><td><h1b>" + accesos + "</h1b></td><td><h1b>" + descargas + "</h1b></td><td>"
                        + "<form action=\"ReporteMes\" method=\"post\">"
                        + "<input type=\"hidden\" value=\"" + idArchivo + "\" name=\"idArchivo\">"
                        + "<input type=\"hidden\" value=\"" + nombre + "\" name=\"nombreArchivo\">"
                        + "<input type=\"date\" name=\"fechaInicio\" step=\"1\" min=\"2013-01-01\" max=\"" + fechaActual + " required\">"
                        + "<input type=\"date\" name=\"fechaFin\" step=\"1\" min=\"2013-01-01\" max=\"" + fechaActual + "required\">"
                        + "<input type=\"submit\" value=\"Reporte\" class=\"fsSubmitButton\">"
                        + "</form></td></tr>";
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

        <title>Estadísticas</title>
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

    <center><h1>Estadísticas</h1></center>

    <center> 
        <table border="3" style="text-align:center;">
            <thead>
            <th class="bco" colspan="4" scope="col"></th>
            </thead> 
            <tr>

                <td class="bco"><h1b>Nombre del archivo</h1b></td>
            <td class="bco"><h1b>Reportes generados</h1b></td>
            <td class="bco"><h1b>Descargas totales</h1b></td>
            <td class="bco"><h1b>Rango de fechas para reporte</h1b></td>

            </tr>

            <%= mostrar%>
        </table> <<br><br> </center>

    <center> 
        <form action="iniciado.jsp" method="post">
            <input class="fsSubmitButton" type="submit" value="Regresar al menú principal"/><br>
        </form> 
    </center>
    <div class="footer"> Para preguntas,comentarios,asistencia u otros motivos pertinentes contacte a <a href="mailto:dogebox.adm@gmail.com">dogebox.adm@gmail.com</a>
        <br> 
        Copyright © 2016 Dogebox™, Todos los derechos reservados. 
    </div>
</body>
</html>
<%}%>