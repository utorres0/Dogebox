/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author oneee
 */
public class Fechas {

    private final DateFormat formatoFecha = new SimpleDateFormat("yyyy-MM-dd");
    private final DateFormat formatoHora = new SimpleDateFormat("HH:mm:ss");
    private final SimpleDateFormat formatoCompleto = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    /**
     *
     * @param fechaActual
     * @return Regresa el formato de la fecha en YYYY-MM-DD
     */
    public String fechaActual(Date fechaActual) {

        return formatoFecha.format(fechaActual);
    }

    public String fechaCompletaActual(Date fechaActual) {

        return formatoCompleto.format(fechaActual);
    }

    /**
     *
     * @param horaActual
     * @return Regresa la hora en string como HH-MM-SS
     */
    public String horaActual(Date horaActual) {

        return formatoHora.format(horaActual);

    }

    /**
     *
     * @param fechaActual
     * @param fechaExp
     * @return 0=Fechas exactas, 1=Fecha acutal antes de exp 2=Fecha actual
     * despues de exp
     */
    public int compararFechas(String fechaActual, String fechaExp) {

        Date actual = null;
        Date exp = null;
        try {
            actual = formatoCompleto.parse(fechaActual);
            exp = formatoCompleto.parse(fechaExp);
        } catch (ParseException ex) {
            Logger.getLogger(Fechas.class.getName()).log(Level.SEVERE, null, ex);
        }

        int res = 0;

        if (actual.before(exp)) {
            res = 1;
        } else if (actual.after(exp)) {
            res = 2;
        } else {
            res = 0;
        }
        return res;
    }

    public String aumentarFecha(Date fechaActual) {

        Calendar cal = Calendar.getInstance();
        cal.setTime(fechaActual);
        cal.add(Calendar.HOUR, 48);

        return formatoFecha.format(cal.getTime());
    }

    public String aumentarSemana(Date fechaActual) {

        Calendar cal = Calendar.getInstance();
        cal.setTime(fechaActual);
        cal.add(Calendar.WEEK_OF_MONTH, 1);

        return formatoFecha.format(cal.getTime());
    }

}
