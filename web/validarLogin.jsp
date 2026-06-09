<%@page import="java.sql.*"%>

<%
String usuario = request.getParameter("usuario");
String password = request.getParameter("password");

Connection con = null;
Statement st = null;
ResultSet rs = null;

try{

    Class.forName("com.mysql.cj.jdbc.Driver");

    con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/foodsync",
        "root",
        "n0m3l0"
    );

    st = con.createStatement();

    rs = st.executeQuery(
        "SELECT * FROM Clientes WHERE Clientes='"
        + usuario +
        "' AND password='"
        + password + "'"
    );

    if(rs.next()){

        response.sendRedirect("index.html");

    }else{

        out.println("<h2>Usuario o contraseña incorrectos</h2>");
        out.println("<a href='Sesion.jsp'>Volver</a>");

    }

}catch(Exception e){

    out.println(e);

}
%>