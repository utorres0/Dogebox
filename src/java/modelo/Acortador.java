/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.io.IOException;
import java.io.StringReader;
import javax.json.Json;
import javax.json.JsonObject;
import javax.json.JsonReader;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;

public abstract class Acortador {

    public static String acortar(String urlLarga) throws IOException {
        /*HttpPost post = new HttpPost("https://www.googleapis.com/urlshortener/v1/url?key=AIzaSyBaXVHCGHYY3Zy97HXP8WCm1d0le1Uesd8");
        String urlCorta="";
        post.setHeader(
                "Content-Type", "application/json");
        post.setEntity(
                new StringEntity("{'longUrl': '" + urlLarga + "'}", "UTF-8"));

        HttpResponse response = new DefaultHttpClient().execute(post);

        String responseText = EntityUtils.toString(response.getEntity());
        JsonReader jsonReader = Json.createReader(new StringReader(responseText));
        JsonObject object = jsonReader.readObject();
        urlCorta =object.getString("id");
        jsonReader.close();*/
        System.out.println("EL ACORTADOR SE QUITO");

        return urlLarga;
    }

}
