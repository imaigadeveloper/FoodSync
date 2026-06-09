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

    // Restringimos el acceso a las ventas únicamente al rol de Supervisor
    if (usuario == null || rol == null || !rol.equals("Supervisor")) {
%>
    <script>
        alert("Acceso denegado. Debes iniciar sesión como Supervisor para ver el panel de ventas.");
        window.location.href = "Sesion.jsp";
    </script>
<%
        return; // Detiene por completo la carga del resto de la página
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Ventas - FoodSync</title>
    <link rel="stylesheet" href="Ventas.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght=300;400;500;700&family=Pacifico&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>
<body>
<div class="contenedor-sitio">

    <%-- INCLUSIÓN DEL NAVBAR DINÁMICO --%>
    <%@include file="navbar.jsp" %>

    <main class="contenido">
        <section class="panel-principal">
            <div class="encabezado-ventas">
                <h1>Ventas</h1>
                <a href="NuevaVenta.jsp" class="btn-nueva">Nueva venta +</a>
            </div>

            <% 
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;
                try {
                    Conexion conClase = new Conexion();
                    conn = conClase.conectar();
                    
                    // Consultamos las ventas de la base de datos
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery("SELECT * FROM Ventas ORDER BY id_venta DESC");
                    
                    boolean hayVentas = false;
                    while(rs.next()){
                        hayVentas = true;
            %>
            <div class="card-venta">
                <div>
                    <h2>Venta #<%=rs.getInt("id_venta")%></h2>
                    <p>Pedido: #<%=rs.getInt("id_pedido")%> | Método: <%=rs.getString("metodo_pago")%></p>
                </div>
                <div class="monto">$<%=rs.getDouble("total")%></div>
            </div>
            <% 
                    } 
                    
                    if(!hayVentas) {
            %>
                <p style="padding: 20px; color: gray; text-align: center; font-style: italic;">No se han registrado ventas el día de hoy.</p>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<p style='color:red;'>Error al cargar el historial de ventas: " + e.getMessage() + "</p>");
                } finally {
                    // Cierre seguro de recursos de base de datos
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                }
            %>
            
            <h3 class="titulo-anterior">Anterior</h3>
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
    <div class="copy">© 2026 FoodSync — Todos los derechos reservados</div>
</div>
</body>
</html>