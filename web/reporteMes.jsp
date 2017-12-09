<%-- 
    Document   : reporteMes
    Created on : 21/11/2016, 10:31:14 PM
    Author     : oneee
--%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%

    if (request.getSession().getAttribute("email") == (null)) {
        response.sendRedirect("index.jsp");
    } else {
        String fechaRegistrado = "", fechaAnonimo = "", mostrar = "";

        List<LinkedHashMap<String, String>> listaRegistrado = (List) request.getAttribute("listaRegistrado");
        for (int i = 1; i <= listaRegistrado.size(); i++) {
            LinkedHashMap<String, String> mapa = listaRegistrado.get(i - 1);
            //for (int j = 0; j <= mapa.size(); j++) {
            fechaRegistrado = mapa.get("ADR_Fecha_Hora_descarga");

            mostrar += "<tr><td><h1b>" + fechaRegistrado + "</h1b></td>";
        }
        String nombreArchivo = (String) request.getAttribute("nombreArchivo");
        List<LinkedHashMap<String, String>> listaAnonimo = (List) request.getAttribute("listaAnonimo");
        for (int i = 1; i <= listaAnonimo.size(); i++) {
            LinkedHashMap<String, String> mapa = listaAnonimo.get(i - 1);
            //for (int j = 0; j <= mapa.size(); j++) {
            fechaAnonimo = mapa.get("AA_Fecha_Hora_descarga");

            mostrar += "<td><h1b>" + fechaAnonimo + "<h1b></td></tr>";
        }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximun-scale=1.0, minimum-scale=1.0">


        <!-- Título de la página -->
        <title>Reporte mensual</title>

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


    <body  background="img/footer_lodyas.png">

        <!-- Nuestro header, con su icono y menú -->
        <header class="header">
            <div class="wrapper">
                <div class="logo">
                    <a href="index.jsp"> <img src="img/dogecoin.png" alt="Logotipo" width="95" height="95"> </div> </a>

                    <a href="index.jsp"> <div class="logo">Dogebox </div> </a>
                    <nav>

                        <a href="subirArchivo.jsp">Subir archivo</a>
                        <a href="contactos.jsp">Contactos</a>
                        <a href="archivosSubidos.jsp">Mis archivos</a>

                    </nav>

                </div>
        </header>



    <center><h1>Reporte de <%=nombreArchivo%></h1>
        <table border="3" style="text-align:center;">
            <thead>
            <th class="bco" colspan="4" scope="col"></th>
            </thead> 
            <tr>
                <!--
                <td>ID</td>   
                -->
                <td class="bco"><h1b>Descarga registrado</h1b></td>
            <td class="bco"><h1b>Descarga anonimo</h1b></td>


            </tr>

            <%= mostrar%>
        </table> <br><br>
        <a href="Estadisticas">Regresar a estadisticas</a> </center>

    <div class="footer"> Para preguntas,comentarios,asistencia u otros motivos pertinentes contacte a <a href="mailto:dogebox.adm@gmail.com">dogebox.adm@gmail.com</a>
        <br> 
        Copyright © 2016 Dogebox™, Todos los derechos reservados. 
    </div>
</body>
</html>
<%}%>