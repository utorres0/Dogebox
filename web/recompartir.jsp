<%-- 
    Document   : recompartir
    Created on : 26/11/2016, 04:01:57 PM
    Author     : oneee
--%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.List"%>
<%
    String path = (String) request.getAttribute("qrRecompartir");
    String enlaceCorto = (String) request.getAttribute("recortadoRecompartir");
    List< LinkedHashMap< String, String>> lista = (List<LinkedHashMap<String, String>>) request.getAttribute("listaRecompartir");
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
    if (request.getSession().getAttribute("email") == (null)) {
        response.sendRedirect("index.jsp");
    }%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximun-scale=1.0, minimum-scale=1.0">


    <!-- Título de la página -->
    <title>Recompartir archivo</title>

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
                    <a href="MostrarContactos">Contactos</a>
                    <a href="Estadisticas">Estadísticas</a>

                </nav>

            </div>
    </header>

    <section class="contenido wrapper fondo">
        <center><form action="EnviarCorreo" method="post">
                <h1> Recompartir archivo</h1>
                <h1b>Puede seleccionar el contacto de su lista o ingresar un email nuevo.</h1b><br><br>
                <h1b>Destinatario: </h1b><select name="slcDestinatario">
                    <option value=""></option>
                    <%=valor%>
                </select><br><br>
                <h1b> Destinatario Alternativo: </h1b><input type="email" name="txtDestinatario" maxlength="50" ><br><br>
                <h1b> Asunto: </h1b><input type="text" name="txtAsunto" maxlength="50"><br><br>
                <textarea name="txtContenido" rows="10" cols="40" placeholder="Escriba el mensaje deseado."></textarea><br>

                <input type="submit" class="fsSubmitButton" name="cmdCorreo" value="Enviar Correo"><br>
                <input type="hidden" value="<%=path%>" name="path">
                <input type="hidden" value="<%=enlaceCorto%>" name="enlaceCorto">
            </form></center>
    </section>
    <div class="footer"> Para preguntas,comentarios,asistencia u otros motivos pertinentes contacte a <a href="mailto:dogebox.adm@gmail.com">dogebox.adm@gmail.com</a>
        <br> 
        Copyright © 2016 Dogebox™, Todos los derechos reservados. 
    </div>
</body>
</html>
