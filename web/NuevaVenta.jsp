<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, modelo.Conexion" %>
<%
    Connection conn = new Conexion().conectar();
    String idPedidoSel = request.getParameter("id_pedido");
    double totalCuenta = 0.0;
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Nueva Venta - FoodSync</title>
    <link rel="stylesheet" href="NuevaVenta.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;700&family=Pacifico&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>
<body>
<div class="contenedor-sitio">
    <nav class="navbar-top"><img src="imagen/Logo.png" class="nav-logo"></nav>
    <div class="menu-nav">
        <a href="Inicio.jsp">Inicio</a> | <a href="Platillos.jsp">Platillos</a> | <a href="Mesas.jsp">Mesas</a> | <a href="Reservaciones.jsp">Reservaciones</a> | <a href="Pedidos.jsp">Pedidos</a> | <a href="Personal.jsp">Personal</a> | <a href="Clientes.jsp">Clientes</a> | <a href="Ventas.jsp">Ventas</a> | <a href="Cocina.jsp">Cocina</a>
    </div>

    <main class="contenido">
        <section class="panel-principal">
            <h1>Nueva venta</h1>
            
            <form action="NuevaVenta.jsp" method="GET" class="ventas-grid">
                <div class="lado-izquierdo">
                    <select name="id_pedido" id="selectPedido" onchange="this.form.submit()" class="select-mesa">
                        <option value="">Seleccionar mesa ↓</option>
                        <% 
                            ResultSet rsPed = conn.createStatement().executeQuery("SELECT p.id_pedido, p.id_mesa FROM Pedidos p WHERE p.estado_pedido = 'Entregado'");
                            while(rsPed.next()){
                        %>
                        <option value="<%=rsPed.getInt("id_pedido")%>" <%= (idPedidoSel != null && idPedidoSel.equals(rsPed.getString("id_pedido"))) ? "selected" : "" %>>
                            Mesa <%=rsPed.getInt("id_mesa")%> - Pedido #<%=rsPed.getInt("id_pedido")%>
                        </option>
                        <% } %>
                    </select>

                    <div class="cuenta">
                        <h2>Cuenta</h2>
                        <% if(idPedidoSel != null && !idPedidoSel.isEmpty()){
                            PreparedStatement ps = conn.prepareStatement("SELECT p.nombre, p.precio, dp.cantidad FROM Detalle_Pedidos dp JOIN Platillos p ON dp.id_platillo = p.id_platillo WHERE dp.id_pedido = ?");
                            ps.setInt(1, Integer.parseInt(idPedidoSel));
                            ResultSet rs = ps.executeQuery();
                            while(rs.next()){
                                double subtotal = rs.getDouble("precio") * rs.getInt("cantidad");
                                totalCuenta += subtotal;
                        %>
                        <div class="producto"><span><%=rs.getString("nombre")%> (x<%=rs.getInt("cantidad")%>)</span> <span>$<%=subtotal%></span></div>
                        <% } } else { %>
                            <div class="producto" style="color: #888; justify-content: center;"><span>Por favor, selecciona una mesa arriba para ver la cuenta.</span></div>
                        <% } %>
                        <div class="total"><span>Total</span> <span>$<%=totalCuenta%></span></div>
                    </div>
                </div>

                <div class="lado-derecho">
                    <div class="metodo-pago">
                        <h3>Método de pago:</h3>
                        <label>Efectivo <input type="radio" name="metodo" value="Efectivo" checked></label>
                        <label>Tarjeta <input type="radio" name="metodo" value="Tarjeta"></label>
                        <label>Transferencia <input type="radio" name="metodo" value="Transferencia"></label>
                    </div>
                    
                    <button type="button" class="btn-accion" onclick="procesarPago()">Registrar pago</button>
                    <button type="button" class="btn-accion" style="background:#b6b284;" onclick="imprimirTicket()">Crear ticket</button>
                </div>
            </form>

            <%-- Formulario Oculto para procesar el pago real --%>
            <form id="formPago" action="ProcesarVenta.jsp" method="POST" style="display:none;">
                <input type="hidden" name="id_p" id="hiddenIdPedido" value="<%= (idPedidoSel != null) ? idPedidoSel : "" %>">
                <input type="hidden" name="total_final" value="<%=totalCuenta%>">
                <input type="hidden" name="metodo" id="hiddenMetodo" value="Efectivo">
            </form>
        </section>
    </main>

    <footer class="pie-morado">
        <div class="footer-box"><h4>Horario</h4><p>Lunes - Domingo</p><p>8:00 AM - 11:00 PM</p></div>
        <div class="footer-box"><h4>Ubicación</h4><p>Av. FoodSync #128</p><p>Ciudad de México</p></div>
        <div class="footer-box"><h4>Síguenos</h4>
            <div class="iconos"><i class="fa-brands fa-facebook-f"></i><i class="fa-brands fa-instagram"></i><i class="fa-brands fa-x-twitter"></i><i class="fa-brands fa-youtube"></i></div>
        </div>
    </footer>
    <div class="copy">© 2026 FoodSync — Todos los derechos reservados</div>
</div>

<script>
function procesarPago() {
    var idPedido = document.getElementById('selectPedido').value;
    
    // VALIDACIÓN: Si no hay pedido seleccionado
    if (!idPedido) {
        alert("¡Hey! Por favor, selecciona una mesa antes de registrar el pago.");
        return;
    }
    
    // Obtener el método de pago seleccionado en los radio buttons
    var metodoSeleccionado = document.querySelector('input[name="metodo"]:checked').value;
    
    // Asignar los valores al formulario oculto
    document.getElementById('hiddenIdPedido').value = idPedido;
    document.getElementById('hiddenMetodo').value = metodoSeleccionado;
    
    // Enviar formulario
    document.getElementById('formPago').submit();
}

function imprimirTicket() {
    var idPedido = document.getElementById('selectPedido').value;
    if (!idPedido) {
        alert("No hay ninguna cuenta seleccionada para imprimir el ticket.");
        return;
    }
    window.print();
}
</script>

<% if(conn != null) { conn.close(); } %>
</body>
</html>