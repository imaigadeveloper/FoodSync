<%@ page import="java.sql.*, modelo.Conexion" %>
<%
    String idPed = request.getParameter("id_p");
    String total = request.getParameter("total_final");
    String metodo = request.getParameter("metodo");

    if(idPed != null && !idPed.equals("0")){
        Connection conn = new Conexion().conectar();
        PreparedStatement ps = conn.prepareStatement("INSERT INTO Ventas (id_pedido, total, metodo_pago) VALUES (?, ?, ?)");
        ps.setInt(1, Integer.parseInt(idPed));
        ps.setDouble(2, Double.parseDouble(total));
        ps.setString(3, metodo);
        ps.executeUpdate();
        
        conn.createStatement().executeUpdate("UPDATE Pedidos SET estado_pedido = 'Pagado' WHERE id_pedido = " + idPed);
        conn.close();
    }
    response.sendRedirect("Ventas.jsp");
%>