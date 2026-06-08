<%@page import="java.sql.*"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>

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

    <!-- NAVBAR -->

    <nav class="navbar-top">

        <div class="logo-box">
            <img src="imagen/Logo.png" alt="FoodSync" class="nav-logo">
        </div>

    </nav>

    <!-- MENU -->

     <div class="menu-nav">
            
            <a href="Inicio.html">Inicio</a>

            <span>|</span>
            
            <!-- página actual -->
            <a href="Platillos.jsp">Platillos</a>

            <span>|</span>

            <a href="Mesas.jsp">Mesas</a>

            <span>|</span>

            <a href="Reservaciones.jsp">Reservaciones</a>
 
            <span>|</span>

            <a href="Pedidos.jsp">Pedidos</a>

            <span>|</span>

            <a href="Personal.jsp">Personal</a>

            <span>|</span>

            <a href="Clientes.jsp">Clientes</a>

            <span>|</span>

            <a href="Ventas.jsp">Ventas</a>

            <span>|</span>

            <a href="Cocina.jsp">Cocina</a>

        </div>


    <!-- CONTENIDO -->

    <main class="contenido">

        <section class="panel-principal">

            <h1 class="titulo-menu">
                Menú de platillos
            </h1>

            <!-- BARRA -->

            <div class="barra-acciones">
                <a href="Platillos.jsp" class="activo" >Consultar</a>
                <span>|</span>
                <a href="Platillos/Agregar.jsp">Agregar</a>
                <span>|</span>
                <a href="Platillos/Eliminar.jsp" >Eliminar</a>
                <span>|</span>
                <a href="Platillos/Modificar.jsp">Modificar</a>
            </div>
            
            <!-- TARJETAS -->

            <div class="galeria-platillos">

            <%
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            try{

                Class.forName("com.mysql.cj.jdbc.Driver");

                con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/FoodSync",
                    "root",
                    "n0m3l0"
                );

                ps = con.prepareStatement(
                    "SELECT * FROM Platillos WHERE estado='Disponible'"
                );

                rs = ps.executeQuery();

                while(rs.next()){
            %>

                <div class="card-platillo">

                    <img src="Platillos/<%= rs.getString("ruta_imagen") %>"
                         alt="<%= rs.getString("nombre") %>">

                    <h3><%= rs.getString("nombre") %></h3>

                    <p><%= rs.getString("categoria") %></p>

                    <span>$<%= rs.getDouble("precio") %></span>

                </div>

            <%
                }

            }catch(Exception e){

                out.println("<h2>Error: " + e.getMessage() + "</h2>");

            }finally{

                try{
                    if(rs!=null) rs.close();
                    if(ps!=null) ps.close();
                    if(con!=null) con.close();
                }catch(Exception ex){}

            }
            %>

</div>

        </section>

    </main>

    <!-- FOOTER -->
        <footer class="pie-morado">

            <div class="footer-box">

                <h4>Horario</h4>

                <p>Lunes - Domingo</p>

                <p>8:00 AM - 11:00 PM</p>

            </div>

            <div class="footer-box">

                <h4>Ubicación</h4>

                <p>Av. FoodSync #128</p>

                <p>Ciudad de México</p>

            </div>

            <div class="footer-box">

                <h4>Síguenos</h4>

                <div class="iconos">
                    <i class="fa-brands fa-facebook-f"></i>
                    <i class="fa-brands fa-instagram"></i>
                    <i class="fa-brands fa-x-twitter"></i>
                    <i class="fa-brands fa-youtube"></i>
                </div>
            </div>
        </footer>

        <!-- COPYRIGHT -->
        <div class="copy">
            © 2026 FoodSync — Todos los derechos reservados
        </div>

</div>

</body>
</html>