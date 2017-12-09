/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import facebook4j.Facebook;
import facebook4j.FacebookException;
import facebook4j.FacebookFactory;
import facebook4j.PostUpdate;
import facebook4j.auth.AccessToken;
import java.net.MalformedURLException;
import java.net.URL;

/**
 *
 * @author oneee
 */
public class ConexionFb {
    
    public final String appId="700624750104877";
    public final String appSecret="d0c5260393e695acb2859e779d557f7b";
    public final String accessToken="700624750104877|e7xjuROYoqUFyA1TDm3XFWSrJAk";
    
    public Facebook getInstance() throws FacebookException {
        Facebook facebook = (Facebook) new FacebookFactory().getInstance();
        facebook.setOAuthAppId(appId, appSecret);
        facebook.setOAuthAccessToken(new AccessToken(accessToken, null));
        return facebook;
    }
    
    public void post(Facebook facebook) throws MalformedURLException, FacebookException{
        PostUpdate post = new PostUpdate(new URL("http://facebook4j.org"))
                    .picture(new URL("http://facebook4j.org/images/hero.png"))
                    .name("Facebook4J - A Java library for the Facebook Graph API")
                    .caption("facebook4j.org")
                    .description("Facebook4J is a Java library for the Facebook Graph API.");
        facebook.postFeed(post);
    }
}
