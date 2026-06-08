<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="modelo.Conexion" %> 

<%
    String mensajeAlerta = null;
    Connection conn = null;

    // PROCESAR ACTUALIZACIÓN CUANDO LE DAN CLIC A CONFIRMAR (POST)
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String tokenClave = request.getParameter("clave");
        String[] idsPedidos = request.getParameterValues("id_pedido");
        
        try {
            Conexion conClase = new Conexion();
            conn = conClase.conectar();
            
            // Validar la clave de permiso del cocinero/personal
            PreparedStatement psToken = conn.prepareStatement("SELECT id_personal FROM Personal WHERE password_token = ? LIMIT 1");
            psToken.setString(1, tokenClave);
            ResultSet rsToken = psToken.executeQuery();
            
            if (rsToken.next()) {
                // Token correcto -> Actualizamos cada pedido enviado
                if (idsPedidos != null) {
                    for (String idPedStr : idsPedidos) {
                        String nuevoEstado = request.getParameter("estado_" + idPedStr);
                        
                        if (nuevoEstado != null) {
                            PreparedStatement psActualizar = conn.prepareStatement(
                                "UPDATE Pedidos SET estado_pedido = ? WHERE id_pedido = ?"
                            );
                            psActualizar.setString(1, nuevoEstado);
                            psActualizar.setInt(2, Integer.parseInt(idPedStr));
                            psActualizar.executeUpdate();
                            psActualizar.close();
                        }
                    }
                    mensajeAlerta = "¡Estados actualizados correctamente en cocina y pedidos!";
                }
            } else {
                mensajeAlerta = "¡Clave de permiso incorrecta! No se realizaron cambios.";
            }
            rsToken.close();
            psToken.close();
            
        } catch (Exception e) {
            e.printStackTrace();
            mensajeAlerta = "Error en la base de datos: " + e.getMessage();
        } finally {
            if (conn != null) conn.close();
        }
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Actualizar Estado - FoodSync</title>
    <link rel="stylesheet" href="ActualizarEstado.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;700&family=Pacifico&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <script>
        function mostrarPassword(){
            let input = document.getElementById("clave");
            if(input.type === "password"){
                input.type = "text";
            }else{
                input.type = "password";
            }
        }
    </script>
</head>

<body>

<div class="contenedor-sitio">

    <nav class="navbar-top">
        <div class="logo-box">
            <img src="imagen/Logo.png" alt="FoodSync" class="nav-logo">
        </div>
    </nav>

    <div class="menu-nav">
        <a href="Inicio.html">Inicio</a> <span>|</span>
        <a href="Platillos.jsp">Platillos</a> <span>|</span>
        <a href="Mesas.jsp">Mesas</a> <span>|</span>
        <a href="Reservaciones.jsp">Reservaciones</a> <span>|</span>
        <a href="Pedidos.jsp">Pedidos</a> <span>|</span>
        <a href="Personal.jsp">Personal</a> <span>|</span>
        <a href="Clientes.jsp">Clientes</a> <span>|</span>
        <a href="Ventas.jsp">Ventas</a> <span>|</span>
        <a href="Cocina.jsp" class="activo">Cocina</a>
    </div>

    <main class="contenido">
        <section class="panel-principal">

            <div class="titulo-estado">
                <h2>Cambiar estado de pedido</h2>
            </div>

            <form action="ActualizarEstado.jsp" method="POST">

                <div class="lista-estados">
                <%
                    try {
                        Conexion conClase = new Conexion();
                        conn = conClase.conectar();
                        
                        // Trae solo los pedidos que el cocinero está trabajando (No los 'Entregados' ni 'Pagados')
                        String sql = "SELECT id_pedido, id_mesa, estado_pedido FROM Pedidos " +
                                     "WHERE estado_pedido IN ('Pendiente', 'En cocina', 'Listo') " +
                                     "ORDER BY id_mesa ASC";
                        Statement stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery(sql);
                        
                        boolean hayPedidos = false;
                        while(rs.next()) {
                            hayPedidos = true;
                            int idPedido = rs.getInt("id_pedido");
                            int idMesa = rs.getInt("id_mesa");
                            String estActual = rs.getString("estado_pedido");
                %>
                            <div class="fila-estado">
                                <span class="mesa">Mesa <%= idMesa %></span>
                                
                                <input type="hidden" name="id_pedido" value="<%= idPedido %>">
                                
                                <select name="estado_<%= idPedido %>">
                                    <option value="Pendiente" <%= estActual.equals("Pendiente") ? "selected" : "" %>>Pendiente</option>
                                    <option value="En cocina" <%= estActual.equals("En cocina") ? "selected" : "" %>>En preparación</option>
                                    <option value="Listo" <%= estActual.equals("Listo") ? "selected" : "" %>>Listo</option>
                                </select>
                            </div>
                <%
                        }
                        rs.close();
                        stmt.close();
                        
                        if(!hayPedidos) {
                %>
                            <p style="padding:20px; color:gray; text-align:center; font-style:italic;">No hay pedidos activos para modificar en este momento.</p>
                <%
                        }
                    } catch(Exception e) {
                        e.printStackTrace();
                    } finally {
                        if(conn != null) conn.close();
                    }
                %>
                </div>

                <div class="confirmacion">
                    <label>
                        Confirmar actualización <br> con clave de permiso
                    </label>

                    <div class="input-password">
                        <input type="password" id="clave" name="clave" required>
                        <i class="fa-solid fa-eye" onclick="mostrarPassword()"></i>
                    </div>

                    <button type="submit" class="btn-confirmar" style="border:none; cursor:pointer;">
                        Confirmar
                    </button>
                </div>

            </form>

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

<%-- Script de alertas JS para avisar al usuario si se guardó --%>
<% if (mensajeAlerta != null) { %>
    <script>
        alert("<%= mensajeAlerta %>");
        <% if(mensajeAlerta.contains("correctamente")) { %>
            window.location.href = "Cocina.jsp";
        <% } %>
    </script>
<% } %>

</body>
</html>