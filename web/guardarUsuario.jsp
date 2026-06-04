<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
String nombre = request.getParameter("nombre");
String correo = request.getParameter("correo");
String usuario = request.getParameter("usuario");
String password = request.getParameter("password");
String fecha = request.getParameter("fecha");

Connection con = null;
Statement st = null;

try{

    Class.forName("com.mysql.cj.jdbc.Driver");

    con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/foodsync",
        "root",
        "Emipro"
    );

    st = con.createStatement();

    String sql =
    "INSERT INTO usuarios(nombre,correo,usuario,contrasena,fecha_nacimiento) VALUES('"
    + nombre + "','"
    + correo + "','"
    + usuario + "','"
    + password + "','"
    + fecha + "')";

    st.executeUpdate(sql);

    out.println("<h2>Usuario registrado correctamente</h2>");
    out.println("<a href='Sesion.html'>Iniciar sesión</a>");

}catch(Exception e){

    out.println("Error: " + e);

}
%>