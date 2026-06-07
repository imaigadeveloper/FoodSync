<%@page import="java.sql.*"%>
<%@page import="modelo.Conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
String agregarMesa = request.getParameter("agregarMesa");

if(agregarMesa != null){

    
    try{

        Conexion conexion = new Conexion();
        Connection con = conexion.conectar();

        PreparedStatement verificar =
        con.prepareStatement(
        "SELECT * FROM Mesas WHERE id_mesa=?");

        verificar.setInt(
        1,
        Integer.parseInt(agregarMesa));

        ResultSet existe =
        verificar.executeQuery();

        if(!existe.next()){

            PreparedStatement insertar =
            con.prepareStatement(
            "INSERT INTO Mesas(id_mesa) VALUES(?)");

            insertar.setInt(
            1,
            Integer.parseInt(agregarMesa));

            insertar.executeUpdate();

            insertar.close();
        }

        existe.close();
        verificar.close();
        con.close();

        response.sendRedirect(
        "configurarMesas.jsp");

        return;

    }catch(Exception e){
        out.println(e);
    }

}

String eliminarMesa =
request.getParameter("eliminarMesa");

if(eliminarMesa != null){

    try{

        Conexion conexion =
        new Conexion();

        Connection con =
        conexion.conectar();

        PreparedStatement eliminar =
        con.prepareStatement(
        "DELETE FROM Mesas WHERE id_mesa=?");

        eliminar.setInt(
        1,
        Integer.parseInt(eliminarMesa));

        eliminar.executeUpdate();

        eliminar.close();
        con.close();

        response.sendRedirect(
        "configurarMesas.jsp");

        return;

    }catch(Exception e){
        out.println(e);
    }

}
%>

        <%
        String idMesa = request.getParameter("idMesa");
        String estado = request.getParameter("estado");

        if(idMesa != null && estado != null){

            Connection con = null;
            PreparedStatement psMesa = null;
            PreparedStatement psReserva = null;

            try {
                Conexion conexion = new Conexion();
                con = conexion.conectar();

                // Desactivamos el autoCommit para manejarlo como una sola transacción segura
                con.setAutoCommit(false);

                // 1. Actualizar el estado de la mesa (Tu consulta original)
                psMesa = con.prepareStatement(
                    "UPDATE Mesas SET estado=? WHERE id_mesa=?"
                );
                psMesa.setString(1, estado);
                psMesa.setInt(2, Integer.parseInt(idMesa));
                psMesa.executeUpdate();

                // 2. NUEVA LÓGICA: Si la mesa se pone "Ocupada", actualizamos su reservación pendiente de hoy
                if(estado.equals("Ocupada")){
                    String sqlReserva = "UPDATE Reservaciones "
                                      + "SET estado_reserva='Asistió' "
                                      + "WHERE id_mesa=? "
                                      + "AND estado_reserva='Pendiente' "
                                      + "AND fecha_reserva=CURDATE()";

                    psReserva = con.prepareStatement(sqlReserva);
                    psReserva.setInt(1, Integer.parseInt(idMesa));
                    psReserva.executeUpdate();
                }

                // Si ambas consultas se ejecutan bien, guardamos los cambios definitivamente
                con.commit();

            } catch(Exception e) {
                if(con != null) {
                    try { con.rollback(); } catch(SQLException ex) { ex.printStackTrace(); }
                }
                out.println("Error al actualizar estados: " + e.getMessage());
            } finally {
                if(psMesa != null) psMesa.close();
                if(psReserva != null) psReserva.close();
                if(con != null) con.close();
            }

            response.sendRedirect("configurarMesas.jsp");
            return;
        }
        %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Configurar Mesas</title>

    <link rel="stylesheet" href="Mesass.css">

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;700&family=Pacifico&display=swap" rel="stylesheet">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<script>

