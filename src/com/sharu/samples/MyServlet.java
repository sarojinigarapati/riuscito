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
 * Created by SAROJINI on 7/9/2016.
 */
@WebServlet(name = "MyServlet", urlPatterns={"/a/b/c","/servlet/login"})
public class MyServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Authenticate username and password
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
        boolean isValidUSer = false;
        JSONParser parser = new JSONParser();
        JSONObject joUser = null;
        try{
            joUser = (JSONObject)new JSONParser().parse(responseString);
            String username = (String)joUser.get("username");
            String password = (String)joUser.get("password");
            isValidUSer = login.validate(username,password);
        }catch(ParseException e){
            e.printStackTrace();
        }catch(Exception e){
            e.printStackTrace();
        }
        if(isValidUSer){
           // Display cart information to the user
            response.getWriter().write("Hey, you have successfully logged in!!!");
            response.getWriter().flush();
            response.getWriter().close();
        }else{
          // Throw an error to user
            response.getWriter().write("User is not authorized to login, Please sign up first.");
            response.getWriter().flush();
            response.getWriter().close();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.println("<h1> Be like sharu and fuck like sharu!!!!<h1>");
        out.flush();
        out.close();
    }
}
