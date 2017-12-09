<%-- 
    Document   : exitoSubida
    Created on : 14/11/2016, 03:18:37 PM
    Author     : oneee
--%>

<%@page import="org.jboss.logging.Param"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%

    String email = (String) request.getSession().getAttribute("email");
    String path = (String) request.getAttribute("path");
    String anonimo = (String) request.getSession().getAttribute("usuarioAnonimo");
    String enlaceCorto = (String) request.getAttribute("respuesta");

    if (email == (null) && anonimo == null) {
        response.sendRedirect("index.jsp");
    } else if (enlaceCorto == null) {
        response.sendRedirect("iniciado.jsp");
    } else if (enlaceCorto.equals("no")) {
        response.sendRedirect("errorSubida.jsp");
    } else {


%>

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

        <title>Éxito al subir - Dogebox</title>
    </head>

    <body  background="img/footer_lodyas.png">

        <!-- Nuestro header, con su icono y menú -->
        <header class="header">
            <div class="wrapper">
                <div class="logo">
                    <a href="index.jsp"> <img src="img/dogecoin.png" alt="Logotipo" width="95" height="95"> </div> </a>

                    <a href="index.jsp"> <div class="logo">Dogebox </div> </a>

                    <%if (email != null) {%>
                    <nav>
                        <a href="subirArchivo.jsp">Subir archivo</a>
                        <a href="VerArchivos">Mis archivos</a>
                        <a href="Estadisticas">Estadísticas</a>
                    </nav>
                    <%}%>
                </div>
        </header>
    <center>
        <h1>Su enlace de descarga es: </h1>
        <h1><a href="<%= enlaceCorto%>" ><%=enlaceCorto%></a></h1>
        <form method="get">
            <img src="ObtenerQR?path=<%=path%>" title="Codigo QR" width="150" height="150"/><br>
        </form>
    </center>
    <%
        List< LinkedHashMap< String, String>> lista = (List<LinkedHashMap<String, String>>) request.getAttribute("lista");
        String valor = "";
        if (lista != null) {
            String nombreContacto = "";
            String emailContacto = "";

            for (int i = 1; i <= lista.size(); i++) {
                LinkedHashMap<String, String> mapa = lista.get(i - 1);

                nombreContacto = mapa.get("CO_Nombre");
                emailContacto = mapa.get("CO_Email");
                valor += "<option value=\"" + emailContacto + "\">" + nombreContacto + "</option>";
            }
        }
        if (email != null) {

    %>
    <center>
        <h1b> Envíe por correo el link de descarga</h1b><br>
        <h1b>y el código qr. </h1b><br>
        <form action="EnviarCorreo" method="post">
            <h1b>Puede seleccionar el contacto de su lista o ingresar un email nuevo. </h1b> <br><br>
            <h1b>Destinatario: </h1b> <select name="slcDestinatario">
                <option value=""></option>
                <%=valor%>
            </select><br><br>
            <h1b>Destinatario Alternativo:</h1b> <input type="email" name="txtDestinatario" maxlength="50" ><br><br>
            <h1b>Asunto: </h1b> <input type="text" name="txtAsunto" maxlength="50"><br><br>
            <textarea name="txtContenido" rows="10" cols="40" placeholder="Escriba el mensaje deseado."></textarea><br><br>

            <input type="submit" class="fsSubmitButton" name="cmdCorreo" value="Enviar Correo">
            <a href="iniciado.jsp" class="fsSubmitButton">Regresar al menú principal</a>
            <input type="hidden" value="<%=path%>" name="path">
            <input type="hidden" value="<%=enlaceCorto%>" name="enlaceCorto">
        </form>
        <br>
        <br>
    </center>
    <%} else if (anonimo != null) {
    %>
    <center>
        <form action="EnviarCorreo" method="post">
            <h1b>Destinatario: </h1b><input type="email" name="txtDestinatario" maxlength="50" required><br><br>

            <h1b>Asunto: </h1b> <input type="text" name="txtAsunto" maxlength="50"><br><br>
            <textarea name="txtContenido" rows="10" cols="40" placeholder="Escriba el mensaje deseado."></textarea><br>

            <input type="submit" class="fsSubmitButton" name="cmdCorreo" value="Enviar Correo">
            <a href="index.jsp" class="fsSubmitButton">Regresar a Inicio</a> 
            <input type="hidden" value="<%=path%>" name="path">
            <input type="hidden" value="<%=enlaceCorto%>" name="enlaceCorto">
            
        </form>
        <br>
        
    </center>

    <%
        }
    %>
    
</body>
</html>
<%}%>
