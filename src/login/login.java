package login;

/**
 * Created by SAROJINI on 7/8/2016.
 */
import java.sql.*;
import java.util.*;
import DBmanager.DBmanager;
import com.sharu.samples.MyServlet;
import com.sharu.samples.SearchServlet;
import com.sharu.samples.SignupServlet;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.json.simple.JSONArray;
import java.util.stream.*;


public class login {
    /*public static void main(String[] args) throws Exception {
        //Scanner sc = new Scanner(System.in);
        //String username = sc.nextLine();
        //String password = sc.nextLine();
        System.out.println("The prog entered main");
        login loginController = new login();
        boolean isValid = loginController.validate("Kalia", "mi");
        System.out.println("The result is " + isValid);

    }*/

    public static boolean validate(String username, String password) throws Exception {
        String name = null, passwrd = null;
        DBmanager manager = new DBmanager();
        ResultSet rs = null;
        try {
            String sql = "SELECT Username,Password FROM customers where Username = '" + username + "' AND Password = '" + password + "'";
            manager.setup_connection();
            rs = manager.runSelect(sql);
            while (rs.next()) {
                name = rs.getString("username");
                passwrd = rs.getString("password");
            }
            System.out.println("name is " + name + " password is " + passwrd);
            System.out.println("name is " + username + " password is " + password);
            //parsing
            if (username.equals(name) && password.equals(passwrd)) {
                return true;
            } else {
                return false;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null) rs.close();
            manager.close_connection();
        }
        return false;
    }

    public static int register(String username, String password, String name) throws Exception {
        DBmanager manager = new DBmanager();
        Integer rs = 1;
        try{
            System.out.println("username:" + username);
            String sql = "INSERT INTO customers(CustomerID,Username,Password,CustomerName)" + "VALUES (0,'" +username+"','"+password+"', '"+name+"')";
            manager.setup_connection();
          rs = manager.runUpdate(sql);

        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            manager.close_connection();
        }
        return rs;
    }

    public static List<Product> search (String category) throws Exception {
        DBmanager manager = new DBmanager();
        List<Product> list = new ArrayList<Product>();
        ResultSet rs = null;
        try{
            System.out.println("category:" + category);
            String sql = "SELECT ProductName,ProductPrice FROM products WHERE CategoryName IN (SELECT Category FROM category WHERE Category = '" + category + "')";
            manager.setup_connection();
            rs = manager.runSelect(sql);
            while (rs.next()) {
                Product p = new Product();
                p.setName(rs.getString("ProductName"));
                p.setPrice(rs.getString("ProductPrice"));
                list.add(p);
                System.out.println(p.getName() + " - " + p.getPrice());
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            manager.close_connection();
        }
        return list;
    }
    public static String listToString(List<?> list) {
        String result = "+";
        for (int i = 0; i < list.size(); i++) {
            result += " " + list.get(i);
        }
        return result;
    }
}

