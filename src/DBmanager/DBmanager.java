package DBmanager;

/**
 * Created by SAROJINI on 7/8/2016.
 */
import java.sql.*;
import java.util.*;
import login.login;
import com.sharu.samples.MyServlet;
import com.sharu.samples.SignupServlet;
public class DBmanager {
    Connection conn;
    Statement stmt;
    ResultSet results = null;
    public ResultSet runSelect(String sql) throws Exception{
        try{
            this.stmt = this.conn.createStatement();
            results = stmt.executeQuery(sql);
            return results;
        }catch (SQLException ex){
            ex.printStackTrace();
        }
        return results;
    }
    public int runUpdate(String sql) throws Exception{
        try{
            this.stmt = this.conn.createStatement();
            stmt.executeUpdate(sql);
        }catch (SQLException ex){
            ex.printStackTrace();
        }
        return 1;
    }

    public void setup_connection() throws Exception{
        try{
//            System.out.println(PropertyReader.getDriver());
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/ordermanagement?autoReconnect=true&useSSL=false","sarojini","sarojini");

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }


    public void close_connection() throws Exception{
        try{
            if(results!=null) results.close();
        }catch (SQLException ex){
            ex.printStackTrace();
        }
        try{
            if(stmt!=null) stmt.close();
        }catch (SQLException ex){
            ex.printStackTrace();
        }
        try{
            if(conn!=null) conn.close();
        }catch (SQLException ex){
            ex.printStackTrace();
        }
    }
}

