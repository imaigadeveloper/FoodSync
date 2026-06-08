<%@ page import="modelo.Conexion" %>
<%@ page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Personal</title>
    <link rel="stylesheet" href="Personal.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;700&family=Pacifico&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>
<body>

<div class="contenedor-sitio">

    <nav class="navbar-top">
        <div class="logo-box">
            <img src="imagen/Logo.png" alt="FoodSync" class="nav-logo">
        </div>
    </nav>

    <div class="menu-nav">
        <a href="Inicio.jsp">Inicio</a> <span>|</span>
        <a href="Platillos.jsp">Platillos</a> <span>|</span>
        <a href="Mesas.jsp">Mesas</a> <span>|</span>
        <a href="Reservaciones.jsp">Reservaciones</a> <span>|</span>
        <a href="Pedidos.jsp">Pedidos</a> <span>|</span>
        <a href="Personal.jsp" class="activo">Personal</a> <span>|</span>
        <a href="Clientes.html">Clientes</a> <span>|</span>
        <a href="Ventas.jsp">Ventas</a> <span>|</span>
        <a href="Cocina.jsp">Cocina</a>
    </div>
            <main class="contenido">
                <section class="panel-principal">
                    <div class="titulo-personal">
                        <h1>Personal</h1>
                    </div>

                    <div class="tabla-personal">
                    <%
                        Connection con = null;
                        PreparedStatement ps = null;
                        ResultSet rs = null;

                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            con = DriverManager.getConnection("jdbc:mysql://localhost/FoodSync?autoReconnect=true&useSSL=false", "root", "n0m3l0");

                            // Consulta para obtener todo el personal con su puesto y estado
                            ps = con.prepareStatement("SELECT nombre, id_puesto, id_estado, horario FROM Personal ORDER BY id_puesto");
                            rs = ps.executeQuery();

                            int puestoActual = -1;

                            while (rs.next()) {
                                String nombre = rs.getString("nombre");
                                int puesto = rs.getInt("id_puesto");
                                int estado = rs.getInt("id_estado");
                                String horario = rs.getString("horario");

                                // Mostrar categoría solo cuando cambia el puesto
                                if (puesto != puestoActual) {
                                    if (puesto == 1) out.println("<div class='categoria'>Cocineros</div>");
                                    else if (puesto == 2) out.println("<div class='categoria'>Meseros</div>");
                                    else if (puesto == 3) out.println("<div class='categoria'>Supervisores</div>");
                                    puestoActual = puesto;
                                }

                                // Mostrar fila del personal
                                out.println("<div class='fila-personal'>");
                                out.println("<span>" + nombre + "</span>");
                                out.println("<span>" + (estado == 1 ? "trabajando" : "descansando") + "</span>");
                                out.println("<span>" + horario + "</span>");
                                out.println("</div>");
                            }

                        } catch (Exception e) {
                            out.println("<p>Error: " + e.getMessage() + "</p>");
                            e.printStackTrace();
                        } finally {
                            try { if (rs != null) rs.close(); } catch (Exception e) {}
                            try { if (ps != null) ps.close(); } catch (Exception e) {}
                            try { if (con != null) con.close(); } catch (Exception e) {}
                        }
                    %>
                    </div>

                    <div class="contenedor-boton">
                        <form action="administrarPersonal.html">
                            <input type="submit" value="Administrar personal" class="btn-personal">
                        </form>
                    </div>
                </section>
            </main>
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

    <div class="copy">
        © 2026 FoodSync — Todos los derechos reservados
    </div>


</div>
</body>
</html>
