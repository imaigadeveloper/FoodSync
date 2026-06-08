<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, modelo.Conexion" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Ventas - FoodSync</title>
    <link rel="stylesheet" href="Ventas.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;700&family=Pacifico&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>
<body>
<div class="contenedor-sitio">
    <nav class="navbar-top"><img src="imagen/Logo.png" class="nav-logo"></nav>
    <div class="menu-nav">
        <a href="Inicio.jsp">Inicio</a> | <a href="Platillos.jsp">Platillos</a> | <a href="Mesas.jsp">Mesas</a> | <a href="Reservaciones.jsp">Reservaciones</a> | <a href="Pedidos.jsp">Pedidos</a> | <a href="Personal.jsp">Personal</a> | <a href="Clientes.jsp">Clientes</a> | <a href="Ventas.jsp" class="activo">Ventas</a> | <a href="Cocina.jsp">Cocina</a>
    </div>

    <main class="contenido">
        <section class="panel-principal">
            <div class="encabezado-ventas">
                <h1>Ventas</h1>
                <a href="NuevaVenta.jsp" class="btn-nueva">Nueva venta +</a>
            </div>

            <% 
                Connection conn = new Conexion().conectar();
                // Consultamos las ventas
                ResultSet rs = conn.createStatement().executeQuery("SELECT * FROM Ventas ORDER BY id_venta DESC");
                while(rs.next()){
            %>
            <div class="card-venta">
                <div>
                    <h2>Venta #<%=rs.getInt("id_venta")%></h2>
                    <p>Pedido: #<%=rs.getInt("id_pedido")%> | Método: <%=rs.getString("metodo_pago")%></p>
                </div>
                <div class="monto">$<%=rs.getDouble("total")%></div>
            </div>
            <% } conn.close(); %>
            
            <h3 class="titulo-anterior">Anterior</h3>
            </section>
    </main>

    <footer class="pie-morado">
        <div class="footer-box"><h4>Horario</h4><p>Lunes - Domingo</p><p>8:00 AM - 11:00 PM</p></div>
        <div class="footer-box"><h4>Ubicación</h4><p>Av. FoodSync #128</p><p>Ciudad de México</p></div>
        <div class="footer-box"><h4>Síguenos</h4>
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