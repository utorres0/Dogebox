/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.io.File;
import java.util.Properties;
import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

/**
 *
 * @author oneee
 */
public class Correos {

    private final Properties properties = new Properties();

    private final String password = "dogebox1";
    private final String user = "dogebox.adm@gmail.com";

    private Session session;

    private void iniciar() {

        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "587");

    }

    public void enviarConfirmación(String destinatario, String idActivacion) {
        iniciar();
        String mensaje = "Buen día. Se ha registrado satisfactoriamente en Dogebox. Antes de continuar, usted necesita verificar su cuenta"
                + " en el siguiente enlace: http://dogebox.ddns.net/dogebox/VerificarCuenta?idActivacion=" + idActivacion + " Cuando active su cuenta, ya podrá usar su nueva cuenta para compartir sus archivos. Muchas"
                + " gracias por registrarse de parte del equipo de Dogebox";
        session = Session.getInstance(properties,
                new javax.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(user, password);
            }
        });

        try {

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(user));
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(destinatario));
            message.setSubject("Activacion de cuenta en Dogebox");
            message.setText(mensaje);

            Transport.send(message);

        } catch (MessagingException e) {
            
        }
    }

    public void sendEmail(String mensaje, String destinatario, String asunto) {

        iniciar();
        session = Session.getInstance(properties,
                new javax.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(user, password);
            }
        });

        try {

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(user));
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(destinatario));
            message.setSubject(asunto);
            message.setText(mensaje);

            Transport.send(message);

        } catch (MessagingException e) {

        }

    }

    public String enviarAdjunto(String mensaje, String destinatario, String asunto, String path) {
        BodyPart texto = new MimeBodyPart();
        BodyPart adjunto = new MimeBodyPart();
        MimeMultipart multiParte = new MimeMultipart();
        try {
            texto.setText(mensaje);

            adjunto.setDataHandler(new DataHandler(new FileDataSource(path)));
            File f = new File(path);
            adjunto.setFileName(f.getName());

            multiParte.addBodyPart(texto);
            multiParte.addBodyPart(adjunto);
        } catch (MessagingException e) {
        }

        iniciar();
        session = Session.getInstance(properties,
                new javax.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(user, password);
            }
        });

        try {

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(user));
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(destinatario));
            message.setSubject(asunto);
            message.setContent(multiParte);

            Transport.send(message);

        } catch (MessagingException e) {
            return e.getCause().toString();
        }
        return "Mensaje Enviado con exito<br>"
                + "<a href=\"index.jsp\"/>Regresar a incio</a>";
    }

}
