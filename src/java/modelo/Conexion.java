package modelo;

import java.sql.Connection;
import java.sql.DriverManager;

public class Conexion {

    Connection con;

    public Connection conectar(){

        try{

            Class.forName("com.mysql.cj.jdbc.Driver");

            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/foodsync",
                "root",
                "Emipro"
            );

            System.out.println("Conexion exitosa");

        }catch(Exception e){

            System.out.println("Error: " + e);

        }

        return con;
    }
}