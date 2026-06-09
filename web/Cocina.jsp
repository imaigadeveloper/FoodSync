<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%-- IMPORTAMOS CLASE CONEXION --%>
<%@ page import="modelo.Conexion" %> 

<%
    // -----------------------------------------------------------------
    // VALIDACIÓN DE SEGURIDAD 
    // -----------------------------------------------------------------
    String usuario = (String) session.getAttribute("usuario");
    String rol = (String) session.getAttribute("rol");

    // Permitimos el acceso únicamente a los Cocineros y al Supervisor
    if (usuario == null || rol == null || (!rol.equals("Cocinero") && !rol.equals("Supervisor"))) {
%>
    <script>
        alert("Acceso denegado. Debes iniciar sesión con un rol autorizado para el área de cocina.");
        window.location.href = "Sesion.jsp";
    </script>
<%
        return; // Detiene por completo la ejecución de la página
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Cocina - FoodSync</title>
    <link rel="stylesheet" href="Cocina.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght=300;400;500;700&family=Pacifico&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>
<body>

<div class="contenedor-sitio">

    <%-- INCLUSIÓN DEL NAVBAR DINÁMICO --%>
    <%@include file="navbar.jsp" %>

    <main class="contenido">
        <section class="panel-principal">

            <div class="encabezado-cocina">
                <h1>Cocina</h1>
                <a href="ActualizarEstado.jsp" class="btn-actualizar">Actualizar Estados</a>
            </div>

            <%
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;
                try {
                    Conexion conClase = new Conexion();
                    conn = conClase.conectar();
                    
                    // Consultamos los pedidos activos que deben verse en cocina ordenados por antigüedad
                    String sql = "SELECT id_pedido, id_mesa, estado_pedido FROM Pedidos " +
                                 "WHERE estado_pedido IN ('Pendiente', 'En cocina', 'Listo') " +
                                 "ORDER BY id_pedido ASC"; // O por columna de fecha/tiempo si cuentas con ella
                                 
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery(sql);
                    
                    boolean hayPedidos = false;
                    while(rs.next()) {
                        hayPedidos = true;
                        int idPedido = rs.getInt("id_pedido");
                        int idMesa = rs.getInt("id_mesa");
                        String estado = rs.getString("estado_pedido");
                        
                        // Clase CSS dinámica según el estado
                        String claseEstado = "pendiente";
                        if(estado.equals("En cocina")) { 
                            claseEstado = "preparacion"; 
                        } else if(estado.equals("Listo")) { 
                            claseEstado = "listo";
                        }
            %>
                        <div class="pedido-card">
                            <div class="pedido-info">
                                <h2>Mesa <%= idMesa %></h2>
                                <p class="<%= claseEstado %>"><%= estado %></p>
                            </div>
                            <a href="DetallePedidoCocina.jsp?mesa=<%= idMesa %>" class="btn-ver" style="text-decoration: none; text-align: center; display: inline-block; line-height: 40px;">
                                Ver pedido
                            </a>
                        </div>
         
            <%
                    }
                    
                    if(!hayPedidos) {
            %>
                        <p style="text-align:center; color:gray; padding:20px; font-style: italic;">
                            No hay pedidos pendientes en la cocina. ¡Buen trabajo!
                        </p>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<p style='color:red;'>Error al cargar los pedidos de cocina: " + e.getMessage() + "</p>");
                } finally {
                    // Cierre explícito y ordenado de todos los recursos
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                }
            %>

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