
<!DOCTYPE html>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>



<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FoodSync - Menú de Platillos</title>

<link rel="stylesheet" href="Platillos/Platilloss.css">

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;700&family=Pacifico&display=swap" rel="stylesheet">


</head>

<body>

<div class="contenedor-sitio">

<nav class="navbar-top">
    <div class="logo-box">
        <img src="imagen/Logo.png" alt="FoodSync" class="nav-logo">
    </div>
</nav>

<div class="menu-nav">
    <a href="Inicio.html">Inicio</a>
    <span>|</span>
    <a href="Platillos.jsp">Platillos</a>
    <span>|</span>
    <a href="Mesas.html">Mesas</a>
    <span>|</span>
    <a href="Reservaciones.html">Reservaciones</a>
    <span>|</span>
    <a href="Pedidos.html">Pedidos</a>
    <span>|</span>
    <a href="Personal.html">Personal</a>
    <span>|</span>
    <a href="Clientes.html">Clientes</a>
    <span>|</span>
    <a href="Ventas.html">Ventas</a>
    <span>|</span>
    <a href="Cocina.html">Cocina</a>
</div>

<main class="contenido">

    <section class="panel-principal">

        <h1 class="titulo-menu">
            Menú de platillos
        </h1>

        <div class="barra-acciones">
            <a href="Platillos.jsp" class="activo">Consultar</a>
            <span>|</span>
            <a href="Platillos/Agregar.html">Agregar</a>
            <span>|</span>
            <a href="Platillos/Eliminar.html">Eliminar</a>
            <span>|</span>
            <a href="Platillos/Modificar.html">Modificar</a>
        </div>

        <div class="galeria-platillos">

            <%
            Connection con = null;
            Statement st = null;
            ResultSet rs = null;

            try{

                Class.forName("com.mysql.cj.jdbc.Driver");

                con = DriverManager.getConnection(
                    "jdbc:mysql://localhost/empresa?useSSL=false",
                    "root",
                    "Nelly2909"
                );

                st = con.createStatement();

                rs = st.executeQuery(
                    "SELECT * FROM Platillos WHERE estado='Disponible'"
                );

                while(rs.next()){
            %>

                <div class="card-platillo">

                    <img src="Platillos/<%= rs.getString("ruta_imagen") %>">

                    <h3>
                        <%= rs.getString("nombre") %>
                    </h3>

                    <p>
                        <%= rs.getString("categoria") %>
                    </p>

                    <span>
                        $<%= rs.getDouble("precio") %>
                    </span>

                </div>

            <%
                }

            }catch(Exception e){

                out.println("<h3>Error: "+e.toString()+"</h3>");

            }

            if(rs!=null) rs.close();
            if(st!=null) st.close();
            if(con!=null) con.close();
            %>

        </div>

    </section>

</main>

</div>

</body>
</html>
