<%@page import="java.sql.*"%>
<%@page import="modelo.Conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // 1. Recibir los parámetros del formulario de Mesas.jsp
    String idMesaStr = request.getParameter("id_mesa");
    String fechaReserva = request.getParameter("fecha_reserva");
    String horaReserva = request.getParameter("hora_reserva");
    String usuarioCliente = request.getParameter("usuario_cliente");

    Connection con = null;
    PreparedStatement psBuscarCliente = null;
    PreparedStatement psInsertarReserva = null;
    PreparedStatement psActualizarMesa = null;
    ResultSet rsCliente = null;

    try {
        Conexion conexion = new Conexion();
        con = conexion.conectar();
        
        // Iniciar transacción para asegurar consistencia en ambas tablas
        con.setAutoCommit(false);

        // 2. Buscar al cliente por su nombre de usuario en la BD
        psBuscarCliente = con.prepareStatement("SELECT id_cliente FROM Clientes WHERE usuario = ?");
        psBuscarCliente.setString(1, usuarioCliente);
        rsCliente = psBuscarCliente.executeQuery();

        if (rsCliente.next()) {
            int idCliente = rsCliente.getInt("id_cliente");
            int idMesa = Integer.parseInt(idMesaStr);

            // 3. Insertar la nueva fila en la tabla Reservaciones
            String sqlReserva = "INSERT INTO Reservaciones (id_mesa, id_cliente, fecha_reserva, hora_reserva, estado_reserva) VALUES (?, ?, ?, ?, 'Pendiente')";
            psInsertarReserva = con.prepareStatement(sqlReserva);
            psInsertarReserva.setInt(1, idMesa);
            psInsertarReserva.setInt(2, idCliente);
            psInsertarReserva.setString(3, fechaReserva);
            // El formato input time 'HH:mm' es compatible con el tipo TIME de MySQL
            psInsertarReserva.setString(4, horaReserva); 
            psInsertarReserva.executeUpdate();

            // 4. Actualizar el estado de la mesa en la tabla Mesas a 'Reservada'
            String sqlMesa = "UPDATE Mesas SET estado = 'Reservada' WHERE id_mesa = ?";
            psActualizarMesa = con.prepareStatement(sqlMesa);
            psActualizarMesa.setInt(1, idMesa);
            psActualizarMesa.executeUpdate();

            // Confirmar cambios en la base de datos
            con.commit();
%>
            <script>
                alert("¡Reservación guardada con éxito!");
                window.location.href = "Mesas.jsp";
            </script>
<%
        } else {
            // Si el nombre de usuario escrito no existe en la tabla Clientes
%>
            <script>
                alert("Error: El usuario '" + "<%=usuarioCliente%>" + "' no está registrado en el sistema.");
                window.history.back();
            </script>
<%
        }
    } catch (Exception e) {
        if (con != null) {
            try { con.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
        }
%>
        <script>
            alert("Ocurrió un error inesperado de BD: <%= e.getMessage().replace("\"", "'") %>");
            window.history.back();
        </script>
<%
    } finally {
        if (rsCliente != null) rsCliente.close();
        if (psBuscarCliente != null) psBuscarCliente.close();
        if (psInsertarReserva != null) psInsertarReserva.close();
        if (psActualizarMesa != null) psActualizarMesa.close();
        if (con != null) con.close();
    }
%>