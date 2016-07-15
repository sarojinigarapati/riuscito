package com.sharu.samples;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import login.login;
import DBmanager.DBmanager;

/**
 * Created by SAROJINI on 7/12/2016.
 */
@WebServlet(name = "SignupServlet", urlPatterns = {"/servlet/signup"})
public class SignupServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        StringBuffer jb = new StringBuffer();
        String line = null;
        try {
            BufferedReader reader = request.getReader();
            while ((line = reader.readLine()) != null)
                jb.append(line);
        } catch (Exception e) {
            e.printStackTrace();
        }

        String responseString = jb.toString();
        boolean registered = false;
        JSONParser parser = new JSONParser();
        JSONObject joUser = null;
        try{
            joUser = (JSONObject)new JSONParser().parse(responseString);
            String username = (String)joUser.get("username");
            String password = (String)joUser.get("password");
            String name = (String)joUser.get("name");
            registered = login.register(username,password,name);
        }catch(ParseException e){
            e.printStackTrace();
        }catch(Exception e){
            e.printStackTrace();
        }
        if(registered == true){
            response.getWriter().write("Hey, you have successfully signed up!!!");
            response.getWriter().flush();
            response.getWriter().close();
        } else {
            response.getWriter().write("You are not signed up!!!");
            response.getWriter().flush();
            response.getWriter().close();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //TO-DO
    }
}