function cambiarEstado(idMesa){

    let estado = prompt(
        "Selecciona el estado:\n\n" +
        "Libre\n" +
        "Ocupada\n" +
        "Sucia\n" +
        "Reservada"
    );

    if(estado == null){
        return;
    }

    estado = estado.trim().toLowerCase();

    if(estado === "libre"){
        estado = "Libre";
    }
    else if(estado === "ocupada"){
        estado = "Ocupada";
    }
    else if(estado === "sucia"){
        estado = "Sucia";
    }
    else if(estado === "reservada"){
        estado = "Reservada";
    }
    else{

        alert("Estado inválido.");

        cambiarEstado(idMesa);

        return;
    }

    window.location =
        "configurarMesas.jsp?idMesa=" +
        idMesa +
        "&estado=" +
        estado;

}

</script>

</head>

<body>

<div class="contenedor-sitio">

    <!-- NAVBAR -->
    <nav class="navbar-top">

        <div class="logo-box">
            <img src="imagen/Logo.png"
                 alt="FoodSync"
                 class="nav-logo">
        </div>

    </nav>

    <!-- MENU -->
    <div class="menu-nav">

        <a href="Inicio.jsp">Inicio</a>
        <span>|</span>

        <a href="Platillos.jsp">Platillos</a>
        <span>|</span>

        <a href="Mesas.jsp">Mesas</a>
        <span>|</span>

        <a href="Reservaciones.jsp">Reservaciones</a>
        <span>|</span>

        <a href="Pedidos.jsp">Pedidos</a>
        <span>|</span>

        <a href="Personal.jsp">Personal</a>
        <span>|</span>

        <a href="Clientes.jsp">Clientes</a>
        <span>|</span>

        <a href="Ventas.jsp">Ventas</a>
        <span>|</span>

        <a href="Cocina.html">Cocina</a>

    </div>

    <!-- CONTENIDO -->
    <main class="contenido">

        <section class="panel-principal">

            <div class="Mesas">

                <h1>
                    Configurar Mesas
                </h1>

            </div>

            <!-- MAPA -->
            <div class="mapa-container">
<div style="margin-bottom:20px;">

    <form method="get"
          style="display:inline-block;">

        <input type="number"
               name="agregarMesa"
               placeholder="Número de mesa"
               required>

        <button type="submit">
            Agregar Mesa
        </button>

    </form>

</div>
                <h2>
                    MAPA DE MESAS
                </h2>

                <!-- LEYENDA -->
                <div class="leyenda">

                    <div class="estado">
                        <span class="circulo libre"></span>
                        Libre
                    </div>

                    <div class="estado">
                        <span class="circulo ocupada"></span>
                        Ocupada
                    </div>

                    <div class="estado">
                        <span class="circulo sucia"></span>
                        Sucia
                    </div>

                    <div class="estado">
                        <span class="circulo reservada"></span>
                        Reservada
                    </div>

                </div>

                <!-- MESAS -->
                <div class="mapa-mesas">

                <%

                Conexion conexion = new Conexion();
                Connection con = conexion.conectar();

                PreparedStatement ps = con.prepareStatement(
                    "SELECT * FROM Mesas ORDER BY id_mesa"
                );

                ResultSet rs = ps.executeQuery();

                while(rs.next()){

                    int mesa = rs.getInt("id_mesa");

                    String estadoMesa =
                        rs.getString("estado");

                    String clase = "";

                    if(estadoMesa.equals("Libre")){
                        clase = "libre-mesa";
                    }
                    else if(estadoMesa.equals("Ocupada")){
                        clase = "ocupada-mesa";
                    }
                    else if(estadoMesa.equals("Sucia")){
                        clase = "sucia-mesa";
                    }
                    else if(estadoMesa.equals("Reservada")){
                        clase = "reservada-mesa";
                    }

                %>

                    <div class="mesa <%=clase%>"
                        style="position:relative;">

                        <span
                            onclick="cambiarEstado(<%=mesa%>)"
                            style="cursor:pointer;">

                            <%=mesa%>

                        </span>

                        <a href="configurarMesas.jsp?eliminarMesa=<%=mesa%>"
                           onclick="return confirm('¿Eliminar mesa <%=mesa%>?')"
                           style="
                               position:absolute;
                               top:-8px;
                               right:-8px;
                               color:red;
                               text-decoration:none;
                               font-weight:bold;
                           ">

                           ×

                        </a>

                    </div>

                <%
                }

                rs.close();
                ps.close();
                con.close();
                %>

                </div>

            </div>

        </section>

    </main>

    <!-- FOOTER -->
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