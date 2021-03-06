package com.sharu.samples;

import java.util.*;

import com.fasterxml.jackson.databind.ObjectMapper;
import login.login;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.json.simple.JSONArray;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import login.Product;

/**
 * Created by SAROJINI on 7/16/2016.
 */
@WebServlet(name = "SearchServlet",urlPatterns = {"/servlet/search"})
public class SearchServlet extends HttpServlet {
    private static ObjectMapper objectMapper = new ObjectMapper();
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
        JSONParser parser = new JSONParser();
        JSONObject joUser1 = null;
        JSONArray jsonArray = new JSONArray();
        String itemsListString = "";
        List<Product> itemsList = new ArrayList<Product>();
        try{
            joUser1 = (JSONObject)new JSONParser().parse(responseString);
            String category = (String)joUser1.get("item");
            System.out.println("category selected: " + category);
            itemsList = login.search(category);
            itemsListString = objectMapper.writeValueAsString(itemsList);
//            jsonArray.add(itemsList);
           // System.out.println("json object " + );

        }catch(ParseException e){
            e.printStackTrace();
        }catch(Exception e){
            e.printStackTrace();
        }
        if(itemsList.size() != 0){
            // Display cart information to the user
            response.setContentType("application/json");
            response.getWriter().write(itemsListString);
            response.getWriter().flush();
            response.getWriter().close();
        }else{
            // Throw an error to user
            response.getWriter().write("Invalid entry selected ! ");
            response.getWriter().flush();
            response.getWriter().close();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // N/A
    }
}
