<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="modelo.Conexion" %> 

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Detalle del Pedido - Cocina</title>
    <link rel="stylesheet" href="Pedidos.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght=300;400;500;700&family=Pacifico&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>
<body>

<%
    String mesaSeleccionada = request.getParameter("mesa");
    Connection conn = null;
%>

<div class="contenedor-sitio">

    <nav class="navbar-top">
        <div class="logo-box">
            <img src="imagen/Logo.png" alt="FoodSync" class="nav-logo">
        </div>
    </nav>

    <div class="menu-nav">
        <a href="Cocina.jsp" class="activo">← Regresar a Cocina</a>
    </div>

    <main class="contenido">
        <section class="panel-principal" style="justify-content: center;">
            
            <div class="pedido-detalle" style="width: 100%; max-width: 600px; margin: 0 auto;">
                <% if (mesaSeleccionada != null) { %>
                    <h2>Comanda de la Mesa <%= mesaSeleccionada %></h2>
                    <hr style="border: 1px dashed #ccc; margin-bottom: 20px;">
                    
                    <%
                    try {
                        Conexion conClase = new Conexion();
                        conn = conClase.conectar();
                        
                        // Consulta exacta para traer los platillos de la mesa que estén pendientes/activos
                        String sqlDetalle = "SELECT p.nombre, dp.cantidad, dp.notas_chef, pe.estado_pedido " +
                                            "FROM Detalle_Pedidos dp " +
                                            "JOIN Platillos p ON dp.id_platillo = p.id_platillo " +
                                            "JOIN Pedidos pe ON dp.id_pedido = pe.id_pedido " +
                                            "WHERE pe.id_mesa = ? AND pe.estado_pedido IN ('Pendiente', 'En cocina', 'Listo')";
                        
                        PreparedStatement psDet = conn.prepareStatement(sqlDetalle);
                        psDet.setInt(1, Integer.parseInt(mesaSeleccionada));
                        ResultSet rsDet = psDet.executeQuery();
                        
                        boolean tieneProductos = false;
                        String estadoPedido = "";
                        
                        while(rsDet.next()) {
                            tieneProductos = true;
                            String nombreP = rsDet.getString("nombre");
                            int cant = rsDet.getInt("cantidad");
                            String notas = rsDet.getString("notas_chef");
                            estadoPedido = rsDet.getString("estado_pedido");
                    %>
                            <div class="producto" style="padding: 12px 0; border-bottom: 1px solid #eee;">
                                <div style="font-size: 1.2rem;">
                                    <strong style="color: #333;"><%= nombreP %></strong> 
                                    <span style="background: #6f42c1; color: #fff; padding: 2px 8px; border-radius: 4px; font-size: 0.9rem; margin-left: 10px;">
                                        x<%= cant %>
                                    </span>
                                    <% if(notas != null && !notas.isEmpty()) { %>
                                        <br>
                                        <small style="color: #d9534f; font-style: italic; font-weight: 500;">
                                            <i class="fa-solid fa-bell"></i> Nota: <%= notas %>
                                        </small>
                                    <% } %>
                                </div>
                            </div>
                    <% 
                        } 
                        rsDet.close();
                        psDet.close();

                        if(tieneProductos) { 
                    %>
                            <div style="margin-top: 25px; background: #f8f9fa; padding: 15px; border-radius: 8px; text-align: center;">
                                <p style="font-size: 1.1rem; margin: 0;">
                                    Estado actual en cocina: 
                                    <strong style="color: #6f42c1; text-transform: uppercase;"><%= estadoPedido %></strong>
                                </p>
                            </div>
                    <% 
                        } else { 
                    %>
                            <p style="color:gray; font-style:italic; text-align:center;">Esta mesa no tiene platillos asignados en este momento.</p>
                    <% 
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (conn != null) conn.close();
                    }
                    %>
                    
                <% } else { %>
                    <p style="text-align:center; color:red;">No se ha seleccionado ninguna mesa.</p>
                <% } %>
            </div>

        </section>
    </main>

    <div class="copy">
        © 2026 FoodSync — Todos los derechos reservados
    </div>

</div>

</body>
</html>