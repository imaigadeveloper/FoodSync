<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%-- IMPORTAMOS CLASE CONEXION --%>
<%@ page import="modelo.Conexion" %> 

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Pedidos - FoodSync</title>
    <link rel="stylesheet" href="Pedidos.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;700&family=Pacifico&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>
<body>

<%
    Connection conn = null;
    
    // Capturar la mesa seleccionada actual
    String mesaSeleccionada = request.getParameter("mesa");
    String errorPlatillo = null;
    
    try {
        // INSTANCIAMOS Y USAMOS CLASE CONEXION
        Conexion conClase = new Conexion();
        conn = conClase.conectar();
        
        // -----------------------------------------------------------------
        // LÓGICA PARA AGREGAR PLATILLO (POST)
        // -----------------------------------------------------------------
        String accion = request.getParameter("accion");
        if (accion != null && accion.equals("agregar") && mesaSeleccionada != null) {
            String nombrePlatillo = request.getParameter("nombre_platillo").trim();
            
            // 1. Buscar si el platillo existe
            PreparedStatement psPlatillo = conn.prepareStatement("SELECT id_platillo, precio FROM Platillos WHERE nombre = ? AND estado = 'Disponible'");
            psPlatillo.setString(1, nombrePlatillo);
            ResultSet rsPlatillo = psPlatillo.executeQuery();
            
            if (rsPlatillo.next()) {
                int idPlatillo = rsPlatillo.getInt("id_platillo");
                
                // 2. Buscar si la mesa ya tiene un pedido activo (no pagado)
                PreparedStatement psPedido = conn.prepareStatement("SELECT id_pedido FROM Pedidos WHERE id_mesa = ? AND estado_pedido != 'Pagado' LIMIT 1");
                psPedido.setInt(1, Integer.parseInt(mesaSeleccionada));
                ResultSet rsPedido = psPedido.executeQuery();
                
                int idPedido = 0;
                if (rsPedido.next()) {
                    idPedido = rsPedido.getInt("id_pedido");
                } else {
                    // Si no tiene pedido activo, se crea uno nuevo (por defecto id_personal temporal 'M001')
                    PreparedStatement psCrearPedido = conn.prepareStatement("INSERT INTO Pedidos (id_mesa, id_personal, estado_pedido) VALUES (?, 'M001', 'Pendiente')", Statement.RETURN_GENERATED_KEYS);
                    psCrearPedido.setInt(1, Integer.parseInt(mesaSeleccionada));
                    psCrearPedido.executeUpdate();
                    ResultSet rsKeys = psCrearPedido.getGeneratedKeys();
                    if(rsKeys.next()){
                        idPedido = rsKeys.getInt(1);
                    }
                    // Actualizar estado de la mesa a Ocupada
                    PreparedStatement psActMesa = conn.prepareStatement("UPDATE Mesas SET estado = 'Ocupada' WHERE id_mesa = ?");
                    psActMesa.setInt(1, Integer.parseInt(mesaSeleccionada));
                    psActMesa.executeUpdate();
                }
                
                // 3. Insertar en el detalle (Cantidad 1 por defecto al escribirlo)
                PreparedStatement psInsertDetalle = conn.prepareStatement("INSERT INTO Detalle_Pedidos (id_pedido, id_platillo, cantidad) VALUES (?, ?, 1)");
                psInsertDetalle.setInt(1, idPedido);
                psInsertDetalle.setInt(2, idPlatillo);
                psInsertDetalle.executeUpdate();
                
            } else {
                errorPlatillo = "¡Error! El platillo '" + nombrePlatillo + "' no existe o no está disponible. Verifícalo bien.";
            }
        } else if (accion != null && accion.equals("cerrar_pedido") && mesaSeleccionada != null) {
            // 1. Cambiamos el estado del pedido a 'Entregado' (listo para caja)
            String sqlCerrar = "UPDATE Pedidos SET estado_pedido = 'Entregado' WHERE id_mesa = ? AND estado_pedido != 'Pagado'";
            PreparedStatement psCerrar = conn.prepareStatement(sqlCerrar);
            psCerrar.setInt(1, Integer.parseInt(mesaSeleccionada));
            psCerrar.executeUpdate();
            psCerrar.close();

            // 2. Cambiamos el estado de la mesa a 'Sucia' o 'Libre' para que se libere en el mapa de mesas
            String sqlLiberarMesa = "UPDATE Mesas SET estado = 'Sucia' WHERE id_mesa = ?";
            PreparedStatement psLib = conn.prepareStatement(sqlLiberarMesa);
            psLib.setInt(1, Integer.parseInt(mesaSeleccionada));
            psLib.executeUpdate();
            psLib.close();

            // Redireccionamos a la misma página limpia (sin mesa seleccionada) para refrescar el menú izquierdo
            response.sendRedirect("Pedidos.jsp");
            return; // Detiene la ejecución del resto del JSP tras redireccionar
        }
%>

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
        <a href="Pedidos.jsp" class="activo">Pedidos</a> <span>|</span>
        <a href="Personal.jsp">Personal</a> <span>|</span>
        <a href="Clientes.jsp">Clientes</a> <span>|</span>
        <a href="Ventas.jsp">Ventas</a> <span>|</span>
        <a href="Cocina.jsp">Cocina</a>
    </div>

    <main class="contenido">
        <section class="panel-principal">

            <div class="Pedidos">
                <h1>Panel de Pedidos</h1>
            </div>

                <div class="mesas-ocupadas">
                <h2>MESAS OCUPADAS</h2>
                <%
                    // Nueva consulta: Buscamos directamente en la tabla Mesas las que estén 'Ocupada'
                    String sqlMesas = "SELECT id_mesa FROM Mesas WHERE estado = 'Ocupada' ORDER BY id_mesa ASC";
                    Statement stmtMesas = conn.createStatement();
                    ResultSet rsMesas = stmtMesas.executeQuery(sqlMesas);
                    boolean hayMesas = false;
                    
                    while(rsMesas.next()) {
                        hayMesas = true;
                        int idMesaM = rsMesas.getInt("id_mesa");
                        
                        // Opcional: Averiguar el estado del pedido de esta mesa si existe
                        String estadoP = "Pendiente"; 
                        PreparedStatement psEstPed = conn.prepareStatement(
                            "SELECT estado_pedido FROM Pedidos WHERE id_mesa = ? AND estado_pedido != 'Pagado' LIMIT 1"
                        );
                        psEstPed.setInt(1, idMesaM);
                        ResultSet rsEstPed = psEstPed.executeQuery();
                        if(rsEstPed.next()) {
                            estadoP = rsEstPed.getString("estado_pedido");
                        }
                        rsEstPed.close();
                        psEstPed.close();
                %>
                        <div class="fila-mesa">
                            <span>Mesa <%= idMesaM %></span>
                            <a href="Pedidos.jsp?mesa=<%= idMesaM %>" class="btn-ver" style="text-decoration:none; text-align:center; display:inline-block; line-height:30px;">Ver pedido</a>
                            <span><%= estadoP %></span>
                        </div>
                <% 
                    } 
                    rsMesas.close();
                    stmtMesas.close();
                    
                    if(!hayMesas) {
                %>
                    <p style="padding: 15px; color: gray;">No hay mesas ocupadas en este momento.</p>
                <% } %>
            </div>

            <div class="pedido-detalle">
                <% if (mesaSeleccionada != null) { %>
                    <h3>Mesa <%= mesaSeleccionada %></h3>
                    
                    <%
                        String sqlDetalle = "SELECT p.nombre, p.precio, dp.cantidad FROM Detalle_Pedidos dp " +
                                            "JOIN Platillos p ON dp.id_platillo = p.id_platillo " +
                                            "JOIN Pedidos pe ON dp.id_pedido = pe.id_pedido " +
                                            "WHERE pe.id_mesa = ? AND pe.estado_pedido != 'Pagado'";
                        PreparedStatement psDet = conn.prepareStatement(sqlDetalle);
                        psDet.setInt(1, Integer.parseInt(mesaSeleccionada));
                        ResultSet rsDet = psDet.executeQuery();
                        
                        double totalCuenta = 0;
                        boolean tieneProductos = false;
                        
                        while(rsDet.next()) {
                            tieneProductos = true;
                            String nombreP = rsDet.getString("nombre");
                            double precioP = rsDet.getDouble("precio");
                            int cant = rsDet.getInt("cantidad");
                            double subtotal = precioP * cant;
                            totalCuenta += subtotal;
                    %>
                            <div class="producto">
                                <span><%= nombreP %> (x<%= cant %>)</span>
                                <span>$<%= subtotal %></span>
                            </div>
                    <% 
                        } 
                        if(!tieneProductos) { 
                    %>
                            <p style="color:gray; font-style:italic;">La mesa está asignada pero aún no tiene platillos.</p>
                    <% } %>

                    <div class="producto total">
                        <span>Total</span>
                        <span>$<%= totalCuenta %></span>
                    </div>
                    <div class="producto total">
                        <span>Total</span>
                        <span>$<%= totalCuenta %></span>
                    </div>

                    <% if (tieneProductos) { %>
                        <form action="Pedidos.jsp?mesa=<%= mesaSeleccionada %>" method="POST" style="margin: 15px 0;">
                            <input type="hidden" name="accion" value="cerrar_pedido">
                            <button type="submit" class="btn-confirmar" style="background-color: #d9534f; width: 100%; font-weight: bold;">
                                <i class="fa-solid fa-file-invoice-dollar"></i> Cerrar Cuenta / Enviar a Ventas
                            </button>
                        </form>
                    <% } %>

                    <form action="Pedidos.jsp?mesa=<%= mesaSeleccionada %>" method="POST" class="agregar-platillo">
                    <form action="Pedidos.jsp?mesa=<%= mesaSeleccionada %>" method="POST" class="agregar-platillo">
                        <input type="hidden" name="accion" value="agregar">
                        <div>
                            <label><strong>Agregar</strong></label>
                            <br>
                            <label>Nombre platillo:</label>
                        </div>
                        <input type="text" name="nombre_platillo" required placeholder="Ej. Enchiladas Suizas">
                        <input type="submit" value="Confirmar pedido" class="btn-confirmar">
                    </form>

                <% } else { %>
                    <div style="text-align: center; padding-top: 40px; color: #777;">
                        <i class="fa-solid fa-arrow-left" style="font-size: 2rem; margin-bottom: 10px;"></i>
                        <h3>Selecciona una mesa ocupada de la izquierda para ver su pre-cuenta o añadirle platillos.</h3>
                    </div>
                <% } %>
            </div>

            <div class="pedido-vacio">
                <h3>Mesero</h3>
                <p style="font-size: 1rem; color: #333; padding: 5px 15px; font-weight: 500;">
                    <i class="fa-solid fa-user-tie"></i> M001 - Mesero General
                </p>
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

<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Cerramos la conexión de forma segura
        if (conn != null) conn.close();
    }
%>

<% if (errorPlatillo != null) { %>
    <script>
        alert("<%= errorPlatillo %>");
    </script>
<% } %>

</body>
</html>